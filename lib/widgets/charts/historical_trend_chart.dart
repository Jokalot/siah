import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/correlation_model.dart';
import '../../models/sector_def.dart';

class CorrelationCard extends StatelessWidget {
  final CorrelationModel correlation;
  final SectorDef sector;

  const CorrelationCard({
    super.key,
    required this.correlation,
    required this.sector,
  });

  bool isDarkTheme(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  double calculateMultiplier() {
    if (correlation.data.isEmpty) return 1.0;

    final double maxEmpleo = correlation.data
        .map((e) => e.empleo?.toDouble() ?? 0.0)
        .where((v) => v.isFinite)
        .fold(0.0, max);
    final double maxFactor = correlation.data
        .map((e) => e.factorValor?.toDouble() ?? 0.0)
        .where((v) => v.isFinite)
        .fold(0.0, max);

    // Multiplicador para emparejar con el empleo. Evitamos división por casi cero.
    if (maxFactor < 0.0001) return 1.0;

    final multiplier = maxEmpleo / maxFactor;
    return multiplier.isFinite ? multiplier : 1.0;
  }

  Color _getTrendColor(double score) {
    if (!score.isFinite) return Colors.orange;
    if (score.abs() >= 0.7) {
      return score > 0 ? Colors.green : Colors.red;
    } else {
      return Colors.orange;
    }
  }

  String get _factorLabel {
    final factor = sector.factors.firstWhere(
      (f) => f.apiKey == correlation.factorNombre,
      orElse: () =>
          FactorDef(label: correlation.factorNombre ?? 'Factor', apiKey: ''),
    );
    return factor.label;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkTheme(context);

    if (correlation.data.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // HEADER DE LA CORRELACIÓN
          Container(
            padding: const EdgeInsets.all(16),
            color: sector.color.withValues(alpha: isDark ? 0.2 : 0.1),
            child: Row(
              children: [
                Icon(Icons.analytics_outlined, color: sector.color),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tendencia sobre el sector ${sector.label}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        _factorLabel,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getTrendColor(
                      correlation.correlationScore!,
                    ).withValues(alpha: isDark ? 0.25 : 0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _getTrendColor(correlation.correlationScore!),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        correlation.correlationScore!.abs() >= 0.7
                            ? Icons.trending_up_rounded
                            : Icons.trending_flat_rounded,
                        size: 14,
                        color: _getTrendColor(correlation.correlationScore!),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'r = ${correlation.correlationScore?.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: _getTrendColor(correlation.correlationScore!),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // CUERPO DE LA GRÁFICA
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 24, 16),
            child: Column(
              children: [
                SizedBox(height: 600, child: LineChart(_mainData(isDark))),
                const SizedBox(height: 20),

                // LEYENDA
                _buildLegend(isDark),
              ],
            ),
          ),
        ],
      ),
    );
  }

  LineChartData _mainData(bool isDark) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) => FlLine(
          color: isDark ? Colors.white10 : Colors.black12,
          strokeWidth: 1,
        ),
      ),
      titlesData: FlTitlesData(
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 5,
            getTitlesWidget: (value, meta) => Text(
              value.toInt().toString(),
              style: TextStyle(
                color: isDark ? Colors.white60 : Colors.black54,
                fontSize: 10,
              ),
            ),
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        // LÍNEA 1: SECTOR
        LineChartBarData(
          spots: correlation.data.map((e) {
            final x = e.year?.toDouble() ?? 0.0;
            final y = e.empleo?.toDouble() ?? 0.0;
            return FlSpot(x.isFinite ? x : 0.0, y.isFinite ? y : 0.0);
          }).toList(),
          isCurved: true,
          color: sector.color,
          barWidth: 3,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
        ),

        // LÍNEA 2: FACTOR EXTERNO
        LineChartBarData(
          spots: correlation.data.map((e) {
            final x = e.year?.toDouble() ?? 0.0;
            final y =
                (e.factorValor?.toDouble() ?? 0.0) * calculateMultiplier();
            return FlSpot(x.isFinite ? x : 0.0, y.isFinite ? y : 0.0);
          }).toList(),
          isCurved: true,
          color: Colors.blueAccent,
          barWidth: 2,
          dashArray: [5, 5],
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            color: Colors.blueAccent.withValues(alpha: 0.1),
          ),
        ),
      ],
    );
  }

  Widget _buildLegend(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _legendItem("Empleo ${sector.label}", sector.color),
        const SizedBox(width: 20),
        _legendItem(_factorLabel, Colors.blueAccent, isDashed: true),
      ],
    );
  }

  Widget _legendItem(String text, Color color, {bool isDashed = false}) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 3,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
