import 'package:get_it/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'services/weather_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await dotenv.load();

  final weatherKey = dotenv.env['OPENWEATHER_API_KEY'] ?? "";

  sl.registerLazySingleton(() => WeatherService(apiKey: weatherKey));
}
