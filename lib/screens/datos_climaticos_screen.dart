import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_siah/core/theme/app_theme.dart';
import 'package:proyecto_siah/screens/escenarios_sequia_screen.dart';

class DatosClimaticosScreen extends StatefulWidget {
  const DatosClimaticosScreen({super.key});

  @override
  State<DatosClimaticosScreen> createState() => _DatosClimaticosScreenState();
}

class _DatosClimaticosScreenState extends State<DatosClimaticosScreen> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SiahColors.crema,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildTabs(),
          Expanded(
            child: _tabIndex == 0
                ? _buildDatosClimaticos()
                : const EscenariosSequiaScreen(embebida: true),
          ),
        ],
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

  Widget _buildTabs() {
    final tabs = ['Datos climáticos', 'Escenarios de sequía'];
    return Container(
      color: SiahColors.crema,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = _tabIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _tabIndex = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.only(right: index == 0 ? 10 : 0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
              decoration: BoxDecoration(
                color: isSelected ? SiahColors.terracota : SiahColors.blanco,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? SiahColors.terracota
                      : SiahColors.cardBorde,
                ),
              ),
              child: Text(
                tabs[index],
                style: GoogleFonts.nunito(
                  fontSize: 13,
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
    );
  }

  Widget _buildDatosClimaticos() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          _buildCard(
            icono: Icons.water_drop_rounded,
            titulo: 'Precipitación histórica',
            descripcion:
                'Gráfica de precipitaciones anuales en los valles del Yaqui y Mayo. Datos desde el año 2000 al presente.',
            fuente: 'Fuente: CONAGUA',
            placeholder: 'Gráfica de barras',
            placeholderIcon: Icons.bar_chart_rounded,
            accentColor: const Color(0xFF4A90D9),
          ),
          const SizedBox(height: 14),
          _buildCard(
            icono: Icons.thermostat_rounded,
            titulo: 'Temperatura y clima actual',
            descripcion:
                'Datos en tiempo real de temperatura, humedad y condiciones climáticas en la región sur de Sonora.',
            fuente: 'Fuente: OpenWeatherMap API',
            placeholder: 'Widget de clima',
            placeholderIcon: Icons.thermostat_rounded,
            accentColor: const Color(0xFFE07B4A),
          ),
          const SizedBox(height: 14),
          _buildCard(
            icono: Icons.water_rounded,
            titulo: 'Nivel Presa Mocúzari',
            descripcion:
                'Monitoreo del nivel de almacenamiento de la Presa Mocúzari, indicador crítico para el Distrito de Riego del Río Yaqui.',
            fuente: 'Fuente: CONAGUA / DRRY',
            placeholder: 'Indicador de nivel',
            placeholderIcon: Icons.water_rounded,
            accentColor: const Color(0xFF3AABCC),
          ),
          const SizedBox(height: 14),
          _buildCard(
            icono: Icons.calendar_month_rounded,
            titulo: 'Pronóstico estacional',
            descripcion:
                'Predicción climática estacional basada en el algoritmo KNN y datos análogos históricos para planificación agrícola.',
            fuente: 'Modelo: KNN · USDA ARS',
            placeholder: 'Modelo KNN',
            placeholderIcon: Icons.auto_graph_rounded,
            accentColor: SiahColors.verdeCactus,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Datos climáticos',
          style: GoogleFonts.barlow(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: SiahColors.textoPrincipal,
            height: 1,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Fuentes: CONAGUA · OpenWeatherMap · Historial de precipitaciones y niveles de presas.',
          style: GoogleFonts.nunito(
            fontSize: 12,
            color: SiahColors.textoSecundario,
          ),
        ),
      ],
    );
  }

  Widget _buildCard({
    required IconData icono,
    required String titulo,
    required String descripcion,
    required String fuente,
    required String placeholder,
    required IconData placeholderIcon,
    required Color accentColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: SiahColors.blanco,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: SiahColors.cardBorde),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: accentColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:
                          Icon(icono, color: accentColor, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        titulo,
                        style: GoogleFonts.barlow(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: SiahColors.textoPrincipal,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  descripcion,
                  style: GoogleFonts.nunito(
                    fontSize: 13,
                    color: SiahColors.textoSecundario,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(18, 0, 18, 0),
            height: 140,
            decoration: BoxDecoration(
              color: SiahColors.cremaOscura.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(placeholderIcon,
                      size: 32,
                      color: SiahColors.textoSecundario.withOpacity(0.4)),
                  const SizedBox(height: 8),
                  Text(
                    '$placeholder — Próximamente',
                    style: GoogleFonts.nunito(
                      fontSize: 12,
                      color: SiahColors.textoSecundario.withOpacity(0.5),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 16),
            child: Text(
              fuente,
              style: GoogleFonts.nunito(
                fontSize: 11,
                color: SiahColors.textoSecundario.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}