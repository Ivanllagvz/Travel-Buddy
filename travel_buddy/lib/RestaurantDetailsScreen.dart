// ignore_for_file: use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final String cityName;

  const RestaurantDetailsScreen({required this.cityName});

  @override
  Widget build(BuildContext context) {
    const Color componentes = Color(0xFF218EBA);
    const Color fondo = Color(0xFFFFA500);

    final restaurants = getRestaurantsForCity(cityName);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Restauración en $cityName',
          style: const TextStyle(fontFamily: 'Pattaya', color: Colors.white),
        ),
        backgroundColor: componentes,
        centerTitle: true,
      ),
      body: Container(
        color: fondo,
        child: Swiper(
          itemCount: restaurants.length,
          itemBuilder: (BuildContext context, int index) {
            final restaurant = restaurants[index];
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
                        items: restaurant['images']!.map<Widget>((image) {
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
                            restaurant['name']!,
                            style: GoogleFonts.lato(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            restaurant['description']!,
                            style: GoogleFonts.lato(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Horarios: ${restaurant['hours']!}',
                            style: GoogleFonts.lato(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Precio: ${restaurant['price']!}',
                            style: GoogleFonts.lato(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Ubicación: ${restaurant['location']!}',
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

  List<Map<String, dynamic>> getRestaurantsForCity(String cityName) {
    switch (cityName) {
      case 'Madrid':
        return [
          {
            'name': 'Botín',
            'images': [
              'assets/restaurants/Madrid/botin.jpg',
              'assets/restaurants/Madrid/botin2.jpg',
              'assets/restaurants/Madrid/botin3.jpg'
            ],
            'description': 'El restaurante más antiguo del mundo, famoso por su cochinillo asado.',
            'hours': 'Lunes a Domingo: 13:00 - 16:00, 20:00 - 23:30',
            'price': '€50 - €70',
            'location': 'Calle de Cuchilleros, 17, 28005 Madrid, España',
          },
          {
            'name': 'Mercado de San Miguel',
            'images': [
              'assets/restaurants/Madrid/sanmiguel.jpg',
              'assets/restaurants/Madrid/sanmiguel2.jpg',
              'assets/restaurants/Madrid/sanmiguel3.jpg'
            ],
            'description': 'Un mercado histórico con una gran variedad de tapas y comidas gourmet.',
            'hours': 'Lunes a Domingo: 10:00 - 24:00',
            'price': '€15 - €30',
            'location': 'Plaza de San Miguel, s/n, 28005 Madrid, España',
          },
          {
            'name': 'Casa Lucio',
            'images': [
              'assets/restaurants/Madrid/lucio.jpg',
              'assets/restaurants/Madrid/lucio2.jpg',
              'assets/restaurants/Madrid/lucio3.jpg'
            ],
            'description': 'Famoso por sus huevos estrellados, un clásico de la cocina madrileña.',
            'hours': 'Lunes a Sábado: 13:00 - 16:00, 20:00 - 24:00',
            'price': '€30 - €50',
            'location': 'Calle de la Cava Baja, 35, 28005 Madrid, España',
          },
        ];
      case 'París':
        return [
          {
            'name': 'Le Jules Verne',
            'images': [
              'assets/restaurants/Paris/julesverne.jpg',
              'assets/restaurants/Paris/julesverne2.jpg',
              'assets/restaurants/Paris/julesverne3.jpg'
            ],
            'description': 'Restaurante gourmet en la Torre Eiffel con vistas impresionantes.',
            'hours': 'Lunes a Domingo: 12:00 - 14:00, 18:30 - 21:30',
            'price': '€100 - €250',
            'location': 'Avenue Gustave Eiffel, 75007 Paris, Francia',
          },
          {
            'name': 'L\'Arpège',
            'images': [
              'assets/restaurants/Paris/larpege.jpg',
              'assets/restaurants/Paris/larpege2.jpg',
              'assets/restaurants/Paris/larpege3.jpg'
            ],
            'description': 'Alta cocina francesa con un enfoque en ingredientes de temporada.',
            'hours': 'Martes a Viernes: 12:00 - 14:00, 19:00 - 22:00',
            'price': '€200 - €400',
            'location': '84 Rue de Varenne, 75007 Paris, Francia',
          },
          {
            'name': 'Pierre Gagnaire',
            'images': [
              'assets/restaurants/Paris/pierregagnaire.jpg',
              'assets/restaurants/Paris/pierregagnaire2.jpg',
              'assets/restaurants/Paris/pierregagnaire3.jpg'
            ],
            'description': 'Innovadora cocina francesa en un entorno elegante.',
            'hours': 'Lunes a Viernes: 12:30 - 14:00, 19:30 - 21:30',
            'price': '€150 - €300',
            'location': '6 Rue Balzac, 75008 Paris, Francia',
          },
        ];
      case 'Tokio':
        return [
          {
            'name': 'Sukiyabashi Jiro',
            'images': [
              'assets/restaurants/Tokyo/jiro.jpg',
              'assets/restaurants/Tokyo/jiro2.jpg',
              'assets/restaurants/Tokyo/jiro3.jpg'
            ],
            'description': 'Famoso restaurante de sushi dirigido por el maestro Jiro Ono.',
            'hours': 'Lunes a Viernes: 11:30 - 14:00, 17:30 - 20:30',
            'price': '¥30,000 - ¥40,000',
            'location': 'Tsukamoto Sogyo Building, 4-2-15 Ginza, Chuo City, Tokyo 104-0061, Japón',
          },
          {
            'name': 'Narisawa',
            'images': [
              'assets/restaurants/Tokyo/narisawa.jpg',
              'assets/restaurants/Tokyo/narisawa2.jpg',
              'assets/restaurants/Tokyo/narisawa3.jpg'
            ],
            'description': 'Alta cocina japonesa con un enfoque en la sostenibilidad y la naturaleza.',
            'hours': 'Martes a Sábado: 12:00 - 13:00, 18:30 - 20:00',
            'price': '¥20,000 - ¥30,000',
            'location': '2 Chome-6-15 Minamiaoyama, Minato City, Tokyo 107-0062, Japón',
          },
          {
            'name': 'Den',
            'images': [
              'assets/restaurants/Tokyo/den.jpg',
              'assets/restaurants/Tokyo/den2.jpg',
              'assets/restaurants/Tokyo/den3.jpg'
            ],
            'description': 'Restaurante innovador con una reinterpretación creativa de la cocina japonesa.',
            'hours': 'Martes a Sábado: 12:00 - 13:00, 18:00 - 20:00',
            'price': '¥15,000 - ¥25,000',
            'location': '2 Chome-3-18 Jingumae, Shibuya City, Tokyo 150-0001, Japón',
          },
        ];
      case 'Lyon':
        return [
          {
            'name': 'La Mère Brazier',
            'images': [
              'assets/restaurants/Lyon/merebrazier.jpg',
              'assets/restaurants/Lyon/merebrazier2.jpg',
              'assets/restaurants/Lyon/merebrazier3.jpg'
            ],
            'description': 'Restaurante histórico conocido por su cocina tradicional de Lyon.',
            'hours': 'Martes a Sábado: 12:00 - 13:30, 19:30 - 21:00',
            'price': '€80 - €150',
            'location': '12 Rue Royale, 69001 Lyon, Francia',
          },
          {
            'name': 'Le Café des Fédérations',
            'images': [
              'assets/restaurants/Lyon/federations.jpg',
              'assets/restaurants/Lyon/federations2.jpg',
              'assets/restaurants/Lyon/federations3.jpg'
            ],
            'description': 'Uno de los bouchons más famosos de Lyon, conocido por su ambiente acogedor.',
            'hours': 'Lunes a Viernes: 12:00 - 14:00, 19:30 - 21:30',
            'price': '€30 - €50',
            'location': '8-10 Rue Major Martin, 69001 Lyon, Francia',
          },
          {
            'name': 'Auberge du Pont de Collonges',
            'images': [
              'assets/restaurants/Lyon/collonges.jpg',
              'assets/restaurants/Lyon/collonges2.jpg',
              'assets/restaurants/Lyon/collonges3.jpg'
            ],
            'description': 'Restaurante de tres estrellas Michelin dirigido por el legendario chef Paul Bocuse.',
            'hours': 'Miércoles a Domingo: 12:00 - 13:30, 19:30 - 21:30',
            'price': '€200 - €300',
            'location': '40 Quai de la Plage, 69660 Collonges-au-Mont-d\'Or, Francia',
          },
        ];
      case 'Bologna':
        return [
          {
            'name': 'Osteria dell\'Orsa',
            'images': [
              'assets/restaurants/Bologna/orsa.jpg',
              'assets/restaurants/Bologna/orsa2.jpg',
              'assets/restaurants/Bologna/orsa3.jpg'
            ],
            'description': 'Famosa por su auténtica pasta boloñesa y otros platos tradicionales.',
            'hours': 'Lunes a Domingo: 12:00 - 23:00',
            'price': '€15 - €30',
            'location': 'Via Mentana, 1, 40126 Bologna BO, Italia',
          },
          {
            'name': 'Trattoria di Via Serra',
            'images': [
              'assets/restaurants/Bologna/serra.jpg',
              'assets/restaurants/Bologna/serra2.jpg',
              'assets/restaurants/Bologna/serra3.jpg'
            ],
            'description': 'Conocida por su enfoque en ingredientes locales y frescos.',
            'hours': 'Martes a Sábado: 12:30 - 14:30, 19:30 - 22:30',
            'price': '€25 - €45',
            'location': 'Via Luigi Serra, 9/b, 40129 Bologna BO, Italia',
          },
          {
            'name': 'Antica Osteria Romagnola',
            'images': [
              'assets/restaurants/Bologna/romagnola.jpg',
              'assets/restaurants/Bologna/romagnola2.jpg',
              'assets/restaurants/Bologna/romagnola3.jpg'
            ],
            'description': 'Restaurante histórico que ofrece una variedad de platos tradicionales.',
            'hours': 'Lunes a Sábado: 12:00 - 14:30, 19:30 - 22:00',
            'price': '€20 - €40',
            'location': 'Via Rialto, 13, 40124 Bologna BO, Italia',
          },
        ];
      case 'Nueva York':
        return [
          {
            'name': 'Eleven Madison Park',
            'images': [
              'assets/restaurants/NewYork/eleven.jpg',
              'assets/restaurants/NewYork/eleven2.jpg',
              'assets/restaurants/NewYork/eleven3.jpg'
            ],
            'description': 'Restaurante de tres estrellas Michelin conocido por su innovadora cocina contemporánea.',
            'hours': 'Lunes a Domingo: 17:00 - 22:00',
            'price': '\$300 - \$400',
            'location': '11 Madison Ave, New York, NY 10010, Estados Unidos',
          },
          {
            'name': 'Katz\'s Delicatessen',
            'images': [
              'assets/restaurants/NewYork/katz.jpg',
              'assets/restaurants/NewYork/katz2.jpg',
              'assets/restaurants/NewYork/katz3.jpg'
            ],
            'description': 'Famoso deli conocido por su pastrami y sándwiches de carne.',
            'hours': 'Lunes a Domingo: 08:00 - 22:45',
            'price': '\$15 - \$30',
            'location': '205 E Houston St, New York, NY 10002, Estados Unidos',
          },
          {
            'name': 'Le Bernardin',
            'images': [
              'assets/restaurants/NewYork/bernardin.jpg',
              'assets/restaurants/NewYork/bernardin2.jpg',
              'assets/restaurants/NewYork/bernardin3.jpg'
            ],
            'description': 'Restaurante de alta cocina francesa especializado en mariscos.',
            'hours': 'Lunes a Viernes: 12:00 - 14:30, 17:15 - 22:30; Sábado: 17:15 - 22:30',
            'price': '\$150 - \$250',
            'location': '155 W 51st St, New York, NY 10019, Estados Unidos',
          },
        ];
      case 'Bangkok':
        return [
          {
            'name': 'Gaggan',
            'images': [
              'assets/restaurants/Bangkok/gaggan.jpg',
              'assets/restaurants/Bangkok/gaggan2.jpg',
              'assets/restaurants/Bangkok/gaggan3.jpg'
            ],
            'description': 'Restaurante de cocina india progresiva que ha sido votado como el mejor de Asia.',
            'hours': 'Martes a Domingo: 18:00 - 23:00',
            'price': '฿5000 - ฿8000',
            'location': '68 Sukhumvit 31, Khlong Toei Nuea, Watthana, Bangkok 10110, Tailandia',
          },
          {
            'name': 'Jay Fai',
            'images': [
              'assets/restaurants/Bangkok/jayfai.jpg',
              'assets/restaurants/Bangkok/jayfai2.jpg',
              'assets/restaurants/Bangkok/jayfai3.jpg'
            ],
            'description': 'Famosa por su comida callejera de alta calidad y su famosa chef con gafas de esquí.',
            'hours': 'Miércoles a Sábado: 14:30 - 02:00',
            'price': '฿200 - ฿800',
            'location': '327 Maha Chai Rd, Samran Rat, Phra Nakhon, Bangkok 10200, Tailandia',
          },
          {
            'name': 'Paste Bangkok',
            'images': [
              'assets/restaurants/Bangkok/paste.jpg',
              'assets/restaurants/Bangkok/paste2.jpg',
              'assets/restaurants/Bangkok/paste3.jpg'
            ],
            'description': 'Restaurante de alta cocina tailandesa con un enfoque en recetas tradicionales.',
            'hours': 'Lunes a Domingo: 12:00 - 14:00, 18:30 - 23:00',
            'price': '฿1500 - ฿3000',
            'location': 'Gaysorn Village, 999 Ploenchit Rd, Lumpini, Pathumwan, Bangkok 10330, Tailandia',
          },
        ];
      case 'San Sebastián':
        return [
          {
            'name': 'Arzak',
            'images': [
              'assets/restaurants/SanSebastian/arzak.jpg',
              'assets/restaurants/SanSebastian/arzak2.jpg',
              'assets/restaurants/SanSebastian/arzak3.jpg'
            ],
            'description': 'Restaurante de tres estrellas Michelin conocido por su innovadora cocina vasca.',
            'hours': 'Lunes a Viernes: 13:00 - 15:00, 20:30 - 22:30',
            'price': '€200 - €300',
            'location': 'Avenida Alcalde Elosegi Hiribidea, 273, 20015 Donostia-San Sebastián, España',
          },
          {
            'name': 'Mugaritz',
            'images': [
              'assets/restaurants/SanSebastian/mugaritz.jpg',
              'assets/restaurants/SanSebastian/mugaritz2.jpg',
              'assets/restaurants/SanSebastian/mugaritz3.jpg'
            ],
            'description': 'Restaurante de dos estrellas Michelin con una experiencia culinaria única.',
            'hours': 'Miércoles a Domingo: 13:00 - 15:30, 20:00 - 22:00',
            'price': '€180 - €250',
            'location': 'Aldura Aldea, 20, 20100 Errenteria, Gipuzkoa, España',
          },
          {
            'name': 'Akelarre',
            'images': [
              'assets/restaurants/SanSebastian/akelarre.jpg',
              'assets/restaurants/SanSebastian/akelarre2.jpg',
              'assets/restaurants/SanSebastian/akelarre3.jpg'
            ],
            'description': 'Restaurante de tres estrellas Michelin con vistas espectaculares del mar.',
            'hours': 'Martes a Sábado: 13:00 - 15:30, 20:30 - 22:30',
            'price': '€210 - €300',
            'location': 'Paseo Padre Orcolaga, 56, 20008 Donostia-San Sebastián, Gipuzkoa, España',
          },
        ];
      case 'Roma':
        return [
          {
            'name': 'La Pergola',
            'images': [
              'assets/restaurants/Roma/lapergola.jpg',
              'assets/restaurants/Roma/lapergola2.jpg',
              'assets/restaurants/Roma/lapergola3.jpg'
            ],
            'description': 'Restaurante de tres estrellas Michelin con vistas panorámicas de Roma.',
            'hours': 'Martes a Sábado: 19:30 - 23:30',
            'price': '€250 - €350',
            'location': 'Via Alberto Cadlolo, 101, 00136 Roma RM, Italia',
          },
          {
            'name': 'Roscioli',
            'images': [
              'assets/restaurants/Roma/roscioli.jpg',
              'assets/restaurants/Roma/roscioli2.jpg',
              'assets/restaurants/Roma/roscioli3.jpg'
            ],
            'description': 'Famoso por su pasta carbonara y su ambiente acogedor.',
            'hours': 'Lunes a Sábado: 12:30 - 15:00, 19:00 - 23:00',
            'price': '€30 - €50',
            'location': 'Via dei Giubbonari, 21/22, 00186 Roma RM, Italia',
          },
          {
            'name': 'Pizzarium Bonci',
            'images': [
              'assets/restaurants/Roma/pizzarium.jpg',
              'assets/restaurants/Roma/pizzarium2.jpg',
              'assets/restaurants/Roma/pizzarium3.jpg'
            ],
            'description': 'Conocido por su pizza al taglio y sus ingredientes frescos y creativos.',
            'hours': 'Lunes a Sábado: 11:00 - 22:00',
            'price': '€10 - €20',
            'location': 'Via della Meloria, 43, 00136 Roma RM, Italia',
          },
        ];
      case 'Lisboa':
        return [
          {
            'name': 'Belcanto',
            'images': [
              'assets/restaurants/Lisboa/belcanto.jpg',
              'assets/restaurants/Lisboa/belcanto2.jpg',
              'assets/restaurants/Lisboa/belcanto3.jpg'
            ],
            'description': 'Restaurante de dos estrellas Michelin con una reinterpretación moderna de la cocina portuguesa.',
            'hours': 'Martes a Sábado: 12:30 - 15:00, 19:00 - 23:00',
            'price': '€150 - €250',
            'location': 'Largo de São Carlos, 10, 1200-410 Lisboa, Portugal',
          },
          {
            'name': 'Time Out Market Lisboa',
            'images': [
              'assets/restaurants/Lisboa/timeout.jpg',
              'assets/restaurants/Lisboa/timeout2.jpg',
              'assets/restaurants/Lisboa/timeout3.jpg'
            ],
            'description': 'Mercado gastronómico con una gran variedad de platos y productos locales.',
            'hours': 'Lunes a Domingo: 10:00 - 24:00',
            'price': '€10 - €30',
            'location': 'Av. 24 de Julho 49, 1200-479 Lisboa, Portugal',
          },
          {
            'name': 'Cervejaria Ramiro',
            'images': [
              'assets/restaurants/Lisboa/ramiro.jpg',
              'assets/restaurants/Lisboa/ramiro2.jpg',
              'assets/restaurants/Lisboa/ramiro3.jpg'
            ],
            'description': 'Famosa marisquería conocida por sus mariscos frescos y sabrosos.',
            'hours': 'Martes a Domingo: 12:00 - 00:00',
            'price': '€30 - €60',
            'location': 'Av. Almirante Reis nº1 - H, 1150-007 Lisboa, Portugal',
          },
        ];
      default:
        return [];
    }
  }
}
