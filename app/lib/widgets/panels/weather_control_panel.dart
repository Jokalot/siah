import 'package:flutter/material.dart';
import '../cards/weather_card.dart';

class WeatherControlPanel extends StatefulWidget {
  final Function(DamLocation) onDamSelected;

  const WeatherControlPanel({super.key, required this.onDamSelected});

  @override
  State<WeatherControlPanel> createState() => _WeatherControlPanelState();
}

class _WeatherControlPanelState extends State<WeatherControlPanel> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onDamSelected(_damLocations[_selectedIndex]);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Seleccionar presa",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: cs.primary,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          children: List<Widget>.generate(_damLocations.length, (int index) {
            return FilterChip(
              label: Text(_damLocations[index].name),
              selected: _selectedIndex == index,
              onSelected: (bool selected) {
                setState(() {
                  _selectedIndex = index;
                });
                widget.onDamSelected(_damLocations[index]);
              },
              selectedColor: cs.primaryContainer,
              checkmarkColor: cs.primary,
            );
          }),
        ),
      ],
    );
  }
}

class DamLocation {
  final String name;
  final double lat;
  final double lon;

  const DamLocation({required this.name, required this.lat, required this.lon});
}

const List<DamLocation> _damLocations = [
  DamLocation(name: "Mocúzari", lat: 27.2355, lon: -109.0211),
  DamLocation(name: "El Novillo", lat: 28.9758, lon: -109.6322),
  DamLocation(name: "El Molinito", lat: 29.2052, lon: -110.8234),
  DamLocation(name: "Oviáchic", lat: 27.7936, lon: -109.8911),
];
