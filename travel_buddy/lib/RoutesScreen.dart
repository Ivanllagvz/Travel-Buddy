// ignore_for_file: file_names, sized_box_for_whitespace, unused_local_variable, depend_on_referenced_packages, unused_import, unused_field, unnecessary_null_comparison
import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:http/http.dart' as http;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_compass/flutter_compass.dart';

class RoutesScreen extends StatefulWidget {
  const RoutesScreen({super.key});

  @override
  _RoutesScreenState createState() => _RoutesScreenState();
}

class _RoutesScreenState extends State<RoutesScreen> {
  GoogleMapController? mapController;
  TextEditingController destinationController = TextEditingController();
  Position? _currentPosition;
  final List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = 'AIzaSyD2OHP3337xvHedjQhGPVZfvPrVKh2ZlwE';
  FlutterTts flutterTts = FlutterTts();
  List<String> _instructions = [];
  List<LatLng> _instructionPoints = [];
  int _currentInstructionIndex = 0;
  StreamSubscription<Position>? _positionStreamSubscription;
  bool _isSatelliteView = false;
  BitmapDescriptor? _currentLocationIcon;
  bool _navigationStarted = false;
  String? _distance;
  String? _duration;
  double? _currentSpeed;
  List<int> _speedLimits = [];
  final int _currentSpeedLimit = 0;
  Timer? _speedCheckTimer;
  int _overSpeedTime = 0;
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _selectedIndex = 2;
  bool _avoidTolls = false;
  double _heading = 0.0;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    flutterTts.setLanguage("es-ES");
    flutterTts.setSpeechRate(0.5);
    _loadCustomMarker();
    _initCompass();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    ).listen((Position position) {
      setState(() {
        _currentPosition = position;
        _currentSpeed = position.speed * 3.6;
      });

      if (_navigationStarted && mapController != null) {
        mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      }

      if (_navigationStarted) {
        _checkProximityToNextInstruction();
        _checkSpeed();
      }
    });
  }

  Future<void> _loadCustomMarker() async {
    _currentLocationIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(12, 12)),
      'assets/current_location_icon.png',
    );
  }

  void _initCompass() {
    FlutterCompass.events?.listen((event) {
      setState(() {
        _heading = event.heading ?? 0;
      });
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _createRoute(String destination) async {
    if (_currentPosition == null) {
      return;
    }

    List<geocoding.Location> locations = await geocoding.locationFromAddress(destination);
    if (locations.isEmpty) {
      return;
    }

    LatLng destinationLatLng = LatLng(locations[0].latitude, locations[0].longitude);
    LatLng startLatLng = LatLng(_currentPosition!.latitude, _currentPosition!.longitude);

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPIKey,
      PointLatLng(startLatLng.latitude, startLatLng.longitude),
      PointLatLng(destinationLatLng.latitude, destinationLatLng.longitude),
      travelMode: TravelMode.driving,
      avoidTolls: _avoidTolls,
    );

    if (result.points.isNotEmpty) {
      setState(() {
        polylineCoordinates.clear();
        for (var point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
      });

      mapController!.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(
              result.points.first.latitude <= result.points.last.latitude
                  ? result.points.first.latitude
                  : result.points.last.latitude,
              result.points.first.longitude <= result.points.last.longitude
                  ? result.points.first.longitude
                  : result.points.last.longitude,
            ),
            northeast: LatLng(
              result.points.first.latitude >= result.points.last.latitude
                  ? result.points.first.latitude
                  : result.points.last.latitude,
              result.points.first.longitude >= result.points.last.longitude
                  ? result.points.first.longitude
                  : result.points.last.longitude,
            ),
          ),
          100,
        ),
      );

      await _getDistanceDurationInstructionsAndSpeedLimits(startLatLng, destinationLatLng);
    }
  }

  Future<void> _getDistanceDurationInstructionsAndSpeedLimits(LatLng start, LatLng destination) async {
    final String avoidTollsParam = _avoidTolls ? '&avoid=tolls' : '';
    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${start.latitude},${start.longitude}&destination=${destination.latitude},${destination.longitude}&key=$googleAPIKey&language=es$avoidTollsParam';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['routes'].isNotEmpty) {
        final route = data['routes'][0];
        final leg = route['legs'][0];
        setState(() {
          _distance = leg['distance']['text'];
          _duration = leg['duration']['text'];
          _instructions = leg['steps']
              .map<String>((step) => _cleanInstruction(step['html_instructions'] as String))
              .toList();
          _instructionPoints = leg['steps']
              .map<LatLng>((step) => LatLng(step['end_location']['lat'], step['end_location']['lng']))
              .toList();
          _speedLimits = leg['steps']
              .map<int>((step) => step['speed_limit'] ?? 50)
              .toList();
          _currentInstructionIndex = 0;
        });

        await flutterTts.speak("La distancia es $_distance y el tiempo estimado es $_duration.");
      }
    }
  }

  String _cleanInstruction(String instruction) {
    instruction = instruction.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ''); 
    instruction = instruction.replaceAll(RegExp(r'\bC\b'), 'Calle'); 
    instruction = instruction.replaceAll(RegExp(r'\bAv\b'), 'Avenida'); 
    instruction = instruction.replaceAll(RegExp(r'\bPl\b'), 'Plaza'); 
    return instruction;
  }

  Future<void> _startNavigation() async {
    setState(() {
      _navigationStarted = true;
      _distance = null;
    });
    if (_instructions.isNotEmpty) {
      await flutterTts.speak(_instructions[0]);
    }
  }

  void _checkProximityToNextInstruction() async {
    if (_currentPosition == null || _instructions.isEmpty || _currentInstructionIndex >= _instructionPoints.length) {
      return;
    }

    LatLng currentLatLng = LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
    LatLng nextInstructionLatLng = _instructionPoints[_currentInstructionIndex];

    double distance = Geolocator.distanceBetween(
      currentLatLng.latitude,
      currentLatLng.longitude,
      nextInstructionLatLng.latitude,
      nextInstructionLatLng.longitude,
    );

    if (distance < 100) {
      String instruction = _instructions[_currentInstructionIndex];
      await flutterTts.speak(instruction);
      await flutterTts.awaitSpeakCompletion(true);

      _currentInstructionIndex++;
    }

    if (_currentInstructionIndex == _instructionPoints.length) {
      await flutterTts.speak('Ha llegado a su destino.');
    }
  }

  void _checkSpeed() async {
    if (_currentSpeed != null && _currentSpeedLimit != null) {
      if (_currentSpeed! > _currentSpeedLimit + 30) {
        _overSpeedTime += 1;
        if (_overSpeedTime >= 60) {
          await _audioPlayer.play(AssetSource('assets/warning_beep.mp3'));
          flutterTts.speak('Ha superado la velocidad permitida.');
          _overSpeedTime = 0;
        }
      } else {
        _overSpeedTime = 0; 
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/activities');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/routes');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/weather');
        break;
      case 4:
        // Navegar a Eventos
        break;
    }
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color componentes = Color(0xFF218EBA);
    const Color fondo = Color(0xFFFFA500);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rutas & Gps',
          style: TextStyle(fontFamily: 'Pattaya', color: Colors.white),
        ),
        backgroundColor: componentes,
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(40.416775, -3.703790),
              zoom: 5,
            ),
            mapType: _isSatelliteView ? MapType.satellite : MapType.normal,
            polylines: {
              Polyline(
                polylineId: const PolylineId('route'),
                points: polylineCoordinates,
                color: Colors.blue,
                width: 5,
              ),
            },
            markers: _currentPosition != null
                ? {
                    Marker(
                      markerId: const MarkerId('currentLocation'),
                      position: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                      icon: _currentLocationIcon ?? BitmapDescriptor.defaultMarker,
                      rotation: _heading,
                    ),
                  }
                : {},
          ),
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: destinationController,
                decoration: InputDecoration(
                  hintText: 'Introduce tu destino',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(left: 15.0, top: 15.0),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      _createRoute(destinationController.text);
                    },
                  ),
                ),
              ),
            ),
          ),
          if (_distance != null && _duration != null)
            Positioned(
              bottom: 160,
              left: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Text(
                      'Distancia: $_distance',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Duración: $_duration',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          if (_navigationStarted)
            Positioned(
              bottom: 20,
              right: 10,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.red, width: 3),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: Text(
                    _currentSpeed != null ? _currentSpeed!.toStringAsFixed(0) : '0',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _isSatelliteView = !_isSatelliteView;
              });
            },
            backgroundColor: fondo,
            child: const Icon(Icons.map, color: componentes),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              _startNavigation();
            },
            backgroundColor: fondo,
            child: const Icon(Icons.navigation, color: componentes),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _avoidTolls = !_avoidTolls;
              });
              if (_currentPosition != null && destinationController.text.isNotEmpty) {
                _createRoute(destinationController.text);
              }
            },
            backgroundColor: fondo,
            child: Icon(
              _avoidTolls ? Icons.toll : Icons.money_off,
              color: componentes,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: fondo,
        selectedItemColor: componentes,
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/activities');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/routes');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/weather');
          } else if (index == 4) {
            Navigator.pushReplacementNamed(context, '/events');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity),
            label: 'Actividades',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Rutas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Tiempo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Eventos',
          ),
        ],
      ),
    );
  }
}
