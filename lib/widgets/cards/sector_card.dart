import 'package:flutter/material.dart';
import '../../models/prediction_model.dart';
import 'package:fl_chart/fl_chart.dart';

class SectorPredictionCard extends StatelessWidget {
  final PredictionModel data;
  final String sectorName;
  final String sectorDescription;
  final IconData sectorIcon;
  final Color primaryColor;

  const SectorPredictionCard({
    super.key,
    required this.data,
    required this.sectorName,
    required this.sectorDescription,
    required this.sectorIcon,
    required this.primaryColor,
  });

  bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 500;

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Card(
              elevation: 4,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(context, isMobile),
                  const Divider(
                    color: Color.fromARGB(255, 43, 43, 43),
                    thickness: 0.1,
                    height: 0.1,
                  ),
                  const SizedBox(height: 25),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 12 : 24,
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        _buildChart(context),
                        const SizedBox(height: 24),
                        _buildLegend(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, bool isMobile) {
    final isDarkTheme = isDark(context);

    // Dynamic colors based on primaryColor
    final headerBg = isDarkTheme
        ? primaryColor.withValues(alpha: 0.15)
        : primaryColor.withValues(alpha: 0.05);

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [headerBg, headerBg.withValues(alpha: 0.05)],
        ),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleRow(isDarkTheme),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: _buildBadgesRow(isDarkTheme),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _buildTitleRow(isDarkTheme)),
                const SizedBox(width: 16),
                _buildBadgesRow(isDarkTheme),
              ],
            ),
    );
  }

  Widget _buildTitleRow(bool isDarkTheme) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: primaryColor.withValues(alpha: 0.2),
          child: Icon(sectorIcon, color: primaryColor),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sectorName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDarkTheme ? Colors.white : Colors.black87,
                ),
              ),
              Text(
                sectorDescription,
                style: TextStyle(
                  fontSize: 12,
                  color: isDarkTheme ? Colors.grey : Colors.black54,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBadgesRow(bool isDarkTheme) {
    final growthRate = _getGrowthRate();
    final growthColor = (growthRate > 0) ? Colors.green : Colors.red;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildBadge(
          colorBg: isDarkTheme
              ? Colors.blueGrey.withValues(alpha: 0.2)
              : Colors.blueGrey.shade50,
          colorText: isDarkTheme ? Colors.blueGrey.shade100 : Colors.blueGrey,
          label: "${data.valorPredicho?.toInt()} Empleos",
          icon: Icon(
            Icons.person,
            size: 14,
            color: isDarkTheme ? Colors.blueGrey.shade100 : Colors.blueGrey,
          ),
        ),
        const SizedBox(width: 8),
        _buildBadge(
          colorBg: isDarkTheme
              ? Colors.indigo.withValues(alpha: 0.2)
              : Colors.indigo.shade50,
          colorText: isDarkTheme ? Colors.indigo.shade100 : Colors.indigo,
          label: "R²: ${data.metadata?.r2}",
          icon: Icon(
            Icons.auto_graph,
            size: 14,
            color: isDarkTheme ? Colors.indigo.shade100 : Colors.indigo,
          ),
        ),
        const SizedBox(width: 8),
        _buildBadge(
          colorBg: growthColor.withValues(alpha: 0.1),
          colorText: growthColor,
          label:
              "${growthRate.toStringAsFixed(2)}% ${(growthRate > 0) ? "Crecimiento" : "Disminución"}",
          icon: Icon(
            (growthRate > 0) ? Icons.trending_up : Icons.trending_down,
            size: 14,
            color: growthColor,
          ),
        ),
      ],
    );
  }

  double _getGrowthRate() {
    double lastValue = data.historyData!.last.value!;
    double predictedValue = data.valorPredicho!;
    return (predictedValue - lastValue) / lastValue * 100;
  }

  Widget _buildBadge({
    required Color colorBg,
    required Color colorText,
    required String label,
    Widget? icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: colorBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[icon, const SizedBox(width: 4)],
          Text(
            label,
            style: TextStyle(
              color: colorText,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChart(BuildContext context) {
    final isDarkTheme = isDark(context);

    List<FlSpot> historySpots = data.historyData!
        .map((e) => FlSpot(e.year!.toDouble(), e.value!))
        .toList();

    double anioPrediccion = historySpots.last.x + 1;
    double firstAnio = historySpots.first.x;

    List<FlSpot> predictionSpots = [
      historySpots.last,
      FlSpot(historySpots.last.x + 1, data.valorPredicho!),
    ];

    final allSpots = [...historySpots, ...predictionSpots];
    double yMin = allSpots.map((s) => s.y).reduce((a, b) => a < b ? a : b);
    double yMax = allSpots.map((s) => s.y).reduce((a, b) => a > b ? a : b);

    double margen = (yMax - yMin) * 0.2;

    return SizedBox(
      height: 300,
      child: LineChart(
        LineChartData(
          borderData: FlBorderData(show: false),
          minX: firstAnio,
          maxX: anioPrediccion,
          minY: yMin - margen,
          maxY: yMax + margen,
          lineBarsData: [
            LineChartBarData(
              spots: historySpots,
              isCurved: true,
              curveSmoothness: 0.5,
              barWidth: 4,
              dotData: const FlDotData(show: false),
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withValues(alpha: 0.5)],
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    primaryColor.withValues(alpha: 0.3),
                    primaryColor.withValues(alpha: 0.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            LineChartBarData(
              spots: predictionSpots,
              isCurved: true,
              curveSmoothness: 0.5,
              barWidth: 4,
              dashArray: [5, 5],
              dotData: FlDotData(show: true),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFFFD600), // Amarillo
                  Color(0xFFFF6D00), // Naranja
                ],
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFFFD600).withValues(alpha: 0.3),
                    const Color(
                      0xFFFFD600,
                    ).withValues(alpha: isDarkTheme ? 0.0 : 0.1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(fontSize: 10),
                  );
                },
                reservedSize: 30,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 60,
                interval: (yMax - yMin) / 4,
                getTitlesWidget: (value, meta) {
                  if (value >= 1000) {
                    return Text("${(value / 1000).toStringAsFixed(1)}k");
                  }
                  return Text(value.toString());
                },
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _legendItem(primaryColor, "Histórico"),
          const SizedBox(width: 20),
          _legendItem(
            const Color(0xFFFFD600),
            "Predicción SIAH (2026)",
            isDash: true,
          ),
        ],
      ),
    );
  }

  Widget _legendItem(Color color, String label, {bool isDash = false}) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
