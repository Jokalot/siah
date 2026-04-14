import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_siah/core/theme/app_theme.dart';

class EmpleoAgricolaScreen extends StatefulWidget {
  const EmpleoAgricolaScreen({super.key});

  @override
  State<EmpleoAgricolaScreen> createState() => _EmpleoAgricolaScreenState();
}

class _EmpleoAgricolaScreenState extends State<EmpleoAgricolaScreen> {
  int _cicloSeleccionado = 0;
  final List<String> _ciclos = ['2022–23', '2023–24', '2024–25'];

  final List<List<Map<String, dynamic>>> _datosTimeline = [
    // 2022-23
    [
      {'mes': 'Oct', 'jornales': 0.85, 'label': '850K'},
      {'mes': 'Nov', 'jornales': 0.92, 'label': '920K'},
      {'mes': 'Dic', 'jornales': 0.95, 'label': '950K'},
      {'mes': 'Ene', 'jornales': 0.88, 'label': '880K'},
      {'mes': 'Feb', 'jornales': 0.76, 'label': '760K'},
      {'mes': 'Mar', 'jornales': 0.60, 'label': '600K'},
    ],
    // 2023-24
    [
      {'mes': 'Oct', 'jornales': 0.72, 'label': '720K'},
      {'mes': 'Nov', 'jornales': 0.78, 'label': '780K'},
      {'mes': 'Dic', 'jornales': 0.80, 'label': '800K'},
      {'mes': 'Ene', 'jornales': 0.65, 'label': '650K'},
      {'mes': 'Feb', 'jornales': 0.52, 'label': '520K'},
      {'mes': 'Mar', 'jornales': 0.40, 'label': '400K'},
    ],
    // 2024-25
    [
      {'mes': 'Oct', 'jornales': 0.55, 'label': '550K'},
      {'mes': 'Nov', 'jornales': 0.58, 'label': '580K'},
      {'mes': 'Dic', 'jornales': 0.50, 'label': '500K'},
      {'mes': 'Ene', 'jornales': 0.38, 'label': '380K'},
      {'mes': 'Feb', 'jornales': 0.28, 'label': '280K'},
      {'mes': 'Mar', 'jornales': 0.20, 'label': '200K'},
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SiahColors.crema,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(),
              const SizedBox(height: 20),
              _buildHeader(),
              const SizedBox(height: 16),
              _buildMetricas(),
              const SizedBox(height: 16),
              _buildTimelineJornales(),
              const SizedBox(height: 16),
              _buildCardSuperficie(),
              const SizedBox(height: 16),
              _buildCardDesempleo(),
              const SizedBox(height: 90),
            ],
          ),
        ),
      ),
    );
  }

  // ── TOP BAR ─────────────────────────────────────────────
  Widget _buildTopBar() {
    return Row(
      children: [
        const Text('🌵', style: TextStyle(fontSize: 22)),
        const SizedBox(width: 8),
        Text(
          'SIAH',
          style: GoogleFonts.barlow(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: SiahColors.terracota,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '/ Empleo agrícola',
          style: GoogleFonts.nunito(
            fontSize: 13,
            color: SiahColors.textoSecundario,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // ── HEADER ───────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF3A6B2A),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'DATOS DEL IMSS · SAGARPA',
              style: GoogleFonts.nunito(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Colors.white.withOpacity(0.9),
                letterSpacing: 0.8,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Empleo\nagrícola',
            style: GoogleFonts.barlow(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: SiahColors.blanco,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Registros de jornaleros formales en los valles del Yaqui y Mayo desde el año 2000.',
            style: GoogleFonts.nunito(
              fontSize: 12,
              color: SiahColors.blanco.withOpacity(0.85),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ── MÉTRICAS ─────────────────────────────────────────────
  Widget _buildMetricas() {
    final stats = [
      {
        'valor': '1.2M',
        'label': 'Jornales\nregistrados',
        'cambio': '-18%',
        'sube': false,
        'color': SiahColors.terracota,
        'icono': Icons.people_rounded,
      },
      {
        'valor': '142K',
        'label': 'Hectáreas\nsembradas',
        'cambio': '-24%',
        'sube': false,
        'color': const Color(0xFF5A9E6F),
        'icono': Icons.grass_rounded,
      },
      {
        'valor': '31%',
        'label': 'Desempleo\nestacional',
        'cambio': '+8%',
        'sube': true,
        'color': const Color(0xFFE0A030),
        'icono': Icons.work_off_rounded,
      },
    ];

    return Row(
      children: stats.map((s) {
        final color = s['color'] as Color;
        final sube = s['sube'] as bool;
        final isLast = s == stats.last;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: isLast ? 0 : 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: SiahColors.blanco,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: SiahColors.cardBorde),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(s['icono'] as IconData, color: color, size: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: sube
                            ? SiahColors.terracota.withOpacity(0.1)
                            : SiahColors.verdeCactus.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            sube
                                ? Icons.arrow_upward_rounded
                                : Icons.arrow_downward_rounded,
                            size: 9,
                            color: sube
                                ? SiahColors.terracota
                                : SiahColors.verdeCactus,
                          ),
                          Text(
                            s['cambio'] as String,
                            style: GoogleFonts.nunito(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: sube
                                  ? SiahColors.terracota
                                  : SiahColors.verdeCactus,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  s['valor'] as String,
                  style: GoogleFonts.barlow(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: color,
                  ),
                ),
                Text(
                  s['label'] as String,
                  style: GoogleFonts.nunito(
                    fontSize: 10,
                    color: SiahColors.textoSecundario,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // ── TIMELINE JORNALES ────────────────────────────────────
  Widget _buildTimelineJornales() {
    final datos = _datosTimeline[_cicloSeleccionado];
    final color = _cicloSeleccionado == 0
        ? SiahColors.verdeCactus
        : _cicloSeleccionado == 1
            ? const Color(0xFFE0A030)
            : SiahColors.terracota;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: SiahColors.blanco,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: SiahColors.cardBorde),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8A87C).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('📈', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jornales por ciclo agrícola',
                      style: GoogleFonts.barlow(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: SiahColors.textoPrincipal,
                      ),
                    ),
                    Text(
                      'Valle del Yaqui y Mayo · IMSS',
                      style: GoogleFonts.nunito(
                        fontSize: 11,
                        color: SiahColors.textoSecundario,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Selector de ciclo
          Row(
            children: List.generate(_ciclos.length, (index) {
              final isSelected = _cicloSeleccionado == index;
              return GestureDetector(
                onTap: () => setState(() => _cicloSeleccionado = index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.only(
                      right: index < _ciclos.length - 1 ? 8 : 0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? color : SiahColors.crema,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected ? color : SiahColors.cardBorde,
                    ),
                  ),
                  child: Text(
                    _ciclos[index],
                    style: GoogleFonts.nunito(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? SiahColors.blanco
                          : SiahColors.textoSecundario,
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 20),

          // Timeline visual
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            child: SizedBox(
              key: ValueKey(_cicloSeleccionado),
              height: 140,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(datos.length, (index) {
                  final punto = datos[index];
                  final valor = punto['jornales'] as double;
                  final isLast = index == datos.length - 1;

                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Label valor
                        Text(
                          punto['label'] as String,
                          style: GoogleFonts.barlow(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: color,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Barra + punto
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            // Barra
                            Container(
                              width: 28,
                              height: 100 * valor,
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.15),
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(6),
                                ),
                              ),
                            ),
                            // Línea de progreso
                            Container(
                              width: 4,
                              height: 100 * valor,
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(4),
                                ),
                              ),
                            ),
                            // Punto superior
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: SiahColors.blanco, width: 2),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        // Mes
                        Text(
                          punto['mes'] as String,
                          style: GoogleFonts.nunito(
                            fontSize: 10,
                            color: SiahColors.textoSecundario,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // Línea conectora
                        if (!isLast)
                          const SizedBox(),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Fuente: IMSS · SAGARPA',
            style: GoogleFonts.nunito(
              fontSize: 10,
              color: SiahColors.textoSecundario.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  // ── CARD SUPERFICIE ──────────────────────────────────────
  Widget _buildCardSuperficie() {
    final ciclos = [
      {'ciclo': '2020–21', 'hectareas': 0.95},
      {'ciclo': '2021–22', 'hectareas': 0.88},
      {'ciclo': '2022–23', 'hectareas': 0.78},
      {'ciclo': '2023–24', 'hectareas': 0.62},
      {'ciclo': '2024–25', 'hectareas': 0.42},
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: SiahColors.blanco,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: SiahColors.cardBorde),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: SiahColors.verdeCactus.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('🌱', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Superficie sembrada',
                      style: GoogleFonts.barlow(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: SiahColors.textoPrincipal,
                      ),
                    ),
                    Text(
                      'Hectáreas por ciclo agrícola · SIAP',
                      style: GoogleFonts.nunito(
                        fontSize: 11,
                        color: SiahColors.textoSecundario,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...ciclos.map((c) {
            final porcentaje = c['hectareas'] as double;
            final hectareas =
                (porcentaje * 187000).toStringAsFixed(0);
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        c['ciclo'] as String,
                        style: GoogleFonts.nunito(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: SiahColors.textoPrincipal,
                        ),
                      ),
                      Text(
                        '$hectareas ha',
                        style: GoogleFonts.barlow(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: SiahColors.verdeCactus,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: porcentaje,
                      backgroundColor:
                          SiahColors.verdeCactus.withOpacity(0.1),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        SiahColors.verdeCactus
                            .withOpacity(0.4 + porcentaje * 0.6),
                      ),
                      minHeight: 7,
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 4),
          Text(
            'Fuente: SIAP',
            style: GoogleFonts.nunito(
              fontSize: 10,
              color: SiahColors.textoSecundario.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  // ── CARD DESEMPLEO ───────────────────────────────────────
  Widget _buildCardDesempleo() {
    final municipios = [
      {'nombre': 'Cajeme', 'porcentaje': 0.38, 'valor': '38%'},
      {'nombre': 'Navojoa', 'porcentaje': 0.31, 'valor': '31%'},
      {'nombre': 'Huatabampo', 'porcentaje': 0.27, 'valor': '27%'},
      {'nombre': 'Etchojoa', 'porcentaje': 0.24, 'valor': '24%'},
      {'nombre': 'Álamos', 'porcentaje': 0.20, 'valor': '20%'},
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: SiahColors.blanco,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: SiahColors.cardBorde),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0A030).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('💼', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Desempleo estacional',
                      style: GoogleFonts.barlow(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: SiahColors.textoPrincipal,
                      ),
                    ),
                    Text(
                      'Por municipio durante sequía · IMSS · STPS',
                      style: GoogleFonts.nunito(
                        fontSize: 11,
                        color: SiahColors.textoSecundario,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...municipios.map((m) {
            final porcentaje = m['porcentaje'] as double;
            final color = porcentaje > 0.35
                ? SiahColors.terracota
                : porcentaje > 0.25
                    ? const Color(0xFFE0A030)
                    : SiahColors.verdeCactus;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  SizedBox(
                    width: 90,
                    child: Text(
                      m['nombre'] as String,
                      style: GoogleFonts.nunito(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: SiahColors.textoPrincipal,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: porcentaje,
                        backgroundColor: color.withOpacity(0.1),
                        valueColor:
                            AlwaysStoppedAnimation<Color>(color),
                        minHeight: 8,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 36,
                    child: Text(
                      m['valor'] as String,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.barlow(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          Text(
            'Fuente: IMSS · STPS',
            style: GoogleFonts.nunito(
              fontSize: 10,
              color: SiahColors.textoSecundario.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}