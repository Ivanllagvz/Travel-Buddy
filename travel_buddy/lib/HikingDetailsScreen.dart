import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HikingDetailsScreen extends StatelessWidget {
  final String cityName;

  const HikingDetailsScreen({required this.cityName});

  @override
  Widget build(BuildContext context) {
    const Color componentes = Color(0xFF218EBA);
    const Color fondo = Color(0xFFFFA500);

    final hikingRoutes = getHikingRoutesForCity(cityName);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Senderismo en $cityName',
          style: const TextStyle(fontFamily: 'Pattaya', color: Colors.white),
        ),
        backgroundColor: componentes,
        centerTitle: true,
      ),
      body: Container(
        color: fondo,
        child: Swiper(
          itemCount: hikingRoutes.length,
          itemBuilder: (BuildContext context, int index) {
            final hikingRoute = hikingRoutes[index];
            return Card(
              margin: const EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: componentes,
              elevation: 5,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height * 0.4,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                        ),
                        items: hikingRoute['images']!.map<Widget>((image) {
                          return Image.asset(
                            image,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          );
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hikingRoute['name']!,
                            style: GoogleFonts.lato(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            hikingRoute['description']!,
                            style: GoogleFonts.lato(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Distancia: ${hikingRoute['distance']!}',
                            style: GoogleFonts.lato(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Duración: ${hikingRoute['duration']!}',
                            style: GoogleFonts.lato(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Ubicación: ${hikingRoute['location']!}',
                            style: GoogleFonts.lato(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          control: const SwiperControl(),
          pagination: const SwiperPagination(),
          loop: true,
        ),
      ),
    );
  }

  List<Map<String, dynamic>> getHikingRoutesForCity(String cityName) {
    switch (cityName) {
      case 'Madrid':
        return [
          {
            'name': 'Camino Schmidtr',
            'images': [
              'assets/hiking/Madrid/Schmidtr.jpg',
              'assets/hiking/Madrid/Schmidtr2.jpg',
              'assets/hiking/Madrid/Schmidtr3.jpg'
            ],
            'description': 'Una ruta por el camino clásico de la sierra del Guadarrama.',
            'distance': '16 km',
            'duration': '3 horas',
            'location': 'Navacerrada, Madrid, España',
          },
          {
            'name': 'Cañones del río Lozoya',
            'images': [
              'assets/hiking/Madrid/Lozoya.jpg',
              'assets/hiking/Madrid/Lozoya2.jpg',
              'assets/hiking/Madrid/Lozoya3.jpg'
            ],
            'description': 'La ruta sigue el curso del río, aunque a veces también nos topamos con el Jarama.',
            'distance': '8 km',
            'duration': '2 horas',
            'location': 'Rio Lozoya, Madrid, España',
          },
          {
            'name': 'Senda del Cancho de los muertos',
            'images': [
              'assets/hiking/Madrid/muertos.jpg',
              'assets/hiking/Madrid/muertos2.jpg',
              'assets/hiking/Madrid/muertos3.JPG'
            ],
            'description': 'La senda no es complicada, salvo que queramos subir al Cáliz o al propio Cancho, entonces necesitaremos material de escalada.',
            'distance': '6,5 km',
            'duration': '3 horas',
            'location': 'La Pedriza, Madrid, España',
          },
        ];
      case 'Granada':
        return [
          {
            'name': 'Sendero del Río Chillar',
            'images': [
              'assets/hiking/Granada/riochillar.jpg',
              'assets/hiking/Granada/riochillar2.jpg',
              'assets/hiking/Granada/riochillar3.jpg'
            ],
            'description': 'Una ruta refrescante que sigue el curso del río Chillar.',
            'distance': '8 km',
            'duration': '4 horas',
            'location': 'Nerja, Granada, España',
          },
          {
            'name': 'Vereda de la Estrella',
            'images': [
              'assets/hiking/Granada/veredalaestrella.jpg',
              'assets/hiking/Granada/veredalaestrella2.jpg',
              'assets/hiking/Granada/veredalaestrella3.jpg'
            ],
            'description': 'Una de las rutas más espectaculares de Sierra Nevada.',
            'distance': '21 km',
            'duration': '5 horas',
            'location': 'Güejar Sierra, Granada, España',
          },
          {
            'name': 'Cahorros de Monachil',
            'images': [
              'assets/hiking/Granada/cahorros.jpg',
              'assets/hiking/Granada/cahorros2.jpg',
              'assets/hiking/Granada/cahorros3.jpg'
            ],
            'description': 'Ruta a través de desfiladeros y puentes colgantes.',
            'distance': '8 km',
            'duration': '2 horas',
            'location': 'Monachil, Granada, España',
          },
        ];
      case 'Santander':
        return [
          {
            'name': 'Parque Natural de las Dunas de Liencres',
            'images': [
              'assets/hiking/Santander/liencres.jpg',
              'assets/hiking/Santander/liencres2.jpg',
              'assets/hiking/Santander/liencres3.jpg'
            ],
            'description': 'Ruta a través de dunas y playas en un entorno natural protegido.',
            'distance': '5 km',
            'duration': '1,5 horas',
            'location': 'Liencres, Cantabria, España',
          },
          {
            'name': 'Ruta del Cares',
            'images': [
              'assets/hiking/Santander/cares.jpg',
              'assets/hiking/Santander/cares2.jpg',
              'assets/hiking/Santander/cares3.jpg'
            ],
            'description': 'Una de las rutas más impresionantes de los Picos de Europa.',
            'distance': '12 km',
            'duration': '4 horas',
            'location': 'Poncebos, Asturias, España',
          },
          {
            'name': 'Monte Buciero',
            'images': [
              'assets/hiking/Santander/buciero.jpg',
              'assets/hiking/Santander/buciero2.jpg',
              'assets/hiking/Santander/buciero3.jpg'
            ],
            'description': 'Ruta que ofrece vistas espectaculares de la costa y el mar Cantábrico.',
            'distance': '7 km',
            'duration': '3 horas',
            'location': 'Santoña, Cantabria, España',
          },
        ];
      case 'Zúrich':
        return [
          {
            'name': 'Uetliberg Mountain',
            'images': [
              'assets/hiking/Zúrich/uetliberg.jpg',
              'assets/hiking/Zúrich/uetliberg2.jpg',
              'assets/hiking/Zúrich/uetliberg3.jpg'
            ],
            'description': 'Una caminata hasta la cima del Uetliberg con vistas panorámicas de Zúrich.',
            'distance': '10 km',
            'duration': '3 horas',
            'location': 'Zúrich, Suiza',
          },
          {
            'name': 'Pfannenstiel',
            'images': [
              'assets/hiking/Zúrich/pfannenstiel.jpg',
              'assets/hiking/Zúrich/pfannenstiel2.jpg',
              'assets/hiking/Zúrich/pfannenstiel3.jpg'
            ],
            'description': 'Ruta a través de bosques y prados con vistas al lago de Zúrich.',
            'distance': '12 km',
            'duration': '4 horas',
            'location': 'Zúrich, Suiza',
          },
          {
            'name': 'Käferberg-Waidberg',
            'images': [
              'assets/hiking/Zúrich/kaferberg.jpg',
              'assets/hiking/Zúrich/kaferberg2.jpg',
              'assets/hiking/Zúrich/kaferberg3.jpg'
            ],
            'description': 'Ruta fácil que ofrece vistas de la ciudad y las montañas circundantes.',
            'distance': '8 km',
            'duration': '2.5 horas',
            'location': 'Zúrich, Suiza',
          },
        ];
      case 'Múnich':
        return [
          {
            'name': 'Sendero del Río Isar',
            'images': [
              'assets/hiking/Múnich/isar.jpg',
              'assets/hiking/Múnich/isar2.jpg',
              'assets/hiking/Múnich/isar3.jpg'
            ],
            'description': 'Una ruta a lo largo del río Isar, perfecta para un paseo relajante.',
            'distance': '7 km',
            'duration': '2 horas',
            'location': 'Múnich, Alemania',
          },
          {
            'name': 'Lago Eibsee',
            'images': [
              'assets/hiking/Múnich/eibsee.jpg',
              'assets/hiking/Múnich/eibsee2.jpg',
              'assets/hiking/Múnich/eibsee3.jpg'
            ],
            'description': 'Ruta alrededor del hermoso lago Eibsee, con vistas al Zugspitze.',
            'distance': '8 km',
            'duration': '2.5 horas',
            'location': 'Garmisch-Partenkirchen, Alemania',
          },
          {
            'name': 'Parque Natural de Ammergebirge',
            'images': [
              'assets/hiking/Múnich/ammergebirge.jpg',
              'assets/hiking/Múnich/ammergebirge2.jpg',
              'assets/hiking/Múnich/ammergebirge3.jpg'
            ],
            'description': 'Una ruta a través de montañas y valles en el parque natural de Ammergebirge.',
            'distance': '15 km',
            'duration': '5 horas',
            'location': 'Oberammergau, Alemania',
          },
        ];
      case 'Edimburgo':
        return [
          {
            'name': 'Arthur’s Seat',
            'images': [
              'assets/hiking/Edimburgo/arthursseat.jpg',
              'assets/hiking/Edimburgo/arthursseat2.jpg',
              'assets/hiking/Edimburgo/arthursseat3.jpg'
            ],
            'description': 'Una caminata hasta la cima de un antiguo volcán con vistas espectaculares de Edimburgo.',
            'distance': '4.8 km',
            'duration': '2 horas',
            'location': 'Edimburgo, Escocia',
          },
          {
            'name': 'Pentland Hills',
            'images': [
              'assets/hiking/Edimburgo/pentland.jpg',
              'assets/hiking/Edimburgo/pentland2.jpg',
              'assets/hiking/Edimburgo/pentland3.jpg'
            ],
            'description': 'Ruta a través de colinas y valles en el parque regional de Pentland Hills.',
            'distance': '10 km',
            'duration': '4 horas',
            'location': 'Edimburgo, Escocia',
          },
          {
            'name': 'Water of Leith Walkway',
            'images': [
              'assets/hiking/Edimburgo/waterofleith.jpg',
              'assets/hiking/Edimburgo/waterofleith2.jpg',
              'assets/hiking/Edimburgo/waterofleith3.jpg'
            ],
            'description': 'Sendero que sigue el curso del río Water of Leith a través de Edimburgo.',
            'distance': '12.25 km',
            'duration': '3.5 horas',
            'location': 'Edimburgo, Escocia',
          },
        ];
      case 'Lisboa':
        return [
          {
            'name': 'Parque Natural de Sintra-Cascais',
            'images': [
              'assets/hiking/Lisboa/sintra.jpg',
              'assets/hiking/Lisboa/sintra2.jpg',
              'assets/hiking/Lisboa/sintra3.jpg'
            ],
            'description': 'Ruta a través de paisajes naturales impresionantes en el parque natural de Sintra-Cascais.',
            'distance': '10 km',
            'duration': '3.5 horas',
            'location': 'Sintra, Portugal',
          },
          {
            'name': 'Costa da Caparica',
            'images': [
              'assets/hiking/Lisboa/caparica.jpg',
              'assets/hiking/Lisboa/caparica2.jpg',
              'assets/hiking/Lisboa/caparica3.jpg'
            ],
            'description': 'Ruta costera con vistas al océano Atlántico.',
            'distance': '6 km',
            'duration': '2 horas',
            'location': 'Caparica, Portugal',
          },
          {
            'name': 'Monsanto Forest Park',
            'images': [
              'assets/hiking/Lisboa/monsanto.jpg',
              'assets/hiking/Lisboa/monsanto2.jpg',
              'assets/hiking/Lisboa/monsanto3.jpg'
            ],
            'description': 'Sendero a través del mayor parque forestal de Lisboa.',
            'distance': '8 km',
            'duration': '2.5 horas',
            'location': 'Lisboa, Portugal',
          },
        ];
      case 'Tokio':
        return [
          {
            'name': 'Monte Takao',
            'images': [
              'assets/hiking/Tokio/takao.jpg',
              'assets/hiking/Tokio/takao2.jpg',
              'assets/hiking/Tokio/takao3.jpg'
            ],
            'description': 'Una caminata popular con vistas espectaculares y templos históricos.',
            'distance': '5.5 km',
            'duration': '2 horas',
            'location': 'Hachioji, Tokio, Japón',
          },
          {
            'name': 'Monte Mitake',
            'images': [
              'assets/hiking/Tokio/mitake.jpg',
              'assets/hiking/Tokio/mitake2.jpg',
              'assets/hiking/Tokio/mitake3.jpg'
            ],
            'description': 'Ruta a través de bosques y montañas hasta el templo Musashi Mitake.',
            'distance': '7 km',
            'duration': '3 horas',
            'location': 'Ome, Tokio, Japón',
          },
          {
            'name': 'Okutama',
            'images': [
              'assets/hiking/Tokio/okutama.jpg',
              'assets/hiking/Tokio/okutama2.jpg',
              'assets/hiking/Tokio/okutama3.jpg'
            ],
            'description': 'Sendero a través de la naturaleza virgen de Okutama.',
            'distance': '10 km',
            'duration': '4 horas',
            'location': 'Okutama, Tokio, Japón',
          },
        ];
      case 'Río de Janeiro':
        return [
          {
            'name': 'Trilha Dois Irmãos',
            'images': [
              'assets/hiking/Río/doisirmaos.jpg',
              'assets/hiking/Río/doisirmaos2.jpg',
              'assets/hiking/Río/doisirmaos3.jpg'
            ],
            'description': 'Ruta con vistas impresionantes de Río de Janeiro desde el Morro Dois Irmãos.',
            'distance': '1.5 km',
            'duration': '1 hora',
            'location': 'Río de Janeiro, Brasil',
          },
          {
            'name': 'Parque Nacional da Tijuca',
            'images': [
              'assets/hiking/Río/tijuca.jpg',
              'assets/hiking/Río/tijuca2.jpg',
              'assets/hiking/Río/tijuca3.jpg'
            ],
            'description': 'Sendero a través de la selva tropical urbana más grande del mundo.',
            'distance': '6 km',
            'duration': '3 horas',
            'location': 'Río de Janeiro, Brasil',
          },
          {
            'name': 'Pedra da Gávea',
            'images': [
              'assets/hiking/Río/gavea.jpg',
              'assets/hiking/Río/gavea2.jpg',
              'assets/hiking/Río/gavea3.jpg'
            ],
            'description': 'Ruta desafiante con vistas espectaculares desde la cima de la Pedra da Gávea.',
            'distance': '4 km',
            'duration': '3.5 horas',
            'location': 'Río de Janeiro, Brasil',
          },
        ];
      case 'Sídney':
        return [
          {
            'name': 'Bondi to Coogee Walk',
            'images': [
              'assets/hiking/Sídney/bondi.jpg',
              'assets/hiking/Sídney/bondi2.jpg',
              'assets/hiking/Sídney/bondi3.jpg'
            ],
            'description': 'Ruta costera con vistas espectaculares del océano Pacífico.',
            'distance': '6 km',
            'duration': '2 horas',
            'location': 'Sídney, Australia',
          },
          {
            'name': 'Blue Mountains National Park',
            'images': [
              'assets/hiking/Sídney/bluemountains.jpg',
              'assets/hiking/Sídney/bluemountains2.jpg',
              'assets/hiking/Sídney/bluemountains3.jpg'
            ],
            'description': 'Sendero a través de montañas y valles con vistas panorámicas.',
            'distance': '10 km',
            'duration': '3 horas',
            'location': 'Katoomba, Nueva Gales del Sur, Australia',
          },
          {
            'name': 'Royal National Park',
            'images': [
              'assets/hiking/Sídney/royal.jpg',
              'assets/hiking/Sídney/royal2.jpg',
              'assets/hiking/Sídney/royal3.jpg'
            ],
            'description': 'Ruta a través del segundo parque nacional más antiguo del mundo.',
            'distance': '8 km',
            'duration': '2 horas',
            'location': 'Sídney, Australia',
          },
        ];
      default:
        return [];
    }
  }
}
