import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/prediction_model.dart';

class PredictionScreen extends StatefulWidget {
  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SIAH - Predicción Agro")),
      body: FutureBuilder<PredictionModel?>(
        future: apiService.getPrediction(
          "Agro",
          "2026-04-02",
        ), // Llamamos a tu API
        builder: (context, snapshot) {
          // 1. Mientras carga...
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          // 2. Si hubo un error...
          else if (snapshot.hasError || snapshot.data == null) {
            return Center(child: Text("Error al conectar con la IA de Sonora"));
          }

          // 3. Cuando los datos llegan...
          final prediction = snapshot.data!;
          return Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  "Predicción: ${prediction.valorPredicho}",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(prediction.interpretacion!),
                SizedBox(height: 20),
                Text("Confiabilidad (R2): ${prediction.metadata?.r2 ?? 'N/A'}"),
              ],
            ),
          );
        },
      ),
    );
  }
}
