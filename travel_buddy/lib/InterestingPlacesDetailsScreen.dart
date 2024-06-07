// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';

class InterestingPlacesDetailsScreen extends StatelessWidget {
  final String cityName;

  const InterestingPlacesDetailsScreen({required this.cityName});

  @override
  Widget build(BuildContext context) {
    const Color componentes = Color(0xFF218EBA);
    const Color fondo = Color(0xFFFFA500);

    final places = getInterestingPlacesForCity(cityName);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lugares en $cityName',
          style: const TextStyle(fontFamily: 'Pattaya', color: Colors.white),
        ),
        backgroundColor: componentes,
        centerTitle: true,
      ),
      body: Container(
        color: fondo,
        child: Swiper(
          itemCount: places.length,
          itemBuilder: (BuildContext context, int index) {
            final place = places[index];
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
                        items: place['images']!.map<Widget>((image) {
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
                            place['name']!,
                            style: GoogleFonts.lato(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            place['description']!,
                            style: GoogleFonts.lato(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Ubicación: ${place['location']!}',
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

  List<Map<String, dynamic>> getInterestingPlacesForCity(String cityName) {
    switch (cityName) {
      case 'Madrid':
        return [
          {
            'name': 'Palacio Real',
            'images': [
              'assets/places/Madrid/palacioreal.jpg',
              'assets/places/Madrid/palacioreal2.jpg',
              'assets/places/Madrid/palacioreal3.jpg',
            ],
            'description': 'El Palacio Real de Madrid es la residencia oficial del rey de España.',
            'location': 'Calle de Bailén, s/n, 28071 Madrid, España',
          },
          {
            'name': 'Parque del Retiro',
            'images': [
              'assets/places/Madrid/retiro.jpg',
              'assets/places/Madrid/retiro2.jpg',
              'assets/places/Madrid/retiro3.jpg',
            ],
            'description': 'El Parque del Retiro es uno de los parques más grandes de Madrid.',
            'location': 'Plaza de la Independencia, 7, 28001 Madrid, España',
          },
          {
            'name': 'Bernabéu',
            'images': [
              'assets/places/Madrid/bernabeu.jpg',
              'assets/places/Madrid/bernabeu2.jpg',
              'assets/places/Madrid/bernabeu3.jpg',
            ],
            'description': 'El estadio del mejor equipo del mundo, el Real Madrid.',
            'location': 'Av. de Concha Espina, 1, Chamartín, 28036 Madrid, España',
          },
          {
            'name': 'Templo de Debod.',
            'images': [
              'assets/places/Madrid/debod.jpg',
              'assets/places/Madrid/debod2.jpg',
              'assets/places/Madrid/debod3.jpg',
            ],
            'description': 'Templo egipcio del siglo II a. d. C.',
            'location': 'C. de Ferraz, 1, Moncloa - Aravaca, 28008 Madrid, España',
          },
        ];
      case 'Sevilla':
        return [
          {
            'name': 'La Giralda',
            'images': [
              'assets/places/Sevilla/giralda.jpg',
              'assets/places/Sevilla/giralda2.jpg',
              'assets/places/Sevilla/giralda3.jpg'
            ],
            'description': 'La Giralda es el campanario de la Catedral de Sevilla.',
            'location': 'Av. de la Constitución, s/n, 4004 Sevilla, España',
          },
          {
            'name': 'Plaza de España',
            'images': [
              'assets/places/Sevilla/plazaespaña.jpg',
              'assets/places/Sevilla/plazaespaña2.jpg',
              'assets/places/Sevilla/plazaespaña3.jpg'
            ],
            'description': 'La Plaza de España es una plaza monumental en el Parque de María Luisa.',
            'location': 'Parque de María Luisa, s/n, 41013 Sevilla, España',
          },
          {
            'name': 'Real Alcázar de Sevilla',
            'images': [
              'assets/places/Sevilla/alcazar.jpg',
              'assets/places/Sevilla/alcazar2.jpg',
              'assets/places/Sevilla/alcazar3.jpg'
            ],
            'description': 'El Real Alcázar de Sevilla es un palacio real en Sevilla.',
            'location': 'Patio de Banderas, s/n, 41004 Sevilla, España',
          },
        ];
      case 'Granada':
        return [
          {
            'name': 'La Alhambra',
            'images': [
              'assets/places/Granada/alhambra.jpg',
              'assets/places/Granada/alhambra2.jpg',
              'assets/places/Granada/alhambra3.jpg'
            ],
            'description': 'La Alhambra es un complejo de palacios y fortalezas en Granada.',
            'location': 'Calle Real de la Alhambra, s/n, 18009 Granada, España',
          },
          {
            'name': 'Generalife',
            'images': [
              'assets/places/Granada/generalife.jpg',
              'assets/places/Granada/generalife2.jpg',
              'assets/places/Granada/generalife3.jpg'
            ],
            'description': 'El Generalife es la villa con jardines habitada por los reyes musulmanes.',
            'location': 'Calle Real de la Alhambra, s/n, 18009 Granada, España',
          },
          {
            'name': 'Albaicín',
            'images': [
              'assets/places/Granada/albaicin.jpg',
              'assets/places/Granada/albaicin2.jpg',
              'assets/places/Granada/albaicin3.jpg'
            ],
            'description': 'El Albaicín es un barrio antiguo de Granada conocido por sus calles estrechas y empinadas.',
            'location': 'Albaicín, 18010 Granada, España',
          },
        ];
      case 'Santander':
        return [
          {
            'name': 'Palacio de la Magdalena',
            'images': [
              'assets/places/Santander/magdalena.jpg',
              'assets/places/Santander/magdalena2.jpg',
              'assets/places/Santander/magdalena3.jpg'
            ],
            'description': 'El Palacio de la Magdalena es un palacio en Santander, utilizado como residencia de verano por la familia real española.',
            'location': 'Av. de la Magdalena, s/n, 39005 Santander, España',
          },
          {
            'name': 'Catedral de Santander',
            'images': [
              'assets/places/Santander/catedral.jpg',
              'assets/places/Santander/catedral2.jpg',
              'assets/places/Santander/catedral3.jpg'
            ],
            'description': 'La Catedral de Santander es una catedral católica en Santander.',
            'location': 'Plaza del Obispo José Eguino y Trecu, 39002 Santander, España',
          },
          {
            'name': 'Centro Botín',
            'images': [
              'assets/places/Santander/botin.jpg',
              'assets/places/Santander/botin2.jpg',
              'assets/places/Santander/botin3.jpg'
            ],
            'description': 'El Centro Botín es un centro de arte en Santander.',
            'location': 'Muelle de Albareda, s/n, 39004 Santander, España',
          },
        ];
      case 'Burdeos':
        return [
          {
            'name': 'Place de la Bourse',
            'images': [
              'assets/places/Burdeos/bourse.jpg',
              'assets/places/Burdeos/bourse2.jpg',
              'assets/places/Burdeos/bourse3.jpg'
            ],
            'description': 'La Place de la Bourse es una de las plazas más famosas de Burdeos.',
            'location': 'Place de la Bourse, 33000 Bordeaux, Francia',
          },
          {
            'name': 'Cité du Vin',
            'images': [
              'assets/places/Burdeos/citeduvin.jpg',
              'assets/places/Burdeos/citeduvin2.jpg',
              'assets/places/Burdeos/citeduvin3.jpg'
            ],
            'description': 'La Cité du Vin es un museo en Burdeos dedicado al vino.',
            'location': '134 Quai de Bacalan, 33300 Bordeaux, Francia',
          },
          {
            'name': 'Catedral de Burdeos',
            'images': [
              'assets/places/Burdeos/catedral.jpg',
              'assets/places/Burdeos/catedral2.jpg',
              'assets/places/Burdeos/catedral3.jpg'
            ],
            'description': 'La Catedral de Burdeos es una catedral católica en Burdeos.',
            'location': 'Place Pey Berland, 33000 Bordeaux, Francia',
          },
        ];
      case 'Estrasburgo':
        return [
          {
            'name': 'Catedral de Estrasburgo',
            'images': [
              'assets/places/Estrasburgo/catedral.jpg',
              'assets/places/Estrasburgo/catedral2.jpg',
              'assets/places/Estrasburgo/catedral3.jpg'
            ],
            'description': 'La Catedral de Estrasburgo es una catedral católica en Estrasburgo.',
            'location': 'Place de la Cathédrale, 67000 Strasbourg, Francia',
          },
          {
            'name': 'Petite France',
            'images': [
              'assets/places/Estrasburgo/petitefrance.jpg',
              'assets/places/Estrasburgo/petitefrance2.jpg',
              'assets/places/Estrasburgo/petitefrance3.jpg'
            ],
            'description': 'Petite France es un barrio pintoresco en Estrasburgo.',
            'location': 'Petite France, 67000 Strasbourg, Francia',
          },
          {
            'name': 'Palais Rohan',
            'images': [
              'assets/places/Estrasburgo/rohan.jpg',
              'assets/places/Estrasburgo/rohan2.jpg',
              'assets/places/Estrasburgo/rohan3.jpg'
            ],
            'description': 'El Palais Rohan es un palacio en Estrasburgo que alberga tres museos.',
            'location': '2 Place du Château, 67000 Strasbourg, Francia',
          },
        ];
      case 'Venecia':
        return [
          {
            'name': 'Plaza de San Marcos',
            'images': [
              'assets/places/Venecia/sanmarcos.jpg',
              'assets/places/Venecia/sanmarcos2.jpg',
              'assets/places/Venecia/sanmarcos3.jpg'
            ],
            'description': 'La Plaza de San Marcos es la plaza principal de Venecia.',
            'location': 'Piazza San Marco, 30100 Venezia VE, Italia',
          },
          {
            'name': 'Gran Canal',
            'images': [
              'assets/places/Venecia/grancanal.jpg',
              'assets/places/Venecia/grancanal2.jpg',
              'assets/places/Venecia/grancanal3.jpg'
            ],
            'description': 'El Gran Canal es el canal principal de Venecia.',
            'location': 'Gran Canal, Venezia, Italia',
          },
          {
            'name': 'Puente de Rialto',
            'images': [
              'assets/places/Venecia/rialto.jpg',
              'assets/places/Venecia/rialto2.jpg',
              'assets/places/Venecia/rialto3.jpg'
            ],
            'description': 'El Puente de Rialto es el puente más antiguo y famoso de Venecia.',
            'location': 'Sestiere San Polo, 30125 Venezia VE, Italia',
          },
        ];
      case 'Milán':
        return [
          {
            'name': 'Duomo di Milano',
            'images': [
              'assets/places/Milan/duomo.jpg',
              'assets/places/Milan/duomo2.jpg',
              'assets/places/Milan/duomo3.jpg'
            ],
            'description': 'El Duomo di Milano es la catedral gótica de Milán.',
            'location': 'Piazza del Duomo, 20122 Milano MI, Italia',
          },
          {
            'name': 'Castello Sforzesco',
            'images': [
              'assets/places/Milan/sforzesco.jpg',
              'assets/places/Milan/sforzesco2.jpg',
              'assets/places/Milan/sforzesco3.jpg'
            ],
            'description': 'El Castello Sforzesco es un castillo en Milán que alberga varios museos.',
            'location': 'Piazza Castello, 20121 Milano MI, Italia',
          },
          {
            'name': 'Teatro alla Scala',
            'images': [
              'assets/places/Milan/scala.jpg',
              'assets/places/Milan/scala2.jpg',
              'assets/places/Milan/scala3.jpg'
            ],
            'description': 'El Teatro alla Scala es una ópera famosa en Milán.',
            'location': 'Via Filodrammatici, 2, 20121 Milano MI, Italia',
          },
        ];
      case 'Pisa':
        return [
          {
            'name': 'Torre de Pisa',
            'images': [
              'assets/places/Pisa/torre.jpg',
              'assets/places/Pisa/torre2.jpg',
              'assets/places/Pisa/torre3.jpg'
            ],
            'description': 'La Torre de Pisa es la torre inclinada famosa en Pisa.',
            'location': 'Piazza del Duomo, 56126 Pisa PI, Italia',
          },
          {
            'name': 'Piazza dei Miracoli',
            'images': [
              'assets/places/Pisa/miracoli.jpg',
              'assets/places/Pisa/miracoli2.jpg',
              'assets/places/Pisa/miracoli3.jpg'
            ],
            'description': 'La Piazza dei Miracoli es una plaza que contiene la Torre de Pisa, el Duomo y el Baptisterio.',
            'location': 'Piazza del Duomo, 56126 Pisa PI, Italia',
          },
          {
            'name': 'Camposanto Monumentale',
            'images': [
              'assets/places/Pisa/camposanto.jpg',
              'assets/places/Pisa/camposanto2.jpg',
              'assets/places/Pisa/camposanto3.jpg'
            ],
            'description': 'El Camposanto Monumentale es un cementerio histórico en Pisa.',
            'location': 'Piazza del Duomo, 56126 Pisa PI, Italia',
          },
        ];
      case 'Frankfurt':
        return [
          {
            'name': 'Römer',
            'images': [
              'assets/places/Frankfurt/romer.jpg',
              'assets/places/Frankfurt/romer2.jpg',
              'assets/places/Frankfurt/romer3.jpg'
            ],
            'description': 'El Römer es un edificio medieval en Frankfurt.',
            'location': 'Römerberg 27, 60311 Frankfurt am Main, Alemania',
          },
          {
            'name': 'Palmengarten',
            'images': [
              'assets/places/Frankfurt/palmengarten.jpg',
              'assets/places/Frankfurt/palmengarten2.jpg',
              'assets/places/Frankfurt/palmengarten3.jpg'
            ],
            'description': 'El Palmengarten es un jardín botánico en Frankfurt.',
            'location': 'Siesmayerstraße 61, 60323 Frankfurt am Main, Alemania',
          },
          {
            'name': 'Main Tower',
            'images': [
              'assets/places/Frankfurt/maintower.jpg',
              'assets/places/Frankfurt/maintower2.jpg',
              'assets/places/Frankfurt/maintower3.jpg'
            ],
            'description': 'La Main Tower es un rascacielos en Frankfurt con una plataforma de observación.',
            'location': 'Neue Mainzer Str. 52-58, 60311 Frankfurt am Main, Alemania',
          },
        ];
      case 'Chicago':
        return [
          {
            'name': 'Willis Tower',
            'images': [
              'assets/places/Chicago/willis.jpg',
              'assets/places/Chicago/willis2.jpg',
              'assets/places/Chicago/willis3.jpg'
            ],
            'description': 'La Willis Tower es un rascacielos en Chicago.',
            'location': '233 S Wacker Dr, Chicago, IL 60606, EE. UU.',
          },
          {
            'name': 'Millennium Park',
            'images': [
              'assets/places/Chicago/millennium.jpg',
              'assets/places/Chicago/millennium2.jpg',
              'assets/places/Chicago/millennium3.JPG'
            ],
            'description': 'El Millennium Park es un parque público en Chicago.',
            'location': '201 E Randolph St, Chicago, IL 60602, EE. UU.',
          },
          {
            'name': 'Navy Pier',
            'images': [
              'assets/places/Chicago/navypier.jpg',
              'assets/places/Chicago/navypier2.jpg',
              'assets/places/Chicago/navypier3.JPG'
            ],
            'description': 'El Navy Pier es un muelle en Chicago con atracciones y restaurantes.',
            'location': '600 E Grand Ave, Chicago, IL 60611, EE. UU.',
          },
        ];
      default:
        return [];
    }
  }
}
