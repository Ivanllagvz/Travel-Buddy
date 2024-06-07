// ignore_for_file: file_names, sized_box_for_whitespace

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tcard/tcard.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GoogleMapController? mapController;
  final TextEditingController countryController = TextEditingController();
  final List<Map<String, String>> cities = [];
  Map<String, dynamic> countries = {};
  Map<String, LatLng> countryCoordinates = {};
  final TCardController _tcardController = TCardController();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    loadCountriesData();
    loadCountryCoordinates();
  }

  Future<void> loadCountriesData() async {
    final String response = await rootBundle.loadString('assets/paises.json');
    final data = await json.decode(response);
    setState(() {
      countries = data;
    });
  }

  void loadCountryCoordinates() {
    countryCoordinates = {
      'españa': const LatLng(40.463667, -3.74922),
      'francia': const LatLng(46.603354, 1.888334),
      'italia': const LatLng(41.87194, 12.56738),
      'alemania': const LatLng(51.165691, 10.451526),
      'reino unido': const LatLng(55.378051, -3.435973),
      'grecia': const LatLng(39.074208, 21.824312),
      'portugal': const LatLng(39.399872, -8.224454),
      'países bajos': const LatLng(52.132633, 5.291266),
      'suiza': const LatLng(46.818188, 8.227512),
      'japón': const LatLng(36.204824, 138.252924),
      'china': const LatLng(35.86166, 104.195397),
      'tailandia': const LatLng(15.870032, 100.992541),
      'india': const LatLng(20.593684, 78.96288),
      'estados unidos': const LatLng(37.09024, -95.712891),
      'canadá': const LatLng(56.130366, -106.346771),
      'brasil': const LatLng(-14.235004, -51.92528),
      'argentina': const LatLng(-38.416097, -63.616672),
      'australia': const LatLng(-25.274398, 133.775136),
      'nueva zelanda': const LatLng(-40.900557, 174.885971),
      'sudáfrica': const LatLng(-30.559482, 22.937506),
      'egipto': const LatLng(26.820553, 30.802498),
      'fiyi': const LatLng(-17.713371, 178.065032),
      'indonesia': const LatLng(-0.789275, 113.921327),
    };
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _updateCities() {
    final String country = countryController.text.toLowerCase().trim();
    setState(() {
      cities.clear();
      if (countries.containsKey(country)) {
        for (var city in countries[country]) {
          cities.add({'name': city['name'], 'image': city['image']});
        }
      }
      _tcardController.reset(cards: _buildCards());
    });

    if (countryCoordinates.containsKey(country) && mapController != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(countryCoordinates[country]!, 5),
      );
    }
  }

  List<Widget> _buildCards() {
    if (cities.isEmpty) {
      return [
        const Center(
          child: Text(
            'No cities found',
            style: TextStyle(color: Colors.white),
          ),
        )
      ];
    }
    return cities.map((city) {
      return Card(
        child: Stack(
          children: [
            Image.asset(
              city['image']!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Text(
                city['name']!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  backgroundColor: Colors.black45,
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
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
        // Add the corresponding action for "Actividades"
        break;
      case 2:
        Navigator.pushNamed(context, '/routes');
        break;
      case 3:
        Navigator.pushNamed(context, '/weather');
        break;
      case 4:
        // Add the corresponding action for "Eventos"
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color componentes = Color(0xFF218EBA);
    const Color fondo = Color(0xFFFFA500);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Travel Buddy',
          style: TextStyle(fontFamily: 'Pattaya', color: Colors.white),
        ),
        backgroundColor: componentes,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [componentes, fondo],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Introduzca un país para visualizar ciudades interesantes.',
                style: TextStyle(
                  fontFamily: 'Times New Roman',
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            Stack(
              children: [
                Container(
                  height: 200,
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(40.416775, -3.703790),
                      zoom: 5,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: IgnorePointer(
                    child: Image.asset(
                      'assets/lianas.png',
                      fit: BoxFit.cover,
                      height: 170,
                      width: double.infinity,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Center(
              child: Container(
                width: 200,
                child: TextField(
                  controller: countryController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: componentes,
                    hintText: 'País deseado',
                    hintStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: fondo,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: fondo,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: fondo,
                        width: 2,
                      ),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onSubmitted: (value) {
                    _updateCities();
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TCard(
                controller: _tcardController,
                size: const Size(double.infinity, double.infinity),
                cards: _buildCards(),
              ),
            ),
          ],
        ),
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
