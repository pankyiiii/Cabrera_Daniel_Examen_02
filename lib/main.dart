import 'package:flutter/material.dart';
import 'screens/pantalla_uno.dart';

void main() {
  runApp(const FlutterPrueba01());
}

class FlutterPrueba01 extends StatelessWidget {
  const FlutterPrueba01({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Prueba 01',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF558B2F),
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: PantallaUno(),
    );
  }
}
