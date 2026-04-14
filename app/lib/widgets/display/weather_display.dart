import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../services/weather_service.dart';
import '../../models/weather_model.dart';
import '../../models/air_quality_model.dart';

class WeatherDisplay extends StatelessWidget {
  final double lat;
  final double lon;

  const WeatherDisplay({super.key, required this.lat, required this.lon});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final weatherService = GetIt.instance<WeatherService>();

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool useVerticalLayout = constraints.maxWidth < 600;

        return FutureBuilder<dynamic>(
          future: Future.wait([
            weatherService.fetchWeather(lat, lon),
            weatherService.fetchAirPollution(lat, lon),
          ]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (snapshot.hasError ||
                !snapshot.hasData ||
                snapshot.data == null) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(child: Text("Datos no disponibles.")),
              );
            }

            final weather = snapshot.data![0] as WeatherModel;
            final airQuality = snapshot.data![1] as AirQualityModel;

            final heroSection = Column(
              children: [
                Image.network(weather.iconUrl, width: 100, height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${weather.temperature.round()}°",
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.w900,
                        color: cs.onSurface,
                        height: 1,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      _capitalize(weather.description),
                      style: TextStyle(
                        color: cs.onSurfaceVariant,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            );

            final metricsGrid = Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                _MetricCard(
                  label: "Humedad",
                  value: "${weather.humidity}%",
                  icon: Icons.water_drop_rounded,
                  color: Colors.blue,
                ),
                _MetricCard(
                  label: "Viento",
                  value: "${weather.windSpeed} km/h",
                  icon: Icons.air_rounded,
                  color: Colors.cyan,
                ),
                _MetricCard(
                  label: "Calidad Aire",
                  value: airQuality.aqiStatus,
                  icon: Icons.cloud_circle_rounded,
                  color: _getAqiColor(airQuality.aqi),
                  isAqi: true,
                ),
                _MetricCard(
                  label: "Ozono (O3)",
                  value: "${airQuality.o3.round()} µg/m³",
                  icon: Icons.waves_rounded,
                  color: Colors.indigo,
                ),
                _MetricCard(
                  label: "CO",
                  value: "${airQuality.co.round()} µg/m³",
                  icon: Icons.masks_rounded,
                  color: Colors.blueGrey,
                ),
                _MetricCard(
                  label: "NO₂",
                  value: "${airQuality.no2.round()} µg/m³",
                  icon: Icons.science_rounded,
                  color: Colors.orange,
                ),
                _MetricCard(
                  label: "PM2.5",
                  value: "${airQuality.pm25.round()} µg/m³",
                  icon: Icons.grain_rounded,
                  color: Colors.redAccent,
                ),
                _MetricCard(
                  label: "PM10",
                  value: "${airQuality.pm10.round()} µg/m³",
                  icon: Icons.blur_on_rounded,
                  color: Colors.brown,
                ),
              ],
            );

            return useVerticalLayout
                ? Column(
                    children: [
                      heroSection,
                      const SizedBox(height: 20),
                      metricsGrid,
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // --- BLOQUE PRINCIPAL
                      Expanded(flex: 2, child: heroSection),

                      // --- REJILLA DE MÉTRICAS ---
                      Expanded(flex: 3, child: Center(child: metricsGrid)),
                    ],
                  );
          },
        );
      },
    );
  }

  String _capitalize(String text) =>
      text.isEmpty ? "" : "${text[0].toUpperCase()}${text.substring(1)}";

  Color _getAqiColor(int aqi) {
    switch (aqi) {
      case 1:
        return Colors.greenAccent;
      case 2:
        return const Color.fromARGB(255, 155, 165, 16);
      case 3:
        return Colors.orangeAccent;
      case 4:
        return Colors.redAccent;
      case 5:
        return Colors.purpleAccent;
      default:
        return Colors.grey;
    }
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final bool isAqi;

  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.isAqi = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = cs.brightness == Brightness.dark;

    return Container(
      width: 110,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.02 : 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 8),
          Column(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurfaceVariant,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isAqi ? FontWeight.w900 : FontWeight.w700,
                  color: cs.onSurface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
