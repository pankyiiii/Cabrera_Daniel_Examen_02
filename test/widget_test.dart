import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_prueba_01/main.dart';

void main() {
  testWidgets('El proyecto base permite avanzar entre las tres pantallas', (tester) async {
    await tester.pumpWidget(const FlutterPrueba01());
    expect(find.text('VENTANA (UNO)'), findsOneWidget);
    await tester.tap(find.widgetWithText(ElevatedButton, 'Siguiente'));
    await tester.pumpAndSettle();
    expect(find.text('VENTANA (DOS)'), findsOneWidget);
    await tester.tap(find.widgetWithText(ElevatedButton, 'Siguiente'));
    await tester.pumpAndSettle();
    expect(find.text('VENTANA (TRES)'), findsOneWidget);
  });
}
