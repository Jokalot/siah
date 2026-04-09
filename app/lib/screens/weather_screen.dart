import 'package:flutter/material.dart';

import '../widgets/panels/weather_control_panel.dart';
import '../widgets/display/weather_display.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // Estado inicial: Tomamos la primera ubicación por defecto
  // Nota: Asegúrate que DamLocation sea accesible o impórtalo
  DamLocation? _selectedDam;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Monitoreo Climático"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Panel de Control (Selector de Presas)
            Card(
              elevation: 0,
              color: cs.surfaceContainerLow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: cs.outlineVariant.withOpacity(0.3)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: WeatherControlPanel(
                  onDamSelected: (dam) {
                    setState(() {
                      _selectedDam = dam;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 2. Título de la sección de tiempo real
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Condiciones en Tiempo Real",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 12),

            // 3. Card de Clima Actual
            if (_selectedDam != null)
              Card(
                elevation: 4,
                shadowColor: Colors.black26,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        cs.primaryContainer.withOpacity(0.4),
                        cs.surface,
                      ],
                    ),
                  ),
                  child: WeatherDisplay(
                    lat: _selectedDam!.lat,
                    lon: _selectedDam!.lon,
                  ),
                ),
              )
            else
              const Center(child: CircularProgressIndicator()),

            const SizedBox(height: 32),

            // 4. Espacio para las gráficas históricas (Siguiente paso)
            _buildPlaceholder(
              context,
              "Historial de Precipitación",
              Icons.bar_chart,
            ),
            const SizedBox(height: 16),
            _buildPlaceholder(context, "Nivel del Embalse (Hm³)", Icons.waves),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para las secciones que aún no desarrollas
  Widget _buildPlaceholder(BuildContext context, String title, IconData icon) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: cs.outlineVariant.withOpacity(0.2),
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: cs.onSurfaceVariant.withOpacity(0.5), size: 32),
          const SizedBox(height: 12),
          Text(
            "$title - Próximamente",
            style: TextStyle(color: cs.onSurfaceVariant.withOpacity(0.5)),
          ),
        ],
      ),
    );
  }
}
