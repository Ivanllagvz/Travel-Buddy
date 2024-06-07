// ignore_for_file: file_names, sized_box_for_whitespace, unused_local_variable, depend_on_referenced_packages, unused_import, unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService weatherService = WeatherService();
  late Future<Map<String, dynamic>> weatherDataFuture;
  String selectedCity = 'Madrid';
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<Map<String, String>> touristCities = [
    {'name': 'Madrid', 'country': 'España'},
    {'name': 'París', 'country': 'Francia'},
    {'name': 'Nueva York', 'country': 'Estados Unidos'},
    {'name': 'Tokio', 'country': 'Japón'},
    {'name': 'Londres', 'country': 'Reino Unido'},
    {'name': 'Roma', 'country': 'Italia'},
    {'name': 'Bangkok', 'country': 'Tailandia'},
    {'name': 'Buenos Aires', 'country': 'Argentina'},
    {'name': 'Corrientes', 'country': 'Argentina'},
    {'name': 'Toronto', 'country': 'Canadá'},
    {'name': 'Ciudad de México', 'country': 'México'},
    {'name': 'El Cairo', 'country': 'Egipto'},
    {'name': 'Hong Kong', 'country': 'China'},
  ];

  @override
  void initState() {
    super.initState();
    weatherDataFuture = _getCurrentLocationAndFetchWeather();
  }

  Future<Map<String, dynamic>> _getCurrentLocationAndFetchWeather() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        String city = placemarks.first.locality ?? 'Madrid';
        setState(() {
          selectedCity = city;
          if (!touristCities.any((element) => element['name'] == city)) {
            touristCities.add({'name': city, 'country': placemarks.first.country ?? ''});
          }
        });
        playBackgroundSoundForCity(selectedCity);
        return weatherService.fetchWeatherData(selectedCity);
      } else {
        return _initializeDefaultWeather();
      }
    } catch (e) {
      return _initializeDefaultWeather();
    }
  }

  Future<Map<String, dynamic>> _initializeDefaultWeather() {
    setState(() {
      selectedCity = 'Madrid';
    });
    playBackgroundSoundForCity(selectedCity);
    return weatherService.fetchWeatherData(selectedCity);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  String getBackgroundGif(String icon) {
    switch (icon) {
      case '01d':
      case '01n':
        return 'assets/gifs/sunny.gif';
      case '09d':
      case '09n':
      case '10d':
      case '10n':
        return 'assets/gifs/rainy.gif';
      case '13d':
      case '13n':
        return 'assets/gifs/snowy.gif';
      case '11d':
      case '11n':
        return 'assets/gifs/thunderstorm.gif';
      case '50d':
      case '50n':
        return 'assets/gifs/foggy.gif';
      default:
        return 'assets/gifs/cloudy.gif';
    }
  }

  String getBackgroundSound(String icon) {
    switch (icon) {
      case '01d':
      case '01n':
        return 'assets/sunny.mp3';
      case '09d':
      case '09n':
      case '10d':
      case '10n':
        return 'assets/rainy.mp3';
      case '11d':
      case '11n':
        return 'assets/thunderstorm.mp3';
      case '13d':
      case '13n':
        return 'assets/snowy.mp3';
      case '03d':
      case '03n':
      case '04d':
      case '04n':
        return 'assets/cloudy.mp3';
      default:
        return '';
    }
  }

  Future<void> playBackgroundSoundForCity(String city) async {
    try {
      final weatherData = await weatherService.fetchWeatherData(city);
      final icon = weatherData['weatherData']['weather'][0]['icon'];
      String soundPath = getBackgroundSound(icon);
      if (soundPath.isNotEmpty) {
        await _audioPlayer.setLoopMode(LoopMode.all);
        await _audioPlayer.setAsset(soundPath);
        await _audioPlayer.play();
      } else {
        await _audioPlayer.stop();
      }
    } catch (e) {
      // Handle any errors that might occur
    }
  }

  void _updateWeatherData(String city) {
    setState(() {
      selectedCity = city;
      weatherDataFuture = weatherService.fetchWeatherData(city);
      playBackgroundSoundForCity(city);
    });
  }

  Widget buildWeatherAnimation(String icon) {
    switch (icon) {
      case '01d':
      case '01n':
        return Image.asset('assets/sunny.gif', width: 100, height: 100);
      case '09d':
      case '09n':
      case '10d':
      case '10n':
        return Image.asset('assets/rainy.gif', width: 100, height: 100);
      case '13d':
      case '13n':
        return Image.asset('assets/snowy.gif', width: 100, height: 100);
      case '11d':
      case '11n':
        return Image.asset('assets/thunderstorm.gif', width: 100, height: 100);
      case '50d':
      case '50n':
        return Image.asset('assets/foggy.gif', width: 100, height: 100);
      default:
        return Image.asset('assets/cloudy.gif', width: 100, height: 100);
    }
  }

  Widget buildWeeklyForecast(Map<String, dynamic> forecastData) {
    List<Widget> forecastWidgets = [];
    for (int i = 0; i < forecastData['list'].length; i += 8) {
      var forecast = forecastData['list'][i];
      forecastWidgets.add(
        Container(
          width: 100,
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text(
                '${forecast['dt_txt'].substring(0, 10)}',
                style: GoogleFonts.lato(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              buildWeatherAnimation(forecast['weather'][0]['icon']),
              Text(
                '${forecast['main']['temp'].toStringAsFixed(1)}°C',
                style: GoogleFonts.lato(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      );
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: forecastWidgets,
      ),
    );
  }

  Widget buildHourlyForecast(Map<String, dynamic> forecastData) {
    List<Widget> forecastWidgets = [];
    for (var forecast in forecastData['list'].sublist(0, 8)) {
      forecastWidgets.add(
        Container(
          width: 80,
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text(
                '${forecast['dt_txt'].substring(11, 16)}',
                style: GoogleFonts.lato(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              buildWeatherAnimation(forecast['weather'][0]['icon']),
              Text(
                '${forecast['main']['temp'].toStringAsFixed(1)}°C',
                style: GoogleFonts.lato(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      );
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: forecastWidgets,
      ),
    );
  }

  Widget buildSunriseSunset(String sunrise, String sunset) {
    return Column(
      children: [
        Text(
          'Amanecer: $sunrise',
          style: GoogleFonts.lato(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        Text(
          'Atardecer: $sunset',
          style: GoogleFonts.lato(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget buildWindDetails(Map<String, dynamic> windData) {
    return Column(
      children: [
        Text(
          'Velocidad del Viento: ${windData['speed']} m/s',
          style: GoogleFonts.lato(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        Text(
          'Dirección del Viento: ${windData['deg']}°',
          style: GoogleFonts.lato(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color componentes = Color(0xFF218EBA);
    const Color fondo = Color(0xFFFFA500);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tiempo',
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
      body: FutureBuilder<Map<String, dynamic>>(
        future: weatherDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los datos del clima'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No se encontraron datos del clima'));
          } else {
            final weatherData = snapshot.data!['weatherData'];
            final forecastData = snapshot.data!['forecastData'];

            final currentHour = DateTime.now().hour;
            final isDayTime = currentHour >= 6 && currentHour < 18;
            final backgroundImage = isDayTime ? 'assets/ciudad_dia.jpg' : 'assets/ciudad.jpg';
            final backgroundGif = getBackgroundGif(weatherData['weather'][0]['icon']);

            String sunrise = DateTime.fromMillisecondsSinceEpoch(weatherData['sys']['sunrise'] * 1000)
                .toLocal()
                .toString()
                .substring(11, 16);
            String sunset = DateTime.fromMillisecondsSinceEpoch(weatherData['sys']['sunset'] * 1000)
                .toLocal()
                .toString()
                .substring(11, 16);

            return Stack(
              children: [
                Center(
                  child: Image.asset(
                    backgroundGif,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.5),
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      DropdownButton<String>(
                        value: touristCities.any((city) => city['name'] == selectedCity)
                            ? selectedCity
                            : null,
                        dropdownColor: componentes,
                        style: const TextStyle(color: Colors.white),
                        onChanged: (String? newCity) {
                          if (newCity != null) {
                            _updateWeatherData(newCity);
                          }
                        },
                        items: touristCities.map<DropdownMenuItem<String>>((Map<String, String> city) {
                          return DropdownMenuItem<String>(
                            value: city['name'],
                            child: Text('${city['name']}, ${city['country']}'),
                          );
                        }).toList(),
                      ),
                      Text(
                        '${weatherData['name']}',
                        style: GoogleFonts.lato(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      buildWeatherAnimation(weatherData['weather'][0]['icon']),
                      Text(
                        '${weatherData['main']['temp'].toStringAsFixed(1)}°C',
                        style: GoogleFonts.lato(
                          fontSize: 46,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${weatherData['weather'][0]['description']}',
                        style: GoogleFonts.lato(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Humedad: ${weatherData['main']['humidity']}%',
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Sensación Térmica: ${weatherData['main']['feels_like'].toStringAsFixed(1)}°C',
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Presión: ${weatherData['main']['pressure']} hPa',
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      buildWindDetails(weatherData['wind']),
                      buildSunriseSunset(sunrise, sunset),
                      const SizedBox(height: 20),
                      Text(
                        'Previsión Horaria',
                        style: GoogleFonts.lato(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      buildHourlyForecast(forecastData),
                      const SizedBox(height: 20),
                      Text(
                        'Previsión Semanal',
                        style: GoogleFonts.lato(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      buildWeeklyForecast(forecastData),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: fondo,
        selectedItemColor: componentes,
        unselectedItemColor: Colors.black,
        currentIndex: 3,
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
