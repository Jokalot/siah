import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/prediction_model.dart';

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
}
