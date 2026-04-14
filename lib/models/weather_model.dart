class WeatherModel {
  final String cityName;
  final double temperature;
  final double tempMin;
  final double tempMax;
  final int humidity;
  final String description;
  final String iconCode;
  final double windSpeed;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.description,
    required this.iconCode,
    required this.windSpeed,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'] ?? 'Ubicación desconocida',
      temperature: (json['main']['temp'] ?? 0.0).toDouble(),
      tempMin: (json['main']['temp_min'] ?? 0.0).toDouble(),
      tempMax: (json['main']['temp_max'] ?? 0.0).toDouble(),
      humidity: json['main']['humidity'] ?? 0,

      description: json['weather'][0]['description'] ?? '',
      iconCode: json['weather'][0]['icon'] ?? '01d',
      windSpeed: (json['wind']['speed'] ?? 0.0).toDouble(),
    );
  }

  // Obtener la URL del icono directamente
  String get iconUrl => "https://openweathermap.org/img/wn/$iconCode@2x.png";
}
