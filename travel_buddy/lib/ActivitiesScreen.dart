import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_buddy/GastronomyDetailsScreen.dart';
import 'package:travel_buddy/InterestingPlacesDetailsScreen.dart';
import 'package:travel_buddy/RestaurantDetailsScreen.dart';
import 'BeachDetailsScreen.dart';
import 'HikingDetailsScreen.dart';
import 'museum_details_screen.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  _ActivitiesScreenState createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  final List<Map<String, String>> activities = [
    {
      'title': 'Museos',
      'image': 'assets/activities/museums.jpg',
      'description': 'Descubra los museos más importantes de la ciudad.'
    },
    {
      'title': 'Rutas de Senderismo',
      'image': 'assets/activities/hiking.jpg',
      'description': 'Explore las mejores rutas de senderismo.'
    },
    {
      'title': 'Playas',
      'image': 'assets/activities/beaches.jpg',
      'description': 'Relájese en las playas más hermosas.'
    },
    {
      'title': 'Lugares Interesantes',
      'image': 'assets/activities/places.jpg',
      'description': 'Visite los lugares más interesantes.'
    },
        {
      'title': 'Restauración',
      'image': 'assets/activities/restaurants.jpg',
      'description': 'Eche un vistazo a los restauranted mejor valorados.'
    },
    {
      'title': 'Gastronomía',
      'image': 'assets/activities/gastronomy.jpg',
      'description': 'Disfrute de la comida típica de la ciudad.'
    },
  ];

  final List<Map<String, String>> museumCities = [
    {'name': 'Madrid', 'image': 'assets/ciudades/madrid.jpg'},
    {'name': 'Barcelona', 'image': 'assets/ciudades/barcelona.jpg'},
    {'name': 'Bilbao', 'image': 'assets/ciudades/bilbao.jpg'},
    {'name': 'París', 'image': 'assets/ciudades/paris.jpg'},
    {'name': 'Roma', 'image': 'assets/ciudades/rome.jpg'},
    {'name': 'Florencia', 'image': 'assets/ciudades/florencia.jpg'},
    {'name': 'Berlín', 'image': 'assets/ciudades/berlin.jpg'},
    {'name': 'Londres', 'image': 'assets/ciudades/london.jpg'},
    {'name': 'Ámsterdam', 'image': 'assets/ciudades/amsterdam.jpg'},
    {'name': 'Nueva York', 'image': 'assets/ciudades/newyork.jpg'},
  ];

  final List<Map<String, String>> hikingCities = [
    {'name': 'Madrid', 'image': 'assets/ciudades/madrid.jpg'},
    {'name': 'Granada', 'image': 'assets/ciudades/granada.jpg'},
    {'name': 'Santander', 'image': 'assets/ciudades/santander.jpg'},
    {'name': 'Zúrich', 'image': 'assets/ciudades/zurich.jpg'},
    {'name': 'Múnich', 'image': 'assets/ciudades/munich.jpg'},
    {'name': 'Edimburgo', 'image': 'assets/ciudades/edinburgh.jpg'},
    {'name': 'Lisboa', 'image': 'assets/ciudades/lisbon.jpg'},
    {'name': 'Tokio', 'image': 'assets/ciudades/tokyo.jpg'},
    {'name': 'Río de Janeiro', 'image': 'assets/ciudades/rio.jpg'},
    {'name': 'Sídney', 'image': 'assets/ciudades/sydney.jpg'},
  ];

  final List<Map<String, String>> beachCities = [
    {'name': 'Barcelona', 'image': 'assets/ciudades/barcelona.jpg'},
    {'name': 'Niza', 'image': 'assets/ciudades/nice.jpg'},
    {'name': 'Marsella', 'image': 'assets/ciudades/marsella.jpg'},
    {'name': 'Los Ángeles', 'image': 'assets/ciudades/losangeles.jpg'},
    {'name': 'Las Vegas', 'image': 'assets/ciudades/vegas.jpg'},
    {'name': 'Buenos Aires', 'image': 'assets/ciudades/buenosaires.jpg'},
  ];

  final List<Map<String, String>> interestingPlacesCities = [
    {'name': 'Madrid', 'image': 'assets/ciudades/madrid.jpg'},
    {'name': 'Sevilla', 'image': 'assets/ciudades/sevilla.jpg'},
    {'name': 'Granada', 'image': 'assets/ciudades/granada.jpg'},
    {'name': 'Santander', 'image': 'assets/ciudades/santander.jpg'},
    {'name': 'Burdeos', 'image': 'assets/ciudades/burdeos.jpg'},
    {'name': 'Estrasburgo', 'image': 'assets/ciudades/estrasburgo.jpg'},
    {'name': 'Venecia', 'image': 'assets/ciudades/venice.jpg'},
    {'name': 'Milán', 'image': 'assets/ciudades/milan.jpg'},
    {'name': 'Pisa', 'image': 'assets/ciudades/pisa.jpg'},
    {'name': 'Frankfurt', 'image': 'assets/ciudades/frankfurt.jpg'},
    {'name': 'Chicago', 'image': 'assets/ciudades/chicago.jpg'},
  ];

  final List<Map<String, String>> restaurantCities = [
    {'name': 'Madrid', 'image': 'assets/ciudades/madrid.jpg'},
    {'name': 'París', 'image': 'assets/ciudades/paris.jpg'},
    {'name': 'Tokio', 'image': 'assets/ciudades/tokyo.jpg'},
    {'name': 'Lyon', 'image': 'assets/ciudades/lyon.jpg'},
    {'name': 'Bologna', 'image': 'assets/ciudades/bolonia.jpg'},
    {'name': 'Nueva York', 'image': 'assets/ciudades/newyork.jpg'},
    {'name': 'Bangkok', 'image': 'assets/ciudades/bangkok.jpg'},
    {'name': 'San Sebastián', 'image': 'assets/ciudades/sansebastian.jpg'},
    {'name': 'Roma', 'image': 'assets/ciudades/rome.jpg'},
    {'name': 'Lisboa', 'image': 'assets/ciudades/lisbon.jpg'},
  ];

  final List<Map<String, String>> gastronomyCities = [
    {'name': 'Madrid', 'image': 'assets/ciudades/madrid.jpg'},
    {'name': 'París', 'image': 'assets/ciudades/paris.jpg'},
    {'name': 'Tokio', 'image': 'assets/ciudades/tokyo.jpg'},
    {'name': 'Lyon', 'image': 'assets/ciudades/lyon.jpg'},
    {'name': 'Bologna', 'image': 'assets/ciudades/bolonia.jpg'},
    {'name': 'Nueva York', 'image': 'assets/ciudades/newyork.jpg'},
    {'name': 'Bangkok', 'image': 'assets/ciudades/bangkok.jpg'},
    {'name': 'San Sebastián', 'image': 'assets/ciudades/sansebastian.jpg'},
    {'name': 'Roma', 'image': 'assets/ciudades/rome.jpg'},
    {'name': 'Lisboa', 'image': 'assets/ciudades/lisbon.jpg'},
  ];

  final Map<String, bool> expandedStates = {};

  @override
  void initState() {
    super.initState();
    for (var activity in activities) {
      expandedStates[activity['title']!] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color componentes = Color(0xFF218EBA);
    const Color fondo = Color(0xFFFFA500);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Actividades',
          style: TextStyle(fontFamily: 'Pattaya', color: Colors.white),
        ),
        backgroundColor: componentes,
        centerTitle: true,
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
        child: ListView.builder(
          itemCount: activities.length,
          itemBuilder: (context, index) {
            final activity = activities[index];
            final isExpanded = expandedStates[activity['title']] ?? false;

            return GestureDetector(
              onTap: () {
                setState(() {
                  expandedStates[activity['title']!] = !isExpanded;
                });
              },
              child: Card(
                margin: const EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: componentes,
                elevation: 5,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                      child: Image.asset(
                        activity['image']!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            activity['title']!,
                            style: GoogleFonts.lato(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            activity['description']!,
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          if (isExpanded)
                            Column(
                              children: getCitiesForActivity(activity['title']!)
                                  .map((city) {
                                return ListTile(
                                  leading: Image.asset(
                                    city['image']!,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                  title: Text(
                                    city['name']!,
                                    style: GoogleFonts.lato(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onTap: () {
                                    if (activity['title'] == 'Museos') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MuseumDetailsScreen(
                                            cityName: city['name']!,
                                          ),
                                        ),
                                      );
                                    } else if (activity['title'] ==
                                        'Rutas de Senderismo') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              HikingDetailsScreen(
                                            cityName: city['name']!,
                                          ),
                                        ),
                                      );
                                    } else if (activity['title'] == 'Playas') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BeachDetailsScreen(
                                            cityName: city['name']!,
                                          ),
                                        ),
                                      );
                                    } else if (activity['title'] =='Lugares Interesantes') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              InterestingPlacesDetailsScreen(
                                            cityName: city['name']!,
                                          ),
                                        ),
                                      );
                                    } else if (activity['title'] =='Restauración') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RestaurantDetailsScreen(
                                            cityName: city['name']!,
                                          ),
                                        ),
                                      );
                                    } else if (activity['title'] =='Gastronomía') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              GastronomyDetailsScreen(
                                            cityName: city['name']!,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                );
                              }).toList(),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: fondo,
        selectedItemColor: componentes,
        unselectedItemColor: Colors.black,
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            // Ya estamos en esta pantalla, no hace nada
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

  List<Map<String, String>> getCitiesForActivity(String activity) {
    switch (activity) {
      case 'Museos':
        return museumCities;
      case 'Rutas de Senderismo':
        return hikingCities;
      case 'Playas':
        return beachCities;
      case 'Lugares Interesantes':
        return interestingPlacesCities;
      case 'Restauración':
        return restaurantCities;
      case 'Gastronomía':
        return gastronomyCities;
      default:
        return [];
    }
  }
}
