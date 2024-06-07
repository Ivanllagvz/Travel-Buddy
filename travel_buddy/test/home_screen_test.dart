// home_screen_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_buddy/Home.dart'; // Asegúrate de que la ruta es correcta

void main() {
  testWidgets('Home screen test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Home()));

    // Verificar que el campo de búsqueda está presente
    expect(find.byType(TextField), findsOneWidget);

    // Verificar que el mapa de Google está presente
    expect(find.byType(GoogleMap), findsOneWidget);

    // Simular la entrada de un país en el campo de búsqueda
    await tester.enterText(find.byType(TextField), 'España');
    await tester.testTextInput.receiveAction(TextInputAction.done); // Simula la tecla de retorno
    await tester.pump();

    // Verificar que las ciudades se actualizan correctamente
    expect(find.text('No cities found'), findsNothing);
  });
}
