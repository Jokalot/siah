import 'package:flutter/material.dart';
import '../cards/weather_card.dart';
import 'package:flutter/material.dart';

class WeatherControlPanel extends StatefulWidget {
  final Function(DamLocation) onDamSelected;

  const WeatherControlPanel({super.key, required this.onDamSelected});

  @override
  State<WeatherControlPanel> createState() => _WeatherControlPanelState();
}

class _WeatherControlPanelState extends State<WeatherControlPanel> {
  int _selectedIndex = 0;
  int? _hoveredIndex;

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.water_drop_outlined, size: 18, color: cs.primary),
            const SizedBox(width: 8),
            Text(
              "Seleccionar ubicación de presa",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: cs.onSurfaceVariant,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List<Widget>.generate(_damLocations.length, (int index) {
            final isSelected = _selectedIndex == index;
            return ChoiceChip(
              label: Text(_damLocations[index].name),
              selected: isSelected,
              onSelected: (bool selected) {
                if (selected) {
                  setState(() {
                    _selectedIndex = index;
                  });
                  widget.onDamSelected(_damLocations[index]);
                }
              },
              showCheckmark: false,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : cs.onSurface,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              selectedColor: cs.primary,
              backgroundColor: cs.surfaceContainerHigh,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: isSelected ? cs.primary : cs.outline),
              ),
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
