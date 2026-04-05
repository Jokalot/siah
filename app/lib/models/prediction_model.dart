class PredictionModel {
  PredictionModel({
    required this.valorPredicho,
    required this.metadata,
    required this.historyData,
  });

  final double? valorPredicho;
  final Metadata? metadata;
  final List<HistoryData>? historyData;

  factory PredictionModel.fromJson(Map<String, dynamic> json) {
    return PredictionModel(
      valorPredicho: json["valor_predicho"],
      metadata: json["metadata"] == null
          ? null
          : Metadata.fromJson(json["metadata"]),
      historyData: json["history_data"] == null
          ? null
          : List<HistoryData>.from(
              json["history_data"].map((x) => HistoryData.fromJson(x)),
            ),
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

class HistoryData {
  HistoryData({required this.year, required this.value});

  final int? year;
  final double? value;

  factory HistoryData.fromJson(Map<String, dynamic> json) {
    return HistoryData(year: json["year"], value: json["value"].toDouble());
  }
}
