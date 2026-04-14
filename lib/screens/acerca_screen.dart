import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_siah/core/theme/app_theme.dart';
import 'package:proyecto_siah/widgets/cactus_icon.dart';

class AcercaScreen extends StatelessWidget {
  const AcercaScreen({super.key});

  final List<Map<String, dynamic>> _equipo = const [
    {
      'iniciales': 'JJ',
      'nombre': 'José Julián Rodríguez Morales',
      'rol': 'Desarrollo & Backend',
      'color': Color(0xFF4A90D9),
    },
    {
      'iniciales': 'HP',
      'nombre': 'Hassiel Pérez Lagarda',
      'rol': 'Diseño & Frontend',
      'color': Color(0xFFE07B4A),
    },
    {
      'iniciales': 'JG',
      'nombre': 'Joel Gabriel Gastélum Félix',
      'rol': 'Data Science & ML',
      'color': Color(0xFF5A9E6F),
    },
    {
      'iniciales': 'JN',
      'nombre': 'Jesús Noel Rábago Gocobachi',
      'rol': 'Análisis & Documentación',
      'color': Color(0xFF7B5EA7),
    },
  ];

  final List<Map<String, dynamic>> _tecnologias = const [
    {'label': 'Flutter', 'color': Color(0xFF4A90D9)},
    {'label': 'Machine Learning', 'color': Color(0xFF5A9E6F)},
    {'label': 'KNN', 'color': Color(0xFFE0A030)},
    {'label': 'LSTM', 'color': Color(0xFF7B5EA7)},
    {'label': 'REST APIs', 'color': Color(0xFFE07B4A)},
    {'label': 'Visualización', 'color': Color(0xFF3AABCC)},
    {'label': 'NLP / IA', 'color': SiahColors.terracota},
    {'label': 'SaaS', 'color': Color(0xFF5A9E6F)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SiahColors.crema,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildInfoCards(),
            const SizedBox(height: 20),
            _buildTecnologias(),
            const SizedBox(height: 20),
            _buildEquipo(),
            const SizedBox(height: 20),
            _buildVersion(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: SiahColors.crema,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Row(
          children: [
            CactusIcon(
    size: 24,
  color: Colors.white,
),
            const SizedBox(width: 4),
            Text(
              'SIAH',
              style: GoogleFonts.barlow(
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: SiahColors.terracota,
              ),
            ),
          ],
        ),
      ),
      leadingWidth: 80,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: SiahColors.terracota,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              CactusIcon(
    size: 20,
  color: Colors.white,
),
              const SizedBox(width: 4),
              Text(
                'SIAH IA',
                style: GoogleFonts.barlow(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: SiahColors.blanco,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Acerca de SIAH',
          style: GoogleFonts.barlow(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: SiahColors.textoPrincipal,
            height: 1,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Plataforma de análisis hídrico y laboral para predecir el impacto de la sequía en el sector agrícola de Sonora.',
          style: GoogleFonts.nunito(
            fontSize: 12,
            color: SiahColors.textoSecundario,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCards() {
    return Column(
      children: [
        // Objetivo
        Container(
          width: double.infinity,
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
                      color: SiahColors.terracota.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.gps_fixed_rounded,
                        color: SiahColors.terracota, size: 18),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'OBJETIVO GENERAL',
                    style: GoogleFonts.nunito(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: SiahColors.terracota,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Desarrollar una herramienta digital que analice y correlacione datos históricos del clima (niveles de presas y precipitación) con registros de empleo formal, con el fin de predecir el impacto de la sequía en el sector agrícola de Sonora y ofrecer a los trabajadores afectados alternativas claras de recolocación laboral en sectores en crecimiento.',
                style: GoogleFonts.nunito(
                  fontSize: 13,
                  color: SiahColors.textoSecundario,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Problemática
        Container(
          width: double.infinity,
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
                    child: Icon(Icons.warning_amber_rounded,
                        color: const Color(0xFFE0A030), size: 18),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'PROBLEMÁTICA',
                    style: GoogleFonts.nunito(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFE0A030),
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'La prolongada sequía en los valles del Yaqui y Mayo ha generado una pérdida estimada del 63.87% en la contratación de jornaleros y la posible pérdida de 4.5 millones de jornales. Existe una brecha de información que impide a los trabajadores conocer oportunidades en otros sectores.',
                style: GoogleFonts.nunito(
                  fontSize: 13,
                  color: SiahColors.textoSecundario,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTecnologias() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TECNOLOGÍAS',
          style: GoogleFonts.nunito(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: SiahColors.textoSecundario,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: SiahColors.blanco,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: SiahColors.cardBorde),
          ),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _tecnologias.map((tec) {
              final color = tec['color'] as Color;
              return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Text(
                  tec['label'] as String,
                  style: GoogleFonts.nunito(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildEquipo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'EQUIPO DE DESARROLLO',
          style: GoogleFonts.nunito(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: SiahColors.textoSecundario,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.4,
          ),
          itemCount: _equipo.length,
          itemBuilder: (context, index) {
            final miembro = _equipo[index];
            final color = miembro['color'] as Color;
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: SiahColors.blanco,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: SiahColors.cardBorde),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.12),
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: color.withOpacity(0.4), width: 2),
                    ),
                    child: Center(
                      child: Text(
                        miembro['iniciales'] as String,
                        style: GoogleFonts.barlow(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: color,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    miembro['nombre'] as String,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.barlow(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: SiahColors.textoPrincipal,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    miembro['rol'] as String,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      fontSize: 11,
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildVersion() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: SiahColors.blanco,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: SiahColors.cardBorde),
      ),
      child: Column(
        children: [
          CactusIcon(
  size: 44,
  color: Colors.white,
),
          const SizedBox(height: 8),
          Text(
            'SIAH',
            style: GoogleFonts.barlow(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: SiahColors.terracota,
            ),
          ),
          Text(
            'Sistema Inteligente de Análisis Hídrico',
            style: GoogleFonts.nunito(
              fontSize: 12,
              color: SiahColors.textoSecundario,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: SiahColors.verdeCactus,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'Sistema activo · Versión 1.0.0 · Sonora, México',
                style: GoogleFonts.nunito(
                  fontSize: 12,
                  color: SiahColors.textoSecundario,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}