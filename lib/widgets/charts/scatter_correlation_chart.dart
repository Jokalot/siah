import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/correlation_model.dart';
import '../../models/sector_def.dart';

class ScatterCorrelationChart extends StatelessWidget {
  final CorrelationModel correlation;
  final SectorDef sector;

  const ScatterCorrelationChart({
    super.key,
    required this.correlation,
    required this.sector,
  });

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
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (correlation.data.isEmpty) {
      return Center(
        child: Text(
          'Sin datos para graficar',
          style: TextStyle(color: cs.onSurfaceVariant),
        ),
      );
    }

    final factorValues = correlation.data
        .map((d) => d.factorValor?.toDouble() ?? 0.0)
        .where((v) => v.isFinite)
        .toList();
    final empleoValues = correlation.data
        .map((d) => d.empleo?.toDouble() ?? 0.0)
        .where((v) => v.isFinite)
        .toList();

    if (factorValues.isEmpty || empleoValues.isEmpty) {
      return const Center(child: Text('Datos numéricos inválidos'));
    }

    final minX = factorValues.reduce(min);
    final maxX = factorValues.reduce(max);
    final minY = empleoValues.reduce(min);
    final maxY = empleoValues.reduce(max);

    // Padding robusto
    final dx = (maxX - minX).abs();
    final dy = (maxY - minY).abs();

    // Aseguramos que el padding nunca resulte en un rango de 0
    final xPad = dx < 0.01 ? (minX.abs() * 0.1).clamp(1.0, 100.0) : dx * 0.15;
    final yPad = dy < 0.01 ? (minY.abs() * 0.1).clamp(1.0, 100.0) : dy * 0.15;

    final chartMinX = (minX - xPad).isFinite ? (minX - xPad) : minX - 1.0;
    final chartMaxX = (maxX + xPad).isFinite ? (maxX + xPad) : maxX + 1.0;
    final chartMinY = (minY - yPad).isFinite ? (minY - yPad) : minY - 1.0;
    final chartMaxY = (maxY + yPad).isFinite ? (maxY + yPad) : maxY + 1.0;

    // ── Layer 0: Observation Points ──
    final scatterSpots = correlation.data.map((d) {
      final x = d.factorValor?.toDouble() ?? 0.0;
      final y = d.empleo?.toDouble() ?? 0.0;
      return FlSpot(x.isFinite ? x : 0.0, y.isFinite ? y : 0.0);
    }).toList()..sort((a, b) => a.x.compareTo(b.x));

    // ── Layer 1: Regression Line ──
    final List<FlSpot> regressionSpots;
    final reg = correlation.regression;
    if (reg != null &&
        reg.m != null &&
        reg.b != null &&
        reg.m!.isFinite &&
        reg.b!.isFinite) {
      final m = reg.m!;
      final b = reg.b!;
      final xStart = chartMinX;
      final xEnd = chartMaxX;

      final yStart = m * xStart + b;
      final yEnd = m * xEnd + b;

      if (yStart.isFinite && yEnd.isFinite) {
        regressionSpots = [FlSpot(xStart, yStart), FlSpot(xEnd, yEnd)];
      } else {
        regressionSpots = [];
      }
    } else {
      regressionSpots = [];
    }

