import 'package:flutter/material.dart';
import '../services/siah_service.dart';
import '../models/prediction_model.dart';
import '../widgets/cards/sector_card.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String fechaNow = "${now.year}-${now.month}-${now.day}";

    return Scaffold(
      appBar: AppBar(title: const Text("SIAH - Predicciones de Empleo")),
      body: FutureBuilder<List<PredictionModel?>>(
        future: Future.wait([
          apiService.getPrediction("Agro", fechaNow),
          apiService.getPrediction("Construccion", fechaNow),
          apiService.getPrediction("Manufactura", fechaNow),
          apiService.getPrediction("Servicios", fechaNow),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == null) {
            return Center(child: Text("Error al conectar con la IA de Sonora"));
          }

          final results = snapshot.data!;
          final agro = results[0];
          final construccion = results[1];
          final manufactura = results[2];
          final servicios = results[3];

          return LayoutBuilder(
            builder: (context, constraints) {
              bool isWide = constraints.maxWidth > 1100;

              if (isWide) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1500),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (agro != null)
                                Expanded(
                                  child: SectorPredictionCard(
                                    data: agro,
                                    sectorName: "Agropecuario",
                                    sectorDescription:
                                        "Argricultura y ganadería",
                                    sectorIcon: Icons.agriculture,
                                    primaryColor: Colors.green,
                                  ),
                                ),
                              if (agro != null && construccion != null)
                                const SizedBox(width: 20),
                              if (construccion != null)
                                Expanded(
                                  child: SectorPredictionCard(
                                    data: construccion,
                                    sectorName: "Construcción",
                                    sectorDescription:
                                        "Edificación e infraestructura",
                                    sectorIcon: Icons.construction,
                                    primaryColor: Colors.orange,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (manufactura != null)
                                Expanded(
                                  child: SectorPredictionCard(
                                    data: manufactura,
                                    sectorName: "Manufactura",
                                    sectorDescription:
                                        "Industria de transformación",
                                    sectorIcon: Icons.precision_manufacturing,
                                    primaryColor: Colors.red,
                                  ),
                                ),
                              if (manufactura != null && servicios != null)
                                const SizedBox(width: 20),
                              if (servicios != null)
                                Expanded(
                                  child: SectorPredictionCard(
                                    data: servicios,
                                    sectorName: "Servicios",
                                    sectorDescription:
                                        "Sector terciario y consultoría",
                                    sectorIcon: Icons.miscellaneous_services,
                                    primaryColor: const Color(0xFF00CED1),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    if (agro != null)
                      SectorPredictionCard(
                        data: agro,
                        sectorName: "Agropecuario",
                        sectorDescription: "Argricultura y ganadería",
                        sectorIcon: Icons.agriculture,
                        primaryColor: Colors.green,
                      ),
                    const SizedBox(height: 20),
                    if (construccion != null)
                      SectorPredictionCard(
                        data: construccion,
                        sectorName: "Construcción",
                        sectorDescription: "Edificación e infraestructura",
                        sectorIcon: Icons.construction,
                        primaryColor: Colors.orange,
                      ),
                    const SizedBox(height: 20),
                    if (manufactura != null)
                      SectorPredictionCard(
                        data: manufactura,
                        sectorName: "Manufactura",
                        sectorDescription: "Industria de transformación",
                        sectorIcon: Icons.precision_manufacturing,
                        primaryColor: Colors.red,
                      ),
                    const SizedBox(height: 20),
                    if (servicios != null)
                      SectorPredictionCard(
                        data: servicios,
                        sectorName: "Servicios",
                        sectorDescription: "Sector terciario y consultoría",
                        sectorIcon: Icons.miscellaneous_services,
                        primaryColor: const Color(0xFF00CED1),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
