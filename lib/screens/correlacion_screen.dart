import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_siah/core/theme/app_theme.dart';

class CorrelacionScreen extends StatefulWidget {
  const CorrelacionScreen({super.key});

  @override
  State<CorrelacionScreen> createState() => _CorrelacionScreenState();
}

class _CorrelacionScreenState extends State<CorrelacionScreen> {
  int _variableSeleccionada = 0;

  final List<Map<String, dynamic>> _variables = [
    {
      'label': 'Precipitación vs Jornales',
      'color': Color(0xFF4A90D9),
      'icono': Icons.water_drop_rounded,
      'eje_x': 'Precipitación (mm/año)',
      'eje_y': 'Jornales contratados',
      'correlacion': '-0.87',
      'interpretacion': 'Correlación negativa fuerte. A menor precipitación, menor contratación de jornaleros en los valles del Yaqui y Mayo.',
    },
    {
      'label': 'Nivel presa vs Hectáreas',
      'color': Color(0xFF3AABCC),
      'icono': Icons.water_rounded,
      'eje_x': 'Nivel de presa (%)',
      'eje_y': 'Superficie sembrada (ha)',
      'correlacion': '+0.92',
      'interpretacion': 'Correlación positiva muy fuerte. El nivel de la Presa Mocúzari es el principal predictor de la superficie sembrada en el DRRY.',
    },
    {
      'label': 'Índice sequía vs Desempleo',
      'color': Color(0xFFD4622A),
      'icono': Icons.wb_sunny_rounded,
      'eje_x': 'Índice de sequía',
      'eje_y': 'Desempleo agrícola (%)',
      'correlacion': '+0.79',
      'interpretacion': 'Correlación positiva alta. Los periodos de sequía intensa generan picos de desempleo estacional en municipios del sur de Sonora.',
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
            _buildInfoModulo(),
            const SizedBox(height: 14),
            _buildSelectorVariables(),
            const SizedBox(height: 14),
            _buildGraficaCorrelacion(),
            const SizedBox(height: 14),
            _buildCoeficientes(),
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
          'Correlación clima-empleo',
          style: GoogleFonts.barlow(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            color: SiahColors.textoPrincipal,
            height: 1,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Análisis estadístico que vincula variables climáticas con el impacto en el empleo agrícola.',
          style: GoogleFonts.nunito(
            fontSize: 12,
            color: SiahColors.textoSecundario,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoModulo() {
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
          Text(
            '¿Qué mide este módulo?',
            style: GoogleFonts.barlow(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: SiahColors.textoPrincipal,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'SIAH procesa datos históricos de precipitación y nivel de la Presa Mocúzari, vinculándolos con los registros de empleo del IMSS para mostrar visualmente la relación entre sequía y pérdida de jornales.',
            style: GoogleFonts.nunito(
              fontSize: 13,
              color: SiahColors.textoSecundario,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 14),
          ...[
            {'color': const Color(0xFF4A90D9), 'texto': 'Precipitación (mm/año) vs Jornales contratados'},
            {'color': const Color(0xFFE0A030), 'texto': 'Nivel de presa (%) vs Superficie sembrada (ha)'},
            {'color': const Color(0xFFD4622A), 'texto': 'Índice de sequía vs Desempleo agrícola (%)'},
          ].map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: item['color'] as Color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item['texto'] as String,
                        style: GoogleFonts.nunito(
                          fontSize: 13,
                          color: SiahColors.textoPrincipal,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: SiahColors.terracota.withOpacity(0.4)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Modelos: Regresión lineal · LSTM · KNN',
              style: GoogleFonts.nunito(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: SiahColors.terracota,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectorVariables() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SELECCIONA LA VARIABLE',
          style: GoogleFonts.nunito(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: SiahColors.textoSecundario,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 10),
        ...List.generate(_variables.length, (index) {
          final variable = _variables[index];
          final isSelected = _variableSeleccionada == index;
          final color = variable['color'] as Color;
          return GestureDetector(
            onTap: () => setState(() => _variableSeleccionada = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? color.withOpacity(0.08) : SiahColors.blanco,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected ? color : SiahColors.cardBorde,
                  width: isSelected ? 1.5 : 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(variable['icono'] as IconData,
                      color: color, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      variable['label'] as String,
                      style: GoogleFonts.nunito(
                        fontSize: 13,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: isSelected
                            ? color
                            : SiahColors.textoPrincipal,
                      ),
                    ),
                  ),
                  if (isSelected)
                    Icon(Icons.check_circle_rounded,
                        color: color, size: 18),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildGraficaCorrelacion() {
    final variable = _variables[_variableSeleccionada];
    final color = variable['color'] as Color;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Container(
        key: ValueKey(_variableSeleccionada),
        decoration: BoxDecoration(
          color: SiahColors.blanco,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: SiahColors.cardBorde),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.scatter_plot_rounded,
                        color: color, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Gráfica de correlación principal',
                      style: GoogleFonts.barlow(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: SiahColors.textoPrincipal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 6, 18, 12),
              child: Text(
                'Dispersión multivariable: ${variable['eje_x']} vs ${variable['eje_y']} (2000–presente)',
                style: GoogleFonts.nunito(
                  fontSize: 12,
                  color: SiahColors.textoSecundario,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(18, 0, 18, 18),
              height: 180,
              decoration: BoxDecoration(
                color: SiahColors.cremaOscura.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  // Simulación visual de scatter plot
                  ...List.generate(20, (i) {
                    final x = (i * 47 + 30) % 100;
                    final y = (i * 31 + 20) % 100;
                    return Positioned(
                      left: x / 100 * (MediaQuery.of(context).size.width - 80),
                      top: y / 100 * 150,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  }),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.scatter_plot_rounded,
                            size: 32,
                            color: color.withOpacity(0.3)),
                        const SizedBox(height: 8),
                        Text(
                          'Scatter plot — Próximamente',
                          style: GoogleFonts.nunito(
                            fontSize: 12,
                            color: SiahColors.textoSecundario.withOpacity(0.5),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoeficientes() {
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
          Text(
            'Coeficientes de correlación',
            style: GoogleFonts.barlow(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: SiahColors.textoPrincipal,
            ),
          ),
          const SizedBox(height: 14),
          ...List.generate(_variables.length, (index) {
            final variable = _variables[index];
            final color = variable['color'] as Color;
            final correlacion = variable['correlacion'] as String;
            final valor = double.parse(correlacion.replaceAll('+', ''));
            final esPositivo = valor > 0;

            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(variable['icono'] as IconData,
                          color: color, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          variable['label'] as String,
                          style: GoogleFonts.nunito(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: SiahColors.textoPrincipal,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'r = $correlacion',
                          style: GoogleFonts.barlow(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: valor.abs(),
                      backgroundColor: SiahColors.cremaOscura,
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                      minHeight: 6,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    variable['interpretacion'] as String,
                    style: GoogleFonts.nunito(
                      fontSize: 11,
                      color: SiahColors.textoSecundario,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}