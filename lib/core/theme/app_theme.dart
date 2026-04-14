import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SiahColors {
  static const Color terracota = Color(0xFFB84C1C);
  static const Color terracotaLight = Color(0xFFD4622A);
  static const Color crema = Color(0xFFF5EFE4);
  static const Color cremaOscura = Color(0xFFE8DCC8);
  static const Color verdeCactus = Color(0xFF5A7A3A);
  static const Color cafe = Color(0xFF6B4C2A);
  static const Color textoPrincipal = Color(0xFF2C1A0E);
  static const Color textoSecundario = Color(0xFF7A5C3A);
  static const Color blanco = Color(0xFFFFFFFF);
  static const Color cardBorde = Color(0xFFDDD0BC);
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: SiahColors.crema,
      colorScheme: const ColorScheme.light(
        primary: SiahColors.terracota,
        secondary: SiahColors.verdeCactus,
        surface: SiahColors.blanco,
        onPrimary: SiahColors.blanco,
        onSurface: SiahColors.textoPrincipal,
      ),
      textTheme: TextTheme(
        // Títulos grandes — estilo bold del diseño
        displayLarge: GoogleFonts.barlow(
          fontSize: 36,
          fontWeight: FontWeight.w900,
          color: SiahColors.terracota,
          letterSpacing: -1,
        ),
        displayMedium: GoogleFonts.barlow(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: SiahColors.textoPrincipal,
        ),
        displaySmall: GoogleFonts.barlow(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: SiahColors.textoPrincipal,
        ),
        // Cuerpo de texto
        bodyLarge: GoogleFonts.nunito(
          fontSize: 15,
          color: SiahColors.textoSecundario,
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.nunito(
          fontSize: 13,
          color: SiahColors.textoSecundario,
        ),
        // Labels pequeños
        labelSmall: GoogleFonts.nunito(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: SiahColors.textoSecundario,
          letterSpacing: 0.8,
        ),
      ),
      

  cardTheme: CardThemeData(
          color: SiahColors.blanco,
          elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: SiahColors.cardBorde, width: 1),
        ),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: SiahColors.crema,
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: SiahColors.textoPrincipal),
        titleTextStyle: GoogleFonts.barlow(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: SiahColors.textoPrincipal,
        ),
      ),
    );
  }
}