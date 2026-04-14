class AirQualityModel {
  final int aqi; // Índice de Calidad del Aire (1-5)
  final double co;
  final double no2;
  final double o3;
  final double pm25;
  final double pm10;
  final double nh3;

  AirQualityModel({
    required this.aqi,
    required this.co,
    required this.no2,
    required this.o3,
    required this.pm25,
    required this.pm10,
    required this.nh3,
  });

  factory AirQualityModel.fromJson(Map<String, dynamic> json) {
    final data = json['list'][0];
    final components = data['components'];

    return AirQualityModel(
      aqi: data['main']['aqi'] ?? 1,
      co: (components['co'] ?? 0.0).toDouble(),
      no2: (components['no2'] ?? 0.0).toDouble(),
      o3: (components['o3'] ?? 0.0).toDouble(),
      pm25: (components['pm2_5'] ?? 0.0).toDouble(),
      pm10: (components['pm10'] ?? 0.0).toDouble(),
      nh3: (components['nh3'] ?? 0.0).toDouble(),
    );
  }

  // Mostrar el texto según el índice de calidad del aire
  String get aqiStatus {
    switch (aqi) {
      case 1:
        return "Excelente";
      case 2:
        return "Bueno";
      case 3:
        return "Moderado";
      case 4:
        return "Pobre";
      case 5:
        return "Muy Pobre";
      default:
        return "Desconocido";
    }
  }
}
