// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MuseumDetailsScreen extends StatelessWidget {
  final String cityName;

  const MuseumDetailsScreen({required this.cityName});

  @override
  Widget build(BuildContext context) {
    const Color componentes = Color(0xFF218EBA);
    const Color fondo = Color(0xFFFFA500);

    final museums = getMuseumsForCity(cityName);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Museos en $cityName',
          style: TextStyle(fontFamily: 'Pattaya', color: Colors.white),
        ),
        backgroundColor: componentes,
        centerTitle: true,
      ),
      body: Container(
        color: fondo,
        child: Swiper(
          itemCount: museums.length,
          itemBuilder: (BuildContext context, int index) {
            final museum = museums[index];
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
                        items: museum['images']!.map<Widget>((image) {
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
                            museum['name']!,
                            style: GoogleFonts.lato(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            museum['description']!,
                            style: GoogleFonts.lato(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Horarios: ${museum['hours']!}',
                            style: GoogleFonts.lato(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Precio: ${museum['price']!}',
                            style: GoogleFonts.lato(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Ubicación: ${museum['location']!}',
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

  List<Map<String, dynamic>> getMuseumsForCity(String cityName) {
    switch (cityName) {
      case 'Madrid':
        return [
          {
            'name': 'Museo del Prado',
            'images': [
              'assets/museums/Madrid/prado.png',
              'assets/museums/Madrid/prado2.jpg',
              'assets/museums/Madrid/prado3.jpg'
            ],
            'description': 'El Museo del Prado es el principal museo de arte nacional español.',
            'hours': 'Lunes a Domingo: 10:00 - 20:00',
            'price': 'Adultos: €15, Estudiantes: €7.50',
            'location': 'Calle de Ruiz de Alarcón, 23, 28014 Madrid, España',
          },
          {
            'name': 'Museo Nacional Centro de Arte Reina Sofía',
            'images': [
              'assets/museums/Madrid/reinasofia.jpeg',
              'assets/museums/Madrid/reinasofia2.jpg',
              'assets/museums/Madrid/reinasofia3.jpg'
            ],
            'description': 'El Museo Reina Sofía es un museo nacional de arte del siglo XX.',
            'hours': 'Lunes a Sábado: 10:00 - 21:00, Domingo: 10:00 - 14:30',
            'price': 'Adultos: €10, Estudiantes: Gratis',
            'location': 'Calle de Santa Isabel, 52, 28012 Madrid, España',
          },
          {
            'name': 'Museo Nacional Thyssen-Bornemisza',
            'images': [
              'assets/museums/Madrid/thyssen.jpg',
              'assets/museums/Madrid/thyssen2.jpg',
              'assets/museums/Madrid/thyssen3.jpg'
            ],
            'description': 'El Museo Thyssen-Bornemisza alberga una de las colecciones de arte más importantes del mundo.',
            'hours': 'Martes a Domingo: 10:00 - 19:00',
            'price': 'Adultos: €13, Estudiantes: €9',
            'location': 'Paseo del Prado, 8, 28014 Madrid, España',
          },
          {
            'name': 'Museo Nacional de Ciencias Naturales (MNCN) - CSIC',
            'images': [
              'assets/museums/Madrid/cienciasnaturales.jpg',
              'assets/museums/Madrid/cienciasnaturales2.jpg',
              'assets/museums/Madrid/cienciasnaturales3.jpg'
            ],
            'description': 'El MNCN es uno de los institutos de investigación científica más antiguos de España.',
            'hours': 'Martes a Domingo: 10:00 - 17:00',
            'price': 'Adultos: €7, Estudiantes: €3.50',
            'location': 'Calle de José Gutiérrez Abascal, 2, 28006 Madrid, España',
          },
          {
            'name': 'Museo del Ferrocarril de Madrid',
            'images': [
              'assets/museums/Madrid/ferrocarril.jpg',
              'assets/museums/Madrid/ferrocarril2.jpg',
              'assets/museums/Madrid/ferrocarril3.jpg'
            ],
            'description': 'El Museo del Ferrocarril muestra la historia del transporte ferroviario en España.',
            'hours': 'Lunes a Domingo: 10:00 - 15:00',
            'price': 'Adultos: €6, Estudiantes: €4',
            'location': 'Paseo de las Delicias, 61, 28045 Madrid, España',
          },
          {
            'name': 'Museo de Cera',
            'images': [
              'assets/museums/Madrid/cera.jpg',
              'assets/museums/Madrid/cera2.jpg',
              'assets/museums/Madrid/cera3.jpg'
            ],
            'description': 'El Museo de Cera de Madrid alberga figuras de cera de personajes famosos de la historia y la cultura popular.',
            'hours': 'Lunes a Domingo: 10:00 - 14:00 y 16:30 - 20:30',
            'price': 'Adultos: €19, Estudiantes: €12',
            'location': 'Paseo de Recoletos, 41, 28004 Madrid, España',
          },
          {
            'name': 'Museo Naval',
            'images': [
              'assets/museums/Madrid/naval.jpg',
              'assets/museums/Madrid/naval2.jpg',
              'assets/museums/Madrid/naval3.jpg'
            ],
            'description': 'El Museo Naval exhibe la historia de la Armada Española y su influencia en la navegación mundial.',
            'hours': 'Martes a Domingo: 10:00 - 19:00',
            'price': 'Entrada gratuita, donación sugerida: €3',
            'location': 'Paseo del Prado, 5, 28014 Madrid, España',
          },
        ];
      case 'Barcelona':
        return [
          {
            'name': 'Museo Picasso',
            'images': [
              'assets/museums/Barcelona/picasso.jpg',
              'assets/museums/Barcelona/picasso2.jpg',
              'assets/museums/Barcelona/picasso3.jpg'
            ],
            'description': 'Alberga una de las colecciones más extensas de las obras de Picasso.',
            'hours': 'Martes a Domingo: 10:00 - 19:00, Lunes cerrado.',
            'price': 'Adultos: €12, Estudiantes: €7.50',
            'location': 'Carrer Montcada, 15-23, 08003 Barcelona, España',
          },
          {
            'name': 'Museo Nacional de Arte de Cataluña (MNAC)',
            'images': [
              'assets/museums/Barcelona/mnac.jpg',
              'assets/museums/Barcelona/mnac2.jpg',
              'assets/museums/Barcelona/mnac3.jpg'
            ],
            'description': 'Museo de arte que abarca desde el románico hasta el siglo XX.',
            'hours': 'Martes a Sábado: 10:00 - 18:00, Domingo: 10:00 - 15:00',
            'price': 'Adultos: €12, Estudiantes: Gratis',
            'location': 'Palau Nacional, Parc de Montjuïc, 08038 Barcelona, España',
          },
          {
            'name': 'Fundació Joan Miró',
            'images': [
              'assets/museums/Barcelona/miro.jpg',
              'assets/museums/Barcelona/miro2.jpg',
              'assets/museums/Barcelona/miro3.jpg'
            ],
            'description': 'Museo dedicado a la obra del artista Joan Miró.',
            'hours': 'Martes a Sábado: 10:00 - 19:00, Domingo: 10:00 - 14:30',
            'price': 'Adultos: €13, Estudiantes: €7',
            'location': 'Parc de Montjuïc, s/n, 08038 Barcelona, España',
          },
        ];
      case 'Bilbao':
        return [
          {
            'name': 'Museo Guggenheim Bilbao',
            'images': [
              'assets/museums/Bilbao/guggenheim.jpg',
              'assets/museums/Bilbao/guggenheim2.jpg',
              'assets/museums/Bilbao/guggenheim3.jpg'
            ],
            'description': 'Museo de arte contemporáneo diseñado por Frank Gehry.',
            'hours': 'Martes a Domingo: 10:00 - 20:00, Lunes cerrado.',
            'price': 'Adultos: €16, Estudiantes: €9',
            'location': 'Abandoibarra Etorb., 2, 48009 Bilbao, España',
          },
          {
            'name': 'Museo de Bellas Artes de Bilbao',
            'images': [
              'assets/museums/Bilbao/bellasartes.jpg',
              'assets/museums/Bilbao/bellasartes2.jpg',
              'assets/museums/Bilbao/bellasartes3.jpg'
            ],
            'description': 'Museo de arte que alberga una amplia colección de obras desde el siglo XII hasta la actualidad.',
            'hours': 'Lunes a Domingo: 10:00 - 20:00',
            'price': 'Adultos: €10, Estudiantes: Gratis',
            'location': 'Museo Plaza, 2, 48009 Bilbao, España',
          },
          {
            'name': 'Museo Marítimo Ría de Bilbao',
            'images': [
              'assets/museums/Bilbao/maritimo.jpg',
              'assets/museums/Bilbao/maritimo2.jpg',
              'assets/museums/Bilbao/maritimo3.jpg'
            ],
            'description': 'Museo dedicado a la historia marítima de Bilbao y su ría.',
            'hours': 'Martes a Domingo: 10:00 - 18:00, Lunes cerrado.',
            'price': 'Adultos: €6, Estudiantes: €3.50',
            'location': 'Muelle Ramón de la Sota, 1, 48013 Bilbao, España',
          },
        ];
      case 'París':
        return [
          {
            'name': 'Museo del Louvre',
            'images': [
              'assets/museums/París/louvre.jpg',
              'assets/museums/París/louvre2.jpg',
              'assets/museums/París/louvre3.jpg'
            ],
            'description': 'El museo más grande del mundo y un monumento histórico en París.',
            'hours': 'Lunes, Jueves, Sábado, Domingo: 9:00 - 18:00; Miércoles y Viernes: 9:00 - 21:45; Martes cerrado.',
            'price': 'Adultos: €17, Menores de 18 años: Gratis',
            'location': 'Rue de Rivoli, 75001 París, Francia',
          },
          {
            'name': 'Museo de Orsay',
            'images': [
              'assets/museums/París/orsay.jpg',
              'assets/museums/París/orsay2.jpg',
              'assets/museums/París/orsay3.jpg'
            ],
            'description': 'Ubicado en una antigua estación de tren, alberga principalmente arte francés de 1848 a 1914.',
            'hours': 'Martes a Domingo: 9:30 - 18:00, Jueves hasta las 21:45; Lunes cerrado.',
            'price': 'Adultos: €14, Menores de 18 años: Gratis',
            'location': '1 Rue de la Légion d\'Honneur, 75007 París, Francia',
          },
          {
            'name': 'Centro Pompidou',
            'images': [
              'assets/museums/París/pompidou.jpg',
              'assets/museums/París/pompidou2.jpg',
              'assets/museums/París/pompidou3.jpg'
            ],
            'description': 'Museo nacional de arte moderno, famoso por su arquitectura de alta tecnología.',
            'hours': 'Todos los días: 11:00 - 21:00; Martes cerrado.',
            'price': 'Adultos: €14, Estudiantes: €11',
            'location': 'Place Georges-Pompidou, 75004 París, Francia',
          },
        ];
      case 'Roma':
        return [
          {
            'name': 'Museos Vaticanos',
            'images': [
              'assets/museums/Roma/vaticanos.jpg',
              'assets/museums/Roma/vaticanos2.jpg',
              'assets/museums/Roma/vaticanos3.jpg'
            ],
            'description': 'Una de las colecciones de arte más grandes del mundo, ubicadas en la Ciudad del Vaticano.',
            'hours': 'Lunes a Sábado: 9:00 - 18:00, Domingo cerrado.',
            'price': 'Adultos: €17, Estudiantes: €8',
            'location': 'Viale Vaticano, 00165 Roma, Italia',
          },
          {
            'name': 'Galería Borghese',
            'images': [
              'assets/museums/Roma/borghese.jpg',
              'assets/museums/Roma/borghese2.jpg',
              'assets/museums/Roma/borghese3.jpg'
            ],
            'description': 'Museo de arte en la Villa Borghese, que alberga una impresionante colección de esculturas y pinturas.',
            'hours': 'Martes a Domingo: 9:00 - 19:00, Lunes cerrado.',
            'price': 'Adultos: €15, Estudiantes: €2',
            'location': 'Piazzale Scipione Borghese, 5, 00197 Roma, Italia',
          },
          {
            'name': 'Museo Capitolino',
            'images': [
              'assets/museums/Roma/capitolino.jpg',
              'assets/museums/Roma/capitolino2.jpg',
              'assets/museums/Roma/capitolino3.jpg'
            ],
            'description': 'Museo de arte y arqueología ubicado en la Piazza del Campidoglio, en la cima de la Colina Capitolina.',
            'hours': 'Martes a Domingo: 9:30 - 19:30, Lunes cerrado.',
            'price': 'Adultos: €15, Estudiantes: €13',
            'location': 'Piazza del Campidoglio, 1, 00186 Roma, Italia',
          },
        ];
      case 'Florencia':
        return [
          {
            'name': 'Galería Uffizi',
            'images': [
              'assets/museums/Florencia/uffizi.jpg',
              'assets/museums/Florencia/uffizi2.jpg',
              'assets/museums/Florencia/uffizi3.jpg'
            ],
            'description': 'Uno de los museos más importantes de Italia, conocido por su colección de arte renacentista.',
            'hours': 'Martes a Domingo: 8:15 - 18:50, Lunes cerrado.',
            'price': 'Adultos: €20, Estudiantes: €10',
            'location': 'Piazzale degli Uffizi, 6, 50122 Firenze FI, Italia',
          },
          {
            'name': 'Galería de la Academia',
            'images': [
              'assets/museums/Florencia/academia.jpg',
              'assets/museums/Florencia/academia2.jpg',
              'assets/museums/Florencia/academia3.jpg'
            ],
            'description': 'Famosa por albergar el David de Miguel Ángel y otras obras maestras del Renacimiento.',
            'hours': 'Martes a Domingo: 8:15 - 18:50, Lunes cerrado.',
            'price': 'Adultos: €12, Estudiantes: €2',
            'location': 'Via Ricasoli, 58/60, 50122 Firenze FI, Italia',
          },
          {
            'name': 'Palacio Pitti',
            'images': [
              'assets/museums/Florencia/pitti.jpg',
              'assets/museums/Florencia/pitti2.jpg',
              'assets/museums/Florencia/pitti3.jpg'
            ],
            'description': 'Un vasto palacio renacentista que alberga importantes colecciones de pintura, escultura y objetos de arte.',
            'hours': 'Martes a Domingo: 8:15 - 18:50, Lunes cerrado.',
            'price': 'Adultos: €16, Estudiantes: €2',
            'location': 'Piazza de\' Pitti, 1, 50125 Firenze FI, Italia',
          },
        ];
      case 'Berlín':
        return [
          {
            'name': 'Museo de Pérgamo',
            'images': [
              'assets/museums/Berlín/pergamo.jpg',
              'assets/museums/Berlín/pergamo2.jpg',
              'assets/museums/Berlín/pergamo3.jpg'
            ],
            'description': 'Famoso por albergar la puerta de Ishtar de Babilonia y el altar de Pérgamo.',
            'hours': 'Lunes a Domingo: 10:00 - 18:00, Jueves hasta las 20:00',
            'price': 'Adultos: €12, Estudiantes: €6',
            'location': 'Bodestraße 1-3, 10178 Berlín, Alemania',
          },
          {
            'name': 'Museo Nuevo',
            'images': [
              'assets/museums/Berlín/nuevo.jpg',
              'assets/museums/Berlín/nuevo2.jpg',
              'assets/museums/Berlín/nuevo3.jpg'
            ],
            'description': 'Alberga artefactos del antiguo Egipto, incluyendo el busto de Nefertiti.',
            'hours': 'Lunes a Domingo: 10:00 - 18:00, Jueves hasta las 20:00',
            'price': 'Adultos: €12, Estudiantes: €6',
            'location': 'Bodestraße 1-3, 10178 Berlín, Alemania',
          },
          {
            'name': 'Museo de Historia Alemana',
            'images': [
              'assets/museums/Berlín/historia.jpg',
              'assets/museums/Berlín/historia2.jpg',
              'assets/museums/Berlín/historia3.jpg'
            ],
            'description': 'Muestra la historia de Alemania desde la Edad Media hasta la actualidad.',
            'hours': 'Lunes a Domingo: 10:00 - 18:00',
            'price': 'Adultos: €8, Estudiantes: €4',
            'location': 'Unter den Linden 2, 10117 Berlín, Alemania',
          },
        ];
      case 'Londres':
        return [
          {
            'name': 'British Museum',
            'images': [
              'assets/museums/Londres/british.jpg',
              'assets/museums/Londres/british2.jpg',
              'assets/museums/Londres/british3.jpg'
            ],
            'description': 'Uno de los museos más grandes del mundo, dedicado a la historia y la cultura humana.',
            'hours': 'Lunes a Domingo: 10:00 - 17:30, Viernes hasta las 20:30',
            'price': 'Entrada gratuita',
            'location': 'Great Russell St, Bloomsbury, Londres WC1B 3DG, Reino Unido',
          },
          {
            'name': 'Museo de Historia Natural',
            'images': [
              'assets/museums/Londres/natural.jpg',
              'assets/museums/Londres/natural2.jpg',
              'assets/museums/Londres/natural3.jpg'
            ],
            'description': 'Famoso por su colección de esqueletos de dinosaurios y su arquitectura impresionante.',
            'hours': 'Lunes a Domingo: 10:00 - 17:50',
            'price': 'Entrada gratuita',
            'location': 'Cromwell Rd, South Kensington, Londres SW7 5BD, Reino Unido',
          },
          {
            'name': 'Museo de Victoria y Alberto (V&A)',
            'images': [
              'assets/museums/Londres/va.jpg',
              'assets/museums/Londres/va2.jpg',
              'assets/museums/Londres/va3.jpg'
            ],
            'description': 'El museo de arte y diseño más grande del mundo.',
            'hours': 'Lunes a Domingo: 10:00 - 17:45, Viernes hasta las 22:00',
            'price': 'Entrada gratuita',
            'location': 'Cromwell Rd, Knightsbridge, Londres SW7 2RL, Reino Unido',
          },
        ];
      case 'Ámsterdam':
        return [
          {
            'name': 'Museo Van Gogh',
            'images': [
              'assets/museums/Ámsterdam/vangogh.jpg',
              'assets/museums/Ámsterdam/vangogh2.jpg',
              'assets/museums/Ámsterdam/vangogh3.jpg'
            ],
            'description': 'Alberga la mayor colección de obras de Van Gogh en el mundo.',
            'hours': 'Lunes a Domingo: 9:00 - 18:00, Viernes hasta las 21:00',
            'price': 'Adultos: €19, Menores de 18 años: Gratis',
            'location': 'Museumplein 6, 1071 DJ Ámsterdam, Países Bajos',
          },
          {
            'name': 'Rijksmuseum',
            'images': [
              'assets/museums/Ámsterdam/rijks.jpg',
              'assets/museums/Ámsterdam/rijks2.jpg',
              'assets/museums/Ámsterdam/rijks3.jpg'
            ],
            'description': 'Museo nacional de los Países Bajos, dedicado a las artes y la historia.',
            'hours': 'Lunes a Domingo: 9:00 - 17:00',
            'price': 'Adultos: €20, Menores de 18 años: Gratis',
            'location': 'Museumstraat 1, 1071 XX Ámsterdam, Países Bajos',
          },
          {
            'name': 'Casa de Ana Frank',
            'images': [
              'assets/museums/Ámsterdam/anafrank.jpg',
              'assets/museums/Ámsterdam/anafrank2.jpg',
              'assets/museums/Ámsterdam/anafrank3.jpg'
            ],
            'description': 'Museo dedicado a Ana Frank, una joven judía que escribió un diario durante la Segunda Guerra Mundial.',
            'hours': 'Lunes a Domingo: 9:00 - 19:00, Sábados hasta las 22:00',
            'price': 'Adultos: €10, Menores de 18 años: €5',
            'location': 'Prinsengracht 263-267, 1016 GV Ámsterdam, Países Bajos',
          },
        ];
      case 'Nueva York':
        return [
          {
            'name': 'Museo Metropolitano de Arte (The Met)',
            'images': [
              'assets/museums/NuevaYork/met.jpg',
              'assets/museums/NuevaYork/met2.jpg',
              'assets/museums/NuevaYork/met3.jpg'
            ],
            'description': 'El museo de arte más grande de los Estados Unidos.',
            'hours': 'Lunes a Domingo: 10:00 - 17:30, Viernes y Sábado hasta las 21:00',
            'price': 'Adultos: €25, Estudiantes: €12',
            'location': '1000 5th Ave, New York, NY 10028, Estados Unidos',
          },
          {
            'name': 'Museo Americano de Historia Natural',
            'images': [
              'assets/museums/NuevaYork/naturalhistory.jpg',
              'assets/museums/NuevaYork/naturalhistory2.jpg',
              'assets/museums/NuevaYork/naturalhistory3.jpg'
            ],
            'description': 'Famoso por sus dioramas y el esqueleto de Tyrannosaurus rex.',
            'hours': 'Lunes a Domingo: 10:00 - 17:45',
            'price': 'Adultos: €23, Estudiantes: €18',
            'location': 'Central Park West & 79th St, New York, NY 10024, Estados Unidos',
          },
          {
            'name': 'Museo de Arte Moderno (MoMA)',
            'images': [
              'assets/museums/NuevaYork/moma.jpg',
              'assets/museums/NuevaYork/moma2.jpg',
              'assets/museums/NuevaYork/moma3.jpg'
            ],
            'description': 'Uno de los museos de arte moderno más influyentes del mundo.',
            'hours': 'Lunes a Domingo: 10:30 - 17:30, Viernes hasta las 21:00',
            'price': 'Adultos: €25, Estudiantes: €14',
            'location': '11 W 53rd St, New York, NY 10019, Estados Unidos',
          },
        ];
      default:
        return [];
    }
  }
}