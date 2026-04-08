import 'package:flutter/material.dart';
import 'screens/correlation_screen.dart';

void main() => runApp(const SiahApp());

class SiahApp extends StatelessWidget {
  const SiahApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Seed color for Material 3 dynamic color scheme
    const seedColor = Color(0xFF1565C0);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SIAH — Sistema Inteligente de Análisis de Empleo',
      // ── Light Theme ──
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: seedColor,
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
          scrolledUnderElevation: 1,
        ),
      ),
      // ── Dark Theme ──
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: seedColor,
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
          scrolledUnderElevation: 1,
        ),
      ),
      themeMode: ThemeMode.system,
      home: const CorrelationScreen(),
    );
  }
}
