import 'package:flutter/material.dart';
import 'package:proyecto_siah/core/theme/app_theme.dart';
import 'package:proyecto_siah/screens/splash_screen.dart';

void main() {
  runApp(const SiahApp());
}

class SiahApp extends StatelessWidget {
  const SiahApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIAH',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const SplashScreen(),
    );
  }
}