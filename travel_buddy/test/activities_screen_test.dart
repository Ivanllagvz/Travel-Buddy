import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_buddy/ActivitiesScreen.dart'; // Asegúrate de que la ruta es correcta

void main() {
  testWidgets('Activities screen test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ActivitiesScreen()));

    // Verificar que las tarjetas de actividades están presentes
    expect(find.byType(Card), findsWidgets);

    // Verificar que la barra de navegación está presente
    expect(find.byType(BottomNavigationBar), findsOneWidget);

    // Simular un tap en una actividad
    await tester.tap(find.text('Museos'));
    await tester.pump();

    // Puedes agregar más verificaciones aquí
  });
}
