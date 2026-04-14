import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyecto_siah/models/prediction_model.dart';
import 'package:proyecto_siah/models/correlation_model.dart';

class ApiService {
  final String baseUrl = "http://127.0.0.1:8000";

  Future<PredictionModel?> getPrediction(String sector, String fecha) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/predict"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"sector": sector, "fecha": fecha}),
      );

      if (response.statusCode == 200) {
        return PredictionModel.fromJson(jsonDecode(response.body));
      } else {
        print("Error en la API: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error de conexión: $e");
      return null;
    }
  }

  Future<CorrelationModel?> getCorrelation(
    String sector, [
    String? factorKey,
    int lag = 0,
  ]) async {
    try {
      final response = await http.get(
        Uri.parse(
          "$baseUrl/correlations?sector=$sector&factor_key=$factorKey&lag=$lag",
        ),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return CorrelationModel.fromJson(jsonResponse);
      } else {
        print("Error en la API de correlación: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error de conexión en correlación: $e");
      return null;
    }
  }
}
