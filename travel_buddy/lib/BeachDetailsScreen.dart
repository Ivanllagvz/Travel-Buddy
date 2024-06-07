import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BeachDetailsScreen extends StatelessWidget {
  final String cityName;

  const BeachDetailsScreen({required this.cityName});

  @override
  Widget build(BuildContext context) {
    const Color componentes = Color(0xFF218EBA);
    const Color fondo = Color(0xFFFFA500);

    final beaches = getBeachesForCity(cityName);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Playas en $cityName',
          style: const TextStyle(fontFamily: 'Pattaya', color: Colors.white),
        ),
        backgroundColor: componentes,
        centerTitle: true,
      ),
      body: Container(
        color: fondo,
        child: Swiper(
          itemCount: beaches.length,
          itemBuilder: (BuildContext context, int index) {
            final beach = beaches[index];
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
                        items: beach['images']!.map<Widget>((image) {
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
                            beach['name']!,
                            style: GoogleFonts.lato(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            beach['description']!,
                            style: GoogleFonts.lato(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Ubicación: ${beach['location']!}',
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

  List<Map<String, dynamic>> getBeachesForCity(String cityName) {
    switch (cityName) {
      case 'Barcelona':
        return [
          {
            'name': 'Playa de la Barceloneta',
            'images': [
              'assets/beaches/Barcelona/barceloneta.jpg',
            ],
            'description': 'Una de las playas más populares de Barcelona.',
            'location': 'Barcelona, España',
          },
          {
            'name': 'Playa de Bogatell',
            'images': [
              'assets/beaches/Barcelona/bogatell.jpg',
            ],
            'description': 'Playa tranquila y familiar con muchas instalaciones.',
            'location': 'Barcelona, España',
          },
          {
            'name': 'Playa de Sant Sebastià',
            'images': [
              'assets/beaches/Barcelona/santsebastia.jpg',
            ],
            'description': 'Playa extensa y tradicional, ideal para nadar.',
            'location': 'Barcelona, España',
          },
        ];
      case 'Niza':
        return [
          {
            'name': 'Plage Beau Rivage',
            'images': [
              'assets/beaches/Niza/beaurivage.jpg',
            ],
            'description': 'Playa elegante con cómodas tumbonas y un restaurante.',
            'location': 'Niza, Francia',
          },
          {
            'name': 'Plage Castel',
            'images': [
              'assets/beaches/Niza/castel.jpg',
            ],
            'description': 'Playa privada con vistas impresionantes y aguas cristalinas.',
            'location': 'Niza, Francia',
          },
          {
            'name': 'Plage de la Réserve',
            'images': [
              'assets/beaches/Niza/reserve.jpg',
            ],
            'description': 'Pequeña playa rocosa, perfecta para el snorkel.',
            'location': 'Niza, Francia',
          },
        ];
      case 'Marsella':
        return [
          {
            'name': 'Plage des Catalans',
            'images': [
              'assets/beaches/Marsella/catalans.jpg',
            ],
            'description': 'Playa popular cerca del centro de Marsella.',
            'location': 'Marsella, Francia',
          },
          {
            'name': 'Plage du Prado',
            'images': [
              'assets/beaches/Marsella/prado.jpg',
            ],
            'description': 'Gran playa con áreas verdes y actividades deportivas.',
            'location': 'Marsella, Francia',
          },
          {
            'name': 'Plage de la Pointe Rouge',
            'images': [
              'assets/beaches/Marsella/pointerouge.jpg',
            ],
            'description': 'Playa de arena con muchas actividades acuáticas.',
            'location': 'Marsella, Francia',
          },
        ];
      case 'Los Ángeles':
        return [
          {
            'name': 'Venice Beach',
            'images': [
              'assets/beaches/LosAngeles/venice.jpg',
            ],
            'description': 'Playa famosa por su paseo marítimo y ambiente bohemio.',
            'location': 'Los Ángeles, California, EE.UU.',
          },
          {
            'name': 'Malibu Beach',
            'images': [
              'assets/beaches/LosAngeles/malibu.jpg',
            ],
            'description': 'Playa exclusiva conocida por sus olas y mansiones.',
            'location': 'Malibú, California, EE.UU.',
          },
        ];
      case 'Las Vegas':
        return [
          {
            'name': 'Mandalay Bay Beach',
            'images': [
              'assets/beaches/LasVegas/mandalaybay.jpg',
            ],
            'description': 'Playa artificial con piscina de olas y arena real.',
            'location': 'Las Vegas, Nevada, EE.UU.',
          },
          {
            'name': 'Lake Las Vegas',
            'images': [
              'assets/beaches/LasVegas/lakelasvegas.jpg',
            ],
            'description': 'Resort de lujo con playa junto al lago y actividades acuáticas.',
            'location': 'Henderson, Nevada, EE.UU.',
          },
          {
            'name': 'Cottonwood Cove',
            'images': [
              'assets/beaches/LasVegas/cottonwood.jpg',
            ],
            'description': 'Playa en el Lago Mohave ideal para nadar y hacer picnic.',
            'location': 'Searchlight, Nevada, EE.UU.',
          },
        ];
      case 'Buenos Aires':
        return [
          {
            'name': 'Playa Grande',
            'images': [
              'assets/beaches/BuenosAires/playagrande.jpg',
            ],
            'description': 'Playa extensa y popular con muchos servicios.',
            'location': 'Mar del Plata, Buenos Aires, Argentina',
          },
          {
            'name': 'Playa Varese',
            'images': [
              'assets/beaches/BuenosAires/varese.jpg',
            ],
            'description': 'Playa familiar y tranquila con aguas calmas.',
            'location': 'Mar del Plata, Buenos Aires, Argentina',
          },
          {
            'name': 'Playa Bristol',
            'images': [
              'assets/beaches/BuenosAires/bristol.jpg',
            ],
            'description': 'Una de las playas más céntricas y concurridas.',
            'location': 'Mar del Plata, Buenos Aires, Argentina',
          },
        ];
      default:
        return [];
    }
  }
}