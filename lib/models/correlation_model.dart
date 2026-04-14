class CorrelationModel {
  CorrelationModel({
    required this.correlationScore,
    required this.factorNombre,
    required this.regression,
    required this.data,
  });

  final double? correlationScore;
  final String? factorNombre;
  final Regression? regression;
  final List<Datum> data;

  factory CorrelationModel.fromJson(Map<String, dynamic> json) {
    return CorrelationModel(
      correlationScore: json["correlation_score"],
      factorNombre: json["factor_name"],
      regression: json["regression_line"] == null
          ? null
          : Regression.fromJson(json["regression_line"]),
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }
}

class Datum {
  Datum({required this.year, required this.empleo, required this.factorValor});

  final int? year;
  final int? empleo;
  final double? factorValor;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      year: (json["year"] as num?)?.round(),
      empleo: (json["empleo"] as num?)?.round(),
      factorValor: (json["factor_valor"] as num?)?.toDouble(),
    );
  }
}

class Regression {
  Regression({required this.m, required this.b, required this.trendLine});

  final double? m;
  final double? b;
  final List<TrendLine> trendLine;

  factory Regression.fromJson(Map<String, dynamic> json) {
    return Regression(
      m: (json["m"] as num?)?.toDouble(),
      b: (json["b"] as num?)?.toDouble(),
      trendLine: json["trend_line"] == null
          ? []
          : List<TrendLine>.from(
              json["trend_line"]!.map((x) => TrendLine.fromJson(x)),
            ),
    );
  }
}

class TrendLine {
  TrendLine({required this.x, required this.y});

  final double? x;
  final double? y;

  factory TrendLine.fromJson(Map<String, dynamic> json) {
    return TrendLine(
      x: (json["x"] as num?)?.toDouble(),
      y: (json["y"] as num?)?.toDouble(),
    );
  }
}

/*
{
	"correlation_score": 0.9649,
	"factor_nombre": "External Demand",
	"regression": {
		"m": 12.54,
		"b": 1500.2,
		"trend_line": [
			{
				"x": 10,
				"y": 1625.6
			},
			{
				"x": 100,
				"y": 2754.2
			}
		]
	},
	"data": [
		{
			"year": 2024,
			"empleo": 60365,
			"factor_valor": 1362.45
		}
	]
}*/
