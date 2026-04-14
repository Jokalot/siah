import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_siah/core/theme/app_theme.dart';

class FuentesDatosScreen extends StatelessWidget {
  FuentesDatosScreen({super.key});

  final List<Map<String, dynamic>> _fuentes = [
    {
      'icono': Icons.water_rounded,
      'nombre': 'CONAGUA',
      'descripcion': 'Comisión Nacional del Agua. Datos de precipitación, niveles de presas y disponibilidad hídrica.',
      'tipo': 'API pública',
      'tipoColor': Color(0xFF4A90D9),
      'url': 'conagua.gob.mx',
    },
    {
      'icono': Icons.thermostat_rounded,
      'nombre': 'OpenWeatherMap',
      'descripcion': 'Datos climáticos históricos y en tiempo real: temperatura, humedad, precipitación y pronóstico.',
      'tipo': 'REST API',
      'tipoColor': Color(0xFFE07B4A),
      'url': 'openweathermap.org',
    },
    {
      'icono': Icons.local_hospital_rounded,
      'nombre': 'IMSS',
      'descripcion': 'Instituto Mexicano del Seguro Social. Registros de empleo formal por sector y municipio en Sonora.',
      'tipo': 'Datos abiertos',
      'tipoColor': Color(0xFF5A9E6F),
      'url': 'imss.gob.mx',
    },
    {
      'icono': Icons.show_chart_rounded,
      'nombre': 'INEGI',
      'descripcion': 'Estadísticas económicas, demográficas y de inversión extranjera para el estado de Sonora.',
      'tipo': 'DENUE · SCIAN',
      'tipoColor': Color(0xFF7B5EA7),
      'url': 'inegi.org.mx',
    },
    {
      'icono': Icons.agriculture_rounded,
      'nombre': 'SIAP · SAGARPA',
      'descripcion': 'Sistema de Información Agroalimentaria. Superficie sembrada, rendimientos y estadísticas del campo.',
      'tipo': 'Base de datos',
      'tipoColor': Color(0xFFE0A030),
      'url': 'siap.gob.mx',
    },
    {
      'icono': Icons.smart_toy_rounded,
      'nombre': 'API de IA (Chatbot)',
      'descripcion': 'Interfaz conversacional de inteligencia artificial. Opera sin almacenar datos personales del usuario.',
      'tipo': 'Privacidad por diseño',
      'tipoColor': SiahColors.terracota,
      'url': 'anthropic.com',
    },
  ];

  final List<Map<String, dynamic>> _investigaciones = const [
    {
      'numero': '01',
      'titulo': 'Adapting Agricultural Production Systems to Climate Change',
      'autores': 'USDA Agricultural Research Service (ARS)',
      'descripcion': 'Uso de KNN para pronóstico estacional con minería de datos.',
    },
    {
      'numero': '02',
      'titulo': 'Human Adaptation to Social and Environmental Change in Rural Communities of NW Mexico',
      'autores': 'America Nallely Lutz Ley · University of Arizona',
      'descripcion': 'Diversificación laboral como estrategia de adaptación.',
    },
    {
      'numero': '03',
      'titulo': 'Spatial Data Analysis in Digital Agriculture — Crops Growth Monitoring',
      'autores': 'Yunan · University College Dublin',
      'descripcion': 'DNN, CNN, LSTM para monitoreo de cultivos con datos satelitales.',
    },
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
            _buildFuentes(),
            const SizedBox(height: 20),
            _buildInvestigaciones(),
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
            const Text('🌵', style: TextStyle(fontSize: 18)),
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
              const Text('🌵', style: TextStyle(fontSize: 12)),
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
          'Fuentes de datos',
          style: GoogleFonts.barlow(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: SiahColors.textoPrincipal,
            height: 1,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'APIs públicas e instituciones que alimentan los modelos de SIAH.',
          style: GoogleFonts.nunito(
            fontSize: 12,
            color: SiahColors.textoSecundario,
          ),
        ),
      ],
    );
  }

  Widget _buildFuentes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'INSTITUCIONES Y APIs',
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
            childAspectRatio: 0.95,
          ),
          itemCount: _fuentes.length,
          itemBuilder: (context, index) {
            final fuente = _fuentes[index];
            final tipoColor = fuente['tipoColor'] as Color;
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: SiahColors.blanco,
                borderRadius: BorderRadius.circular(16),
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
                          color: tipoColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          fuente['icono'] as IconData,
                          color: tipoColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    fuente['nombre'] as String,
                    style: GoogleFonts.barlow(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: SiahColors.textoPrincipal,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    child: Text(
                      fuente['descripcion'] as String,
                      style: GoogleFonts.nunito(
                        fontSize: 11,
                        color: SiahColors.textoSecundario,
                        height: 1.4,
                      ),
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: tipoColor.withOpacity(0.4)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      fuente['tipo'] as String,
                      style: GoogleFonts.nunito(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: tipoColor,
                      ),
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

  Widget _buildInvestigaciones() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'INVESTIGACIONES QUE RESPALDAN SIAH',
          style: GoogleFonts.nunito(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: SiahColors.textoSecundario,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: SiahColors.blanco,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: SiahColors.cardBorde),
          ),
          child: Column(
            children: List.generate(_investigaciones.length, (index) {
              final inv = _investigaciones[index];
              final isLast = index == _investigaciones.length - 1;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          inv['numero'] as String,
                          style: GoogleFonts.barlow(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: SiahColors.terracota.withOpacity(0.3),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                inv['titulo'] as String,
                                style: GoogleFonts.barlow(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: SiahColors.textoPrincipal,
                                  height: 1.3,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                inv['autores'] as String,
                                style: GoogleFonts.nunito(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: SiahColors.terracota,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                inv['descripcion'] as String,
                                style: GoogleFonts.nunito(
                                  fontSize: 12,
                                  color: SiahColors.textoSecundario,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isLast)
                    Divider(
                      height: 1,
                      color: SiahColors.cardBorde,
                      indent: 16,
                      endIndent: 16,
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}