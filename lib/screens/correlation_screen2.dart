import 'package:flutter/material.dart';
import '../services/siah_service.dart';
import '../models/correlation_model.dart';
import '../models/sector_def.dart';
import 'package:proyecto_siah/widgets/charts/scatter_correlation_chart.dart';
import 'package:proyecto_siah/widgets/charts/historical_trend_chart.dart';
import 'package:proyecto_siah/widgets/panels/analysis_control_panel.dart';

class CorrelationScreen extends StatefulWidget {
  const CorrelationScreen({super.key});

  @override
  State<CorrelationScreen> createState() => _CorrelationScreenState();
}

class _CorrelationScreenState extends State<CorrelationScreen> {
  final ApiService apiService = ApiService();

  String _sector = 'Agro';
  String _factorKey = 'Presa El Molinito';
  int _lag = 0;
  AnalysisMode _mode = AnalysisMode.tendencia;

  late Future<CorrelationModel?> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = _fetchData();
  }

  Future<CorrelationModel?> _fetchData() {
    return apiService.getCorrelation(_sector, _factorKey, _lag);
  }

  void _onControlsChanged({
    required String sector,
    required String factorKey,
    required int lag,
    required AnalysisMode mode,
  }) {
    setState(() {
      _sector = sector;
      _factorKey = factorKey;
      _lag = lag;
      _mode = mode;
      _dataFuture = _fetchData();
    });
  }

  SectorDef get _currentSector {
    return kSectors.firstWhere(
      (s) => s.apiKey == _sector,
      orElse: () => kSectors.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SIAH — Análisis de Correlaciones'),
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 900;

          final panel = AnalysisControlPanel(onChanged: _onControlsChanged);

          final chartArea = FutureBuilder<CorrelationModel?>(
            future: _dataFuture,
            builder: (context, snapshot) {
              // CARGA DE ESTADO
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: _currentSector.color,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Cargando análisis...',
                        style: TextStyle(
                          color: cs.onSurfaceVariant,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                );
              }

              // ERROR DE ESTADO
              if (snapshot.hasError || snapshot.data == null) {
                return Center(
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.cloud_off_rounded,
                          size: 48,
                          color: cs.error.withValues(alpha: 0.6),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error al conectar con la IA',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: cs.onSurface,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          snapshot.error?.toString() ?? 'Sin datos disponibles',
                          style: TextStyle(
                            fontSize: 12,
                            color: cs.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        FilledButton.tonal(
                          onPressed: () {
                            setState(() {
                              _dataFuture = _fetchData();
                            });
                          },
                          child: const Text('Reintentar'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              // DATOS CARGADOS
              final data = snapshot.data!;

              if (_mode == AnalysisMode.tendencia) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: CorrelationCard(
                    correlation: data,
                    sector: _currentSector,
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: ScatterCorrelationChart(
                    correlation: data,
                    sector: _currentSector,
                  ),
                );
              }
            },
          );

          if (isWide) {
            // ESCRITORIO: PANEL IZQUIERDO (30%) | GRÁFICO DERECHO (70%)
            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: constraints.maxWidth * 0.28,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
                    child: panel,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 16, 16, 16),
                    child: SingleChildScrollView(child: chartArea),
                  ),
                ),
              ],
            );
          }

          // MÓVIL: PANEL SUPERIOR | GRÁFICO INFERIOR
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                panel,
                const SizedBox(height: 16),
                SizedBox(height: 500, child: chartArea),
              ],
            ),
          );
        },
      ),
    );
  }
}
