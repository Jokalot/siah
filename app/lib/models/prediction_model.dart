class PredictionModel {
  PredictionModel({
    required this.valorPredicho,
    required this.interpretacion,
    required this.metadata,
  });

  final double? valorPredicho;
  final String? interpretacion;
  final Metadata? metadata;

  factory PredictionModel.fromJson(Map<String, dynamic> json) {
    return PredictionModel(
      valorPredicho: json["valor_predicho"],
      interpretacion: json["interpretacion"],
      metadata: json["metadata"] == null
          ? null
          : Metadata.fromJson(json["metadata"]),
    );
  }
}

class Metadata {
  Metadata({required this.sector, required this.r2});

  final String? sector;
  final double? r2;

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(sector: json["sector"], r2: json["r2"]);
  }
}
