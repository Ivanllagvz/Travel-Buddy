import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';

class GastronomyDetailsScreen extends StatelessWidget {
  final String cityName;

  const GastronomyDetailsScreen({required this.cityName});

  @override
  Widget build(BuildContext context) {
    const Color componentes = Color(0xFF218EBA);
    const Color fondo = Color(0xFFFFA500);

    final foods = getFoodsForCity(cityName);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gastronomía en $cityName',
          style: const TextStyle(fontFamily: 'Pattaya', color: Colors.white),
        ),
        backgroundColor: componentes,
        centerTitle: true,
      ),
      body: Container(
        color: fondo,
        child: Swiper(
          itemCount: foods.length,
          itemBuilder: (BuildContext context, int index) {
            final food = foods[index];
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
                        items: food['images']!.map<Widget>((image) {
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
                            food['name']!,
                            style: GoogleFonts.lato(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            food['description']!,
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

  List<Map<String, dynamic>> getFoodsForCity(String cityName) {
    switch (cityName) {
case 'Madrid':
        return [
          {
            'name': 'Callos a la Madrileña',
            'images': [
              'assets/foods/Madrid/callos.jpg',
              'assets/foods/Madrid/callos2.jpg',
            ],
            'description': 'Plato tradicional madrileño elaborado con tripas de ternera y chorizo.',
          },
          {
            'name': 'Cocido Madrileño',
            'images': [
              'assets/foods/Madrid/cocido.jpg',
              'assets/foods/Madrid/cocido2.jpg',
            ],
            'description': 'Guiso de garbanzos, carne y verduras, típico de Madrid.',
          },
          {
            'name': 'Bocadillo de Calamares',
            'images': [
              'assets/foods/Madrid/bocadillo.jpg',
              'assets/foods/Madrid/bocadillo2.jpg',
            ],
            'description': 'Bocadillo relleno de calamares fritos, popular en Madrid.',
          },
          {
            'name': 'Patatas Bravas',
            'images': [
              'assets/foods/Madrid/patatasbravas.jpg',
              'assets/foods/Madrid/patatasbravas2.jpg',
            ],
            'description': 'Patatas fritas acompañadas de una salsa brava picante.',
          },
          {
            'name': 'Zarajos',
            'images': [
              'assets/foods/Madrid/zarajos.jpg',
              'assets/foods/Madrid/zarajos2.jpg',
            ],
            'description': 'Aperitivo muy típico y tradicional del Madrid castizo, preparado a base de intestinos de cordero lechal marinados que después se enrollan en un pino o sarmiento y se fríen en aceite de oliva o se asan en un horno, o a la plancha.',
          },
          {
            'name': 'Gallinejas',
            'images': [
              'assets/foods/Madrid/gallinejas.jpg',
              'assets/foods/Madrid/gallinejas2.jpg',
            ],
            'description': 'Las gallinejas​ son tripas de cordero o cabrito que se venden en establecimientos habilitados al efecto. Su consumo se localiza casi de modo exclusivo en Madrid.',
          },
        ];

      case 'París':
        return [
          {
            'name': 'Croissant',
            'images': [
              'assets/foods/Paris/croissant.jpg',
              'assets/foods/Paris/croissant2.jpg',
            ],
            'description': 'Panecillo en forma de media luna, típico de la repostería francesa.',
          },
          {
            'name': 'Boeuf Bourguignon',
            'images': [
              'assets/foods/Paris/boeuf.jpg',
              'assets/foods/Paris/boeuf2.jpg',
            ],
            'description': 'Guiso de carne de res cocida en vino tinto, típico de Borgoña.',
          },
          {
            'name': 'Escargots',
            'images': [
              'assets/foods/Paris/escargots.jpg',
              'assets/foods/Paris/escargots2.jpg',
            ],
            'description': 'Caracoles cocidos con mantequilla, ajo y perejil, un plato típico francés.',
          },
        ];
      case 'Tokio':
        return [
          {
            'name': 'Sushi',
            'images': [
              'assets/foods/Tokyo/sushi.jpg',
              'assets/foods/Tokyo/sushi2.jpg',
            ],
            'description': 'Plato japonés de arroz avinagrado acompañado de pescado crudo o mariscos.',
          },
          {
            'name': 'Ramen',
            'images': [
              'assets/foods/Tokyo/ramen.jpg',
              'assets/foods/Tokyo/ramen2.jpg',
            ],
            'description': 'Sopa de fideos japonesa, acompañada de carne, huevo y verduras.',
          },
          {
            'name': 'Tempura',
            'images': [
              'assets/foods/Tokyo/tempura.jpg',
              'assets/foods/Tokyo/tempura2.jpg',
            ],
            'description': 'Mariscos y verduras rebozados y fritos, típicos de la cocina japonesa.',
          },
        ];
      case 'Lyon':
        return [
          {
            'name': 'Quenelle',
            'images': [
              'assets/foods/Lyon/quenelle.jpg',
              'assets/foods/Lyon/quenelle2.jpg',
            ],
            'description': 'Plato típico de Lyon, hecho de una pasta de harina, huevo y carne o pescado.',
          },
          {
            'name': 'Saucisson de Lyon',
            'images': [
              'assets/foods/Lyon/saucisson.jpg',
              'assets/foods/Lyon/saucisson2.jpg',
            ],
            'description': 'Salchichón típico de la región de Lyon, servido a menudo con patatas.',
          },
          {
            'name': 'Tarte à la Praline',
            'images': [
              'assets/foods/Lyon/tarte.jpg',
              'assets/foods/Lyon/tarte2.jpg',
            ],
            'description': 'Tarta dulce hecha con pralina roja, típica de Lyon.',
          },
        ];
      case 'Bologna':
        return [
          {
            'name': 'Tagliatelle al Ragù',
            'images': [
              'assets/foods/Bologna/tagliatelle.jpg',
              'assets/foods/Bologna/tagliatelle2.jpg',
            ],
            'description': 'Pasta de cinta ancha con salsa de carne, típica de Bolonia.',
          },
          {
            'name': 'Lasagna alla Bolognese',
            'images': [
              'assets/foods/Bologna/lasagna.jpg',
              'assets/foods/Bologna/lasagna2.jpg',
            ],
            'description': 'Plato de capas de pasta, carne y bechamel, típico de Bolonia.',
          },
          {
            'name': 'Mortadella',
            'images': [
              'assets/foods/Bologna/mortadella.jpg',
              'assets/foods/Bologna/mortadella2.jpg',
            ],
            'description': 'Embutido típico de Bolonia, similar al jamón cocido.',
          },
        ];
      case 'Nueva York':
        return [
          {
            'name': 'Pizza estilo Nueva York',
            'images': [
              'assets/foods/NewYork/pizza.jpg',
              'assets/foods/NewYork/pizza2.jpg',
            ],
            'description': 'Pizza de masa delgada y grande, típica de Nueva York.',
          },
          {
            'name': 'Bagel',
            'images': [
              'assets/foods/NewYork/bagel.jpg',
              'assets/foods/NewYork/bagel2.jpg',
            ],
            'description': 'Pan redondo con un agujero en el medio, típico de Nueva York.',
          },
          {
            'name': 'Cheesecake estilo Nueva York',
            'images': [
              'assets/foods/NewYork/cheesecake.jpg',
              'assets/foods/NewYork/cheesecake2.jpg',
            ],
            'description': 'Pastel de queso cremoso, típico de Nueva York.',
          },
        ];
      case 'Bangkok':
        return [
          {
            'name': 'Pad Thai',
            'images': [
              'assets/foods/Bangkok/padthai.jpg',
              'assets/foods/Bangkok/padthai2.jpg',
            ],
            'description': 'Fideos de arroz salteados con huevo, tofu, gambas y brotes de soja.',
          },
          {
            'name': 'Tom Yum Goong',
            'images': [
              'assets/foods/Bangkok/tomyum.jpg',
              'assets/foods/Bangkok/tomyum2.jpg',
            ],
            'description': 'Sopa picante de gambas, típica de la cocina tailandesa.',
          },
          {
            'name': 'Som Tum',
            'images': [
              'assets/foods/Bangkok/somtum.jpg',
              'assets/foods/Bangkok/somtum2.jpg',
            ],
            'description': 'Ensalada de papaya verde, típica de Tailandia.',
          },
        ];
      case 'San Sebastián':
        return [
          {
            'name': 'Pintxos',
            'images': [
              'assets/foods/SanSebastian/pintxos.jpg',
              'assets/foods/SanSebastian/pintxos2.jpg',
            ],
            'description': 'Pequeñas porciones de comida, servidas en bares y tabernas.',
          },
          {
            'name': 'Txangurro',
            'images': [
              'assets/foods/SanSebastian/txangurro.jpg',
              'assets/foods/SanSebastian/txangurro2.jpg',
            ],
            'description': 'Centollo al horno, típico de la cocina vasca.',
          },
          {
            'name': 'Bacalao a la Vizcaína',
            'images': [
              'assets/foods/SanSebastian/bacalao.jpg',
              'assets/foods/SanSebastian/bacalao2.jpg',
            ],
            'description': 'Plato de bacalao con salsa de pimientos choriceros, típico del País Vasco.',
          },
        ];
      case 'Roma':
        return [
          {
            'name': 'Pasta Carbonara',
            'images': [
              'assets/foods/Rome/carbonara.jpg',
              'assets/foods/Rome/carbonara2.jpg',
            ],
            'description': 'Pasta con huevo, queso, panceta y pimienta, típica de Roma.',
          },
          {
            'name': 'Pizza al Taglio',
            'images': [
              'assets/foods/Rome/pizza.jpg',
              'assets/foods/Rome/pizza2.jpg',
            ],
            'description': 'Pizza servida en porciones cuadradas, típica de Roma.',
          },
          {
            'name': 'Gelato',
            'images': [
              'assets/foods/Rome/gelato.jpg',
              'assets/foods/Rome/gelato2.jpg',
            ],
            'description': 'Helado italiano, cremoso y con diversos sabores.',
          },
        ];
      case 'Lisboa':
        return [
          {
            'name': 'Pastel de Nata',
            'images': [
              'assets/foods/Lisbon/pasteldenata.jpg',
              'assets/foods/Lisbon/pasteldenata2.jpg',
            ],
            'description': 'Pequeños pasteles de hojaldre rellenos de crema, típicos de Lisboa.',
          },
          {
            'name': 'Bacalhau à Brás',
            'images': [
              'assets/foods/Lisbon/bacalhau.jpg',
              'assets/foods/Lisbon/bacalhau2.jpg',
            ],
            'description': 'Plato de bacalao desmenuzado con patatas y huevo, típico de Lisboa.',
          },
          {
            'name': 'Caldo Verde',
            'images': [
              'assets/foods/Lisbon/caldoverde.jpg',
              'assets/foods/Lisbon/caldoverde2.jpg',
            ],
            'description': 'Sopa de col rizada y patatas, típica de la cocina portuguesa.',
          },
        ];
      default:
        return [];
    }
  }
}
