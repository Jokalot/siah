import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  final String apiKey;
  final String baseUrl = "https://api.openweathermap.org/data/2.5/weather";

  WeatherService({required this.apiKey});

  Future<WeatherModel?> fetchWeather(double lat, double lon) async {
    final url = "$baseUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric&lang=es";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    }

    return null;
  }
}
