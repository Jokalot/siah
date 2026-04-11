import 'package:flutter/material.dart';

import '../widgets/cards/weather_card.dart';
import '../core/constants/app_asserts.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SizedBox.expand(
        child: Stack(
          children: [
            Positioned.fill(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: Opacity(
                  key: ValueKey(isDark),
                  opacity: isDark ? 0.22 : 0.18,
                  child: Image.asset(
                    isDark
                        ? AppAssets.nightBackground
                        : AppAssets.dayBackground,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final maxWidth = constraints.maxWidth;

                  final isDesktop = maxWidth > 900;
                  final spacing = 20.0;

                  final itemWidth = isDesktop
                      ? (maxWidth - (spacing * 3)) / 2
                      : maxWidth - (spacing * 2);

                  return SingleChildScrollView(
                    padding: EdgeInsets.all(spacing),
                    child: Center(
                      child: Wrap(
                        spacing: spacing,
                        runSpacing: spacing,
                        alignment: WrapAlignment.center,
                        children: [
                          SizedBox(
                            width: itemWidth,
                            child: const WeatherCard(),
                          ),
                          SizedBox(
                            width: itemWidth,
                            child: _buildPlaceholder(
                              context,
                              "Historial de Precipitación",
                              Icons.bar_chart,
                            ),
                          ),
                          SizedBox(
                            width: itemWidth,
                            child: _buildPlaceholder(
                              context,
                              "Pronóstico del Tiempo",
                              Icons.cloud,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context, String title, IconData icon) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: cs.outlineVariant.withValues(alpha: 0.2),
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: cs.onSurfaceVariant.withValues(alpha: 0.5),
            size: 32,
          ),
          const SizedBox(height: 12),
          Text(
            "$title - Próximamente",
            style: TextStyle(color: cs.onSurfaceVariant.withValues(alpha: 0.5)),
          ),
        ],
      ),
    );
  }
}