    // Texto del puntaje y color
    final score = correlation.correlationScore ?? 0.0;
    final scoreStr = score.toStringAsFixed(4);
    final scoreColor = score.abs() >= 0.7
        ? (score > 0 ? const Color(0xFF4CAF50) : const Color(0xFFF44336))
        : const Color(0xFFFF9800);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      color: cs.surfaceContainerLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // HEADER
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  sector.color.withValues(alpha: isDark ? 0.22 : 0.10),
                  sector.color.withValues(alpha: isDark ? 0.08 : 0.02),
                ],
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.scatter_plot_rounded, color: sector.color, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Correlación sobre el sector ${sector.label}',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: cs.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _factorLabel,
                        style: TextStyle(
                          fontSize: 12,
                          color: cs.onSurfaceVariant,
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
                    color: scoreColor.withValues(alpha: isDark ? 0.25 : 0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: scoreColor.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        score.abs() >= 0.7
                            ? Icons.trending_up_rounded
                            : Icons.trending_flat_rounded,
                        size: 14,
                        color: scoreColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'r = $scoreStr',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: scoreColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // CHART AREA
          SizedBox(
            height: 600,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 40, 20),
              child: LineChart(
                LineChartData(
                  clipData: FlClipData.all(),
                  minX: chartMinX,
                  maxX: chartMaxX,
                  minY: chartMinY,
                  maxY: chartMaxY,
                  lineTouchData: LineTouchData(
                    enabled: true,
                    handleBuiltInTouches: true,
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipColor: (_) => cs.inverseSurface,
                      tooltipRoundedRadius: 10,
                      tooltipPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      getTooltipItems: (List<LineBarSpot> touchedSpots) {
                        return touchedSpots.map((barSpot) {
                          // Solo mostramos tooltip para los puntos (serie 0)
                          if (barSpot.barIndex != 0) return null;

                          final datum = correlation.data.firstWhere(
                            (d) =>
                                (d.factorValor?.toDouble() ?? 0) == barSpot.x &&
                                (d.empleo?.toDouble() ?? 0) == barSpot.y,
                            orElse: () => Datum(
                              year: null,
                              empleo: null,
                              factorValor: null,
                            ),
                          );
                          final yearStr = datum.year != null
                              ? 'Año: ${datum.year}\n'
                              : '';
                          return LineTooltipItem(
                            '${yearStr}Empleo: ${_formatNumber(barSpot.y)}\n$_factorLabel: ${_formatNumber(barSpot.x)}',
                            TextStyle(
                              color: cs.onInverseSurface,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                          );
                        }).toList();
                      },
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: cs.outlineVariant.withValues(alpha: 0.2),
                      strokeWidth: 1,
                    ),
                    getDrawingVerticalLine: (value) => FlLine(
                      color: cs.outlineVariant.withValues(alpha: 0.2),
                      strokeWidth: 1,
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border(
                      left: BorderSide(
                        color: cs.outlineVariant.withValues(alpha: 0.3),
                      ),
                      bottom: BorderSide(
                        color: cs.outlineVariant.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                  titlesData: FlTitlesData(
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      axisNameWidget: Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          _factorLabel,
                          style: TextStyle(
                            fontSize: 11,
                            color: cs.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      axisNameSize: 24,
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          if (value == meta.min || value == meta.max) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              _formatAxisValue(value),
                              style: TextStyle(
                                fontSize: 10,
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      axisNameWidget: Text(
                        'Empleo',
                        style: TextStyle(
                          fontSize: 11,
                          color: cs.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      axisNameSize: 24,
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 52,
                        getTitlesWidget: (value, meta) {
                          if (value == meta.min || value == meta.max) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Text(
                              _formatAxisValue(value),
                              style: TextStyle(
                                fontSize: 10,
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  lineBarsData: [
                    // Serie 0: Puntos de observación (solo puntos, sin línea)
                    LineChartBarData(
                      spots: scatterSpots,
                      show: true,
                      barWidth: 0,
                      isCurved: false,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 6,
                            color: sector.color.withValues(alpha: 0.8),
                            strokeWidth: 1.5,
                            strokeColor: sector.color,
                          );
                        },
                      ),
                    ),
                    // Serie 1: Línea de Regresión
                    if (regressionSpots.length >= 2)
                      LineChartBarData(
                        spots: regressionSpots,
                        show: true,
                        isCurved: false,
                        color: sector.color.withValues(alpha: 0.5),
                        barWidth: 3,
                        dotData: const FlDotData(show: false),
                      ),
                  ],
                ),
              ),
            ),
          ),

          // ECUACIÓN DE REGRESIÓN
          if (correlation.regression != null)
            Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: cs.surfaceContainerHighest.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.timeline_rounded, size: 16, color: sector.color),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Línea de regresión:  y = ${correlation.regression!.m?.toStringAsFixed(2) ?? "?"}x + ${correlation.regression!.b?.toStringAsFixed(2) ?? "?"}',
                      style: TextStyle(
                        fontSize: 12,
                        color: cs.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // LEYENDA
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _LegendItem(
                  color: sector.color,
                  label: 'Observaciones',
                  isDot: true,
                ),
                const SizedBox(width: 20),
                _LegendItem(
                  color: sector.color.withValues(alpha: 0.5),
                  label: 'Tendencia',
                  isDot: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatAxisValue(double value) {
    if (value.abs() >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    }
    if (value.abs() >= 1000) return '${(value / 1000).toStringAsFixed(1)}K';
    return value.toStringAsFixed(1);
  }

  String _formatNumber(double value) {
    if (value.abs() >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(2)}M';
    }
    if (value.abs() >= 1000) return '${(value / 1000).toStringAsFixed(1)}K';
    return value.toStringAsFixed(2);
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final bool isDot;

  const _LegendItem({
    required this.color,
    required this.label,
    required this.isDot,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: isDot ? 10 : 16,
          height: isDot ? 10 : 3,
          decoration: BoxDecoration(
            color: isDot ? color.withValues(alpha: 0.8) : color,
            shape: isDot ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: isDot ? null : BorderRadius.circular(1.5),
            border: isDot ? Border.all(color: color, width: 1.5) : null,
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }
}
