import 'package:flutter/material.dart';
import '../panels/weather_control_panel.dart';
import '../display/weather_display.dart';

class WeatherCard extends StatefulWidget {
  const WeatherCard({super.key});

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  DamLocation? _selectedDam;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      color: cs.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: cs.outline, style: BorderStyle.solid),
      ),
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "DATOS DEL CLIMA",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: cs.primary.withValues(alpha: 0.8),
                    letterSpacing: 1.5,
                  ),
                ),
                Icon(
                  Icons.sensors_rounded,
                  size: 16,
                  color: cs.primary.withValues(alpha: 0.5),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Panel de control
            WeatherControlPanel(
              onDamSelected: (dam) {
                setState(() {
                  _selectedDam = dam;
                });
              },
            ),

            Divider(
              height: 60,
              thickness: 0.5,
              color: cs.outlineVariant.withValues(alpha: 0.2),
            ),

            if (_selectedDam != null)
              WeatherDisplay(lat: _selectedDam!.lat, lon: _selectedDam!.lon)
            else
              const Center(child: CircularProgressIndicator()),

            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Fuente: OpenWeatherMap",
                style: TextStyle(
                  fontSize: 12,
                  color: cs.primary.withValues(alpha: 0.8),
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
