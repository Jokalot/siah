// En lib/main.dart
import 'package:flutter/material.dart';
import 'screens/prediction_screen.dart'; // Importa tu pantalla

void main() => runApp(SiahApp());

class SiahApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SIAH',
      theme: ThemeData.dark(),
      home: PredictionScreen(),
    );
  }
}
