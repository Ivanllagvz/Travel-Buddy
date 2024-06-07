import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_buddy/loading_screen.dart'; // Asegúrate de que la ruta es correcta

void main() {
  testWidgets('Loading screen test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LoadingScreen(),
      routes: {'/login': (context) => const Scaffold(body: Text('Login Screen'))},
    ));

    // Verificar que el texto 'Travel Buddy' está presente
    expect(find.text('Travel Buddy'), findsOneWidget);

    // Verificar que la imagen de carga está presente
    expect(find.byType(Image), findsOneWidget);

    // Verificar que aún no se ha navegado a '/login'
    expect(find.text('Login Screen'), findsNothing);

    // Avanzar el tiempo en 6 segundos
    await tester.pumpAndSettle(const Duration(seconds: 6));

    // Verificar que se ha navegado a '/login'
    expect(find.text('Login Screen'), findsOneWidget);
  });
}
