import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_siah/core/theme/app_theme.dart';
import 'package:proyecto_siah/widgets/cactus_icon.dart';

class HomeScreen extends StatelessWidget {
  final Function(int)? onNavigate;
  const HomeScreen({super.key, this.onNavigate});

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
              _buildAlertaBanner(),
              const SizedBox(height: 16),
              _buildHero(),
              const SizedBox(height: 16),
              _buildTendencias(),
              const SizedBox(height: 16),
              _buildMunicipios(),
              const SizedBox(height: 16),
              _buildRecomendacionIA(),
              const SizedBox(height: 16),
              _buildAccesosRapidos(),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        CactusIcon(size: 28, color: SiahColors.verdeCactus),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SIAH',
              style: GoogleFonts.barlow(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: SiahColors.terracota,
              ),
            ),
            Text(
              'Sonora · Análisis Hídrico',
              style: GoogleFonts.nunito(
                fontSize: 10,
                color: SiahColors.textoSecundario,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── BANNER ALERTA ────────────────────────────────────────
  Widget _buildAlertaBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0A030).withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0A030),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.white,
                      size: 13,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'ALERTA HÍDRICA',
                      style: GoogleFonts.nunito(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                'Actualizado hoy',
                style: GoogleFonts.nunito(
                  fontSize: 10,
                  color: SiahColors.textoSecundario,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Presa Mocúzari',
                      style: GoogleFonts.barlow(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: SiahColors.textoPrincipal,
                      ),
                    ),
                    Text(
                      'Nivel crítico — requiere atención inmediata',
                      style: GoogleFonts.nunito(
                        fontSize: 12,
                        color: SiahColors.textoSecundario,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '34%',
                style: GoogleFonts.barlow(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFFE0A030),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: 0.34,
              backgroundColor: const Color(0xFFE0A030).withOpacity(0.15),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFFE0A030),
              ),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '0%',
                style: GoogleFonts.nunito(
                  fontSize: 10,
                  color: SiahColors.textoSecundario,
                ),
              ),
              Text(
                'Capacidad total: 100%',
                style: GoogleFonts.nunito(
                  fontSize: 10,
                  color: SiahColors.textoSecundario,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── HERO ─────────────────────────────────────────────────
  Widget _buildHero() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: SiahColors.terracota,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sector agrícola\nde Sonora',
            style: GoogleFonts.barlow(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: SiahColors.blanco,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Análisis hídrico y laboral en tiempo real para los valles del Yaqui y Mayo.',
            style: GoogleFonts.nunito(
              fontSize: 12,
              color: SiahColors.blanco.withOpacity(0.85),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildHeroStat('63.87%', 'Reducción\njornaleros'),
              const SizedBox(width: 10),
              _buildHeroStat('4.5M', 'Jornales\nen riesgo'),
              const SizedBox(width: 10),
              _buildHeroStat('2', 'Valles\nmonitoreados'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroStat(String valor, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: SiahColors.blanco.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              valor,
              style: GoogleFonts.barlow(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: SiahColors.blanco,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.nunito(
                fontSize: 10,
                color: SiahColors.blanco.withOpacity(0.8),
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── TENDENCIAS ───────────────────────────────────────────
  Widget _buildTendencias() {
    final tendencias = [
      {
        'label': 'Precipitación',
        'valor': '182 mm',
        'cambio': '-23%',
        'sube': false,
        'color': const Color(0xFF4A90D9),
        'icono': Icons.water_drop_rounded,
      },
      {
        'label': 'Jornales',
        'valor': '1.2M',
        'cambio': '-18%',
        'sube': false,
        'color': SiahColors.terracota,
        'icono': Icons.people_rounded,
      },
      {
        'label': 'Vacantes',
        'valor': '10.2K',
        'cambio': '+12%',
        'sube': true,
        'color': SiahColors.verdeCactus,
        'icono': Icons.trending_up_rounded,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TENDENCIA RECIENTE',
          style: GoogleFonts.nunito(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: SiahColors.textoSecundario,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: tendencias.map((t) {
            final color = t['color'] as Color;
            final sube = t['sube'] as bool;
            return Expanded(
              child: Container(
                margin: EdgeInsets.only(right: t != tendencias.last ? 10 : 0),
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
                        Icon(t['icono'] as IconData, color: color, size: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: sube
                                ? SiahColors.verdeCactus.withOpacity(0.12)
                                : SiahColors.terracota.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                sube
                                    ? Icons.arrow_upward_rounded
                                    : Icons.arrow_downward_rounded,
                                size: 10,
                                color: sube
                                    ? SiahColors.verdeCactus
                                    : SiahColors.terracota,
                              ),
                              Text(
                                t['cambio'] as String,
                                style: GoogleFonts.nunito(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  color: sube
                                      ? SiahColors.verdeCactus
                                      : SiahColors.terracota,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      t['valor'] as String,
                      style: GoogleFonts.barlow(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: color,
                      ),
                    ),
                    Text(
                      t['label'] as String,
                      style: GoogleFonts.nunito(
                        fontSize: 10,
                        color: SiahColors.textoSecundario,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ── MUNICIPIOS ───────────────────────────────────────────
  Widget _buildMunicipios() {
    final municipios = [
      {
        'nombre': 'Cajeme',
        'nivel': 'Crítico',
        'color': const Color(0xFFB84C1C),
      },
      {
        'nombre': 'Navojoa',
        'nivel': 'Severo',
        'color': const Color(0xFFD4622A),
      },
      {'nombre': 'Álamos', 'nivel': 'Severo', 'color': const Color(0xFFD4622A)},
      {
        'nombre': 'Huatabampo',
        'nivel': 'Moderado',
        'color': const Color(0xFFE0A030),
      },
      {
        'nombre': 'Etchojoa',
        'nivel': 'Moderado',
        'color': const Color(0xFFE0A030),
      },
      {
        'nombre': 'Benito Juárez',
        'nivel': 'Leve',
        'color': const Color(0xFF5A9E6F),
      },
      {'nombre': 'Quiriego', 'nivel': 'Leve', 'color': const Color(0xFF5A9E6F)},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'MUNICIPIOS AFECTADOS',
              style: GoogleFonts.nunito(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: SiahColors.textoSecundario,
                letterSpacing: 0.8,
              ),
            ),
            Text(
              'Sur de Sonora',
              style: GoogleFonts.nunito(
                fontSize: 11,
                color: SiahColors.textoSecundario,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: municipios.map((m) {
              final color = m['color'] as Color;
              return Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Column(
                  children: [
                    Text(
                      m['nombre'] as String,
                      style: GoogleFonts.barlow(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: SiahColors.textoPrincipal,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      m['nivel'] as String,
                      style: GoogleFonts.nunito(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // ── RECOMENDACIÓN IA ─────────────────────────────────────
  Widget _buildRecomendacionIA() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            SiahColors.terracota,
            SiahColors.terracota.withOpacity(0.75),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: SiahColors.blanco.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CactusIcon(
  size: 22,
  color: Colors.white,
),
              ),
              const SizedBox(width: 10),
              Text(
                'SIAH RECOMIENDA',
                style: GoogleFonts.nunito(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: SiahColors.blanco.withOpacity(0.9),
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Con el nivel de la Presa Mocúzari al 34%, se proyecta una reducción del 52% en jornales para el ciclo 2025. Los sectores de manufactura y construcción ofrecen más de 5,000 vacantes activas en el sur de Sonora.',
            style: GoogleFonts.nunito(
              fontSize: 13,
              color: SiahColors.blanco,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              GestureDetector(
                onTap: () => onNavigate?.call(3),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: SiahColors.blanco,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Ver sectores →',
                    style: GoogleFonts.barlow(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: SiahColors.terracota,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => onNavigate?.call(4),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: SiahColors.blanco.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: SiahColors.blanco.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    'Ver correlación →',
                    style: GoogleFonts.barlow(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: SiahColors.blanco,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── ACCESOS RÁPIDOS ──────────────────────────────────────
  Widget _buildAccesosRapidos() {
    final accesos = [
      {
        'icono': Icons.water_drop_rounded,
        'titulo': 'Clima',
        'color': const Color(0xFF4A90D9),
        'index': 1,
      },
      {
        'icono': Icons.people_rounded,
        'titulo': 'Empleo',
        'color': SiahColors.verdeCactus,
        'index': 2,
      },
      {
        'icono': Icons.bar_chart_rounded,
        'titulo': 'Correlación',
        'color': const Color(0xFF7B5EA7),
        'index': 4,
      },
      {
        'icono': Icons.trending_up_rounded,
        'titulo': 'Sectores',
        'color': const Color(0xFFE07B4A),
        'index': 3,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ACCESO RÁPIDO',
          style: GoogleFonts.nunito(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: SiahColors.textoSecundario,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 12),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: accesos.map((acceso) {
              final color = acceso['color'] as Color;
              final index = acceso['index'] as int;
              final isLast = acceso == accesos.last;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onNavigate?.call(index),
                  child: Container(
                    margin: EdgeInsets.only(right: isLast ? 0 : 10),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 6,
                    ),
                    decoration: BoxDecoration(
                      color: SiahColors.blanco,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: SiahColors.cardBorde),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            acceso['icono'] as IconData,
                            color: SiahColors.blanco,
                            size: 20,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          acceso['titulo'] as String,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.barlow(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: SiahColors.textoPrincipal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
