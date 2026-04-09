import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../services/weather_service.dart';
import '../../models/weather_model.dart';

class WeatherDisplay extends StatelessWidget {
  final double lat;
  final double lon;

  const WeatherDisplay({super.key, required this.lat, required this.lon});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    // Obtenemos la instancia del servicio desde GetIt
    final weatherService = GetIt.instance<WeatherService>();

    return FutureBuilder<WeatherModel?>(
      future: weatherService.fetchWeather(lat, lon),
      builder: (context, snapshot) {
        // 1. Estado de carga (Shimmer o Spinner)
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // 2. Estado de Error
        if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text("Clima no disponible"));
        }

        final weather = snapshot.data!;

        // 3. Estado de Éxito (Interfaz de Clima)
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${weather.temperature.round()}°C",
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: cs.onSurface,
                  ),
                ),
                Text(
                  // Capitalizamos la descripción
                  "${weather.description[0].toUpperCase()}${weather.description.substring(1)}",
                  style: TextStyle(color: cs.onSurfaceVariant),
                ),
              ],
            ),
            Column(
              children: [
                // Imagen dinámica desde OpenWeather
                Image.network(weather.iconUrl, width: 64, height: 64),
                Text(
                  "Hum: ${weather.humidity}%",
                  style: TextStyle(fontSize: 12, color: cs.primary),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
