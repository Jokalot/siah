import 'package:flutter/material.dart';
import 'screens/weather_screen.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(const SiahApp());
}

class SiahApp extends StatelessWidget {
  const SiahApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,

      // TEMA CLARO
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF5F0E8), // --bg
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFC0511A), // --accent
          primaryContainer: Color(0xFFE07D3C), // --accent-2
          secondaryContainer: Color(0x2EC0511A), // --accent-glow (18% opacidad)
          surface: Color(0xFFF5F0E8), // --bg
          surfaceContainer: Color(0xFFFFFFFF), // --surface
          surfaceContainerLow: Color(0xFFEDE6D6), // --bg2
          onSurface: Color(0xFF2A2218), // --text
          onSurfaceVariant: Color(0xFF6B5E48), // --text-2
          tertiary: Color(0xFF9E8E74), // --text-3 (Mapeado a tertiary)
          outline: Color(0xFFD4C9B0), // --border
        ),
      ),

      // TEMA OSCURO
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF050609), // --bg
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF5C7FA3), // --accent
          primaryContainer: Color(0xFF7895B2), // --accent-2
          secondaryContainer: Color(0x1F5C7FA3), // --accent-glow (12% opacidad)
          surface: Color(0xFF050609), // --bg
          surfaceContainer: Color(0xFF0E111A), // --surface
          surfaceContainerHigh: Color(0xFF131722), // --surface-2
          surfaceContainerLow: Color(0xFF0A0C12), // --bg2
          onSurface: Color(0xFFD1D7E0), // --text
          onSurfaceVariant: Color(0xFF8A95A8), // --text-2
          tertiary: Color(0xFF545E70), // --text-3
          outline: Color(0xFF1E2433), // --border
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF050609),
          elevation: 0,
        ),
      ),
      home: const WeatherScreen(),
    );
  }
}
