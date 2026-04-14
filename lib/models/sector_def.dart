import 'package:flutter/material.dart';

/// Define los modos de análisis disponibles para el dashboard.
enum AnalysisMode { tendencia, correlacion }

/// Representa un factor económico externo (Dólar, S&P500, etc.)
class FactorDef {
  final String label;
  final String apiKey;

  const FactorDef({
    required this.label,
    required this.apiKey,
  });
}

/// Representa un sector económico con su configuración visual y factores asociados.
class SectorDef {
  final String label;
  final String apiKey;
  final Color color;
  final List<FactorDef> factors;

  const SectorDef({
    required this.label,
    required this.apiKey,
    required this.color,
    required this.factors,
  });
}

/// Lista centralizada de sectores y sus variables económicas asociadas.
/// Se usa en el Panel de Control y en los Headers de las gráficas.
const List<SectorDef> kSectors = [
  SectorDef(
    label: 'Agro',
    apiKey: 'Agro',
    color: Color(0xFF4CAF50),
    factors: [
      FactorDef(label: 'Demanda externa', apiKey: 'EXTERNAL_DEMAND'),
      FactorDef(label: 'Nivel de presas', apiKey: 'Presa El Molinito'),
      FactorDef(label: 'Dólar (USD/MXN)', apiKey: 'USD_MXN'),
      FactorDef(label: 'S&P 500', apiKey: 'SP500'),
      FactorDef(label: 'INPC Sonora', apiKey: 'INPC_SONORA_STATE'),
      FactorDef(
        label: 'Costo de resiliencia agrícola',
        apiKey: 'RESILIENCE_COST',
      ),
    ],
  ),
  SectorDef(
    label: 'Construcción',
    apiKey: 'Construccion',
    color: Color(0xFFFF9800),
    factors: [
      FactorDef(label: 'Dólar (USD/MXN)', apiKey: 'USD_MXN'),
      FactorDef(label: 'S&P 500', apiKey: 'SP500'),
      FactorDef(label: 'INPC Sonora', apiKey: 'INPC_SONORA_STATE'),
      FactorDef(
        label: 'Unidades de cemento Sonora',
        apiKey: 'SONORA_UNIDADES_CEMENTO_TREND',
      ),
    ],
  ),
  SectorDef(
    label: 'Manufactura',
    apiKey: 'Manufactura',
    color: Color(0xFFF44336),
    factors: [
      FactorDef(label: 'Prod. industrial EUA', apiKey: 'US_INDUSTRIAL'),
      FactorDef(label: 'Producción automotriz', apiKey: 'PRODUCCION_AUTO_MEX'),
      FactorDef(label: 'INDPRO', apiKey: 'INDPRO'),
      FactorDef(label: 'Dólar (USD/MXN)', apiKey: 'USD_MXN'),
      FactorDef(label: 'S&P 500', apiKey: 'SP500'),
    ],
  ),
  SectorDef(
    label: 'Servicios',
    apiKey: 'Servicios',
    color: Color(0xFF00CED1),
    factors: [
      FactorDef(
        label: 'Poder adquisitivo real',
        apiKey: 'REAL_PURCHASING_POWER',
      ),
      FactorDef(label: 'Dólar (USD/MXN)', apiKey: 'USD_MXN'),
      FactorDef(label: 'S&P 500', apiKey: 'SP500'),
      FactorDef(label: 'INPC Sonora', apiKey: 'INPC_SONORA_STATE'),
    ],
  ),
];
