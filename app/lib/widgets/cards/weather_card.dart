import 'package:flutter/material.dart';
import '../panels/weather_control_panel.dart';
import '../display/weather_display.dart';

class WeatherCard extends StatefulWidget {
  const WeatherCard({super.key});

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  // El estado: empezamos con la primera presa de la lista
  late DamLocation _selectedDam;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            WeatherControlPanel(
              onDamSelected: (dam) {
                setState(() {
                  _selectedDam = dam;
                });
              },
            ),
            const Divider(height: 32),
            WeatherDisplay(lat: _selectedDam.lat, lon: _selectedDam.lon),
          ],
        ),
      ),
    );
  }
}
