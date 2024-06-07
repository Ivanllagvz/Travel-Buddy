import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_buddy/EventsScreen.dart'; // Asegúrate de que la ruta es correcta

void main() {
  testWidgets('Events screen test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: EventsScreen(userId: 'testUserId')));

    // Verificar que el AppBar está presente
    expect(find.byKey(const Key('appBarEventos')), findsOneWidget);

    // Verificar que el texto 'No hay eventos para este día' está presente inicialmente
    expect(find.text('No hay eventos para este día'), findsOneWidget);

    // Agregar un evento y verificar que aparece en la lista
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Nuevo Evento');
    await tester.tap(find.text('Agregar'));
    await tester.pumpAndSettle();

    expect(find.text('Nuevo Evento'), findsOneWidget);
  });
}
