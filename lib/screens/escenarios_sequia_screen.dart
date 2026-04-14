import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_siah/core/theme/app_theme.dart';

class EscenariosSequiaScreen extends StatefulWidget {
  final bool embebida;
  const EscenariosSequiaScreen({super.key, this.embebida = false});

  @override
  State<EscenariosSequiaScreen> createState() => _EscenariosSequiaScreenState();
}

class _EscenariosSequiaScreenState extends State<EscenariosSequiaScreen> {
  String _nivelSequia = 'Leve';
  String _horizonte = '6 meses';
  String _region = 'Valle Yaqui';
  bool _generando = false;
  bool _mostrarResultado = false;

  final List<String> _nivelesSequia = ['Leve', 'Moderada', 'Severa', 'Extrema'];
  final List<String> _horizontes = ['6 meses', '1 año', '3 años'];
  final List<String> _regiones = ['Valle Yaqui', 'Valle Mayo', 'Ambos'];

  // Datos simulados por nivel de sequía
  final Map<String, Map<String, dynamic>> _resultados = {
    'Leve': {
      'reduccionJornales': '12%',
      'jornalesRiesgo': '540K',
      'hectareasAfectadas': '18,200',
      'color': Color(0xFF5A9E6F),
      'descripcion': 'Impacto moderado. Se estima una reducción controlable con medidas de conservación hídrica básicas.',
    },
    'Moderada': {
      'reduccionJornales': '31%',
      'jornalesRiesgo': '1.4M',
      'hectareasAfectadas': '42,500',
      'color': Color(0xFFE0A030),
      'descripcion': 'Impacto significativo. Se recomienda activar programas de reconversión laboral en manufactura y construcción.',
    },
    'Severa': {
      'reduccionJornales': '52%',
      'jornalesRiesgo': '2.3M',
      'hectareasAfectadas': '78,000',
      'color': Color(0xFFD4622A),
      'descripcion': 'Impacto crítico. Alta probabilidad de desplazamiento masivo de jornaleros. Requiere intervención gubernamental.',
    },
    'Extrema': {
      'reduccionJornales': '63.87%',
      'jornalesRiesgo': '4.5M',
      'hectareasAfectadas': '112,400',
      'color': Color(0xFFB84C1C),
      'descripcion': 'Impacto catastrófico. Pérdida total de ciclos agrícolas en ambos valles. Crisis laboral regional inminente.',
    },
  };

  Future<void> _generarPrediccion() async {
    setState(() {
      _generando = true;
      _mostrarResultado = false;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _generando = false;
      _mostrarResultado = true;
    });
  }

  @override
  @override
Widget build(BuildContext context) {
  if (widget.embebida) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          _buildConfiguradorEscenario(),
          const SizedBox(height: 14),
          if (_mostrarResultado) _buildResultado(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

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
          _buildConfiguradorEscenario(),
          const SizedBox(height: 14),
          if (_mostrarResultado) _buildResultado(),
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
          'Escenarios de sequía',
          style: GoogleFonts.barlow(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: SiahColors.textoPrincipal,
            height: 1,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Simulador predictivo: genera proyecciones del impacto en empleo según diferentes niveles de sequía.',
          style: GoogleFonts.nunito(
            fontSize: 12,
            color: SiahColors.textoSecundario,
          ),
        ),
      ],
    );
  }

  Widget _buildConfiguradorEscenario() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: SiahColors.blanco,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: SiahColors.cardBorde),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Configurar escenario',
            style: GoogleFonts.barlow(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: SiahColors.textoPrincipal,
            ),
          ),
          const SizedBox(height: 20),

          // Nivel de sequía
          _buildSelectorLabel('NIVEL DE SEQUÍA'),
          const SizedBox(height: 8),
          _buildSelector(
            opciones: _nivelesSequia,
            seleccionado: _nivelSequia,
            onSelect: (v) => setState(() => _nivelSequia = v),
          ),
          const SizedBox(height: 18),

          // Horizonte temporal
          _buildSelectorLabel('HORIZONTE TEMPORAL'),
          const SizedBox(height: 8),
          _buildSelector(
            opciones: _horizontes,
            seleccionado: _horizonte,
            onSelect: (v) => setState(() => _horizonte = v),
          ),
          const SizedBox(height: 18),

          // Región
          _buildSelectorLabel('REGIÓN'),
          const SizedBox(height: 8),
          _buildSelector(
            opciones: _regiones,
            seleccionado: _region,
            onSelect: (v) => setState(() => _region = v),
          ),
          const SizedBox(height: 24),

          // Botón generar
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _generando ? null : _generarPrediccion,
              style: ElevatedButton.styleFrom(
                backgroundColor: SiahColors.terracota,
                foregroundColor: SiahColors.blanco,
                disabledBackgroundColor: SiahColors.terracota.withOpacity(0.5),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: _generando
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Generando predicción...',
                          style: GoogleFonts.barlow(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      'Generar predicción 🔮',
                      style: GoogleFonts.barlow(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              'Modelo predictivo en desarrollo',
              style: GoogleFonts.nunito(
                fontSize: 11,
                color: SiahColors.textoSecundario.withOpacity(0.6),
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectorLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.nunito(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: SiahColors.textoSecundario,
        letterSpacing: 0.8,
      ),
    );
  }

  Widget _buildSelector({
    required List<String> opciones,
    required String seleccionado,
    required Function(String) onSelect,
  }) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: opciones.map((opcion) {
        final isSelected = opcion == seleccionado;
        return GestureDetector(
          onTap: () => onSelect(opcion),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? SiahColors.terracota
                  : SiahColors.crema,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected
                    ? SiahColors.terracota
                    : SiahColors.cardBorde,
              ),
            ),
            child: Text(
              opcion,
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
      }).toList(),
    );
  }

  Widget _buildResultado() {
    final resultado = _resultados[_nivelSequia]!;
    final color = resultado['color'] as Color;

    return AnimatedOpacity(
      opacity: _mostrarResultado ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 400),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: SiahColors.blanco,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: color.withOpacity(0.4), width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text('🔮', style: TextStyle(fontSize: 20)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Resultado del escenario',
                        style: GoogleFonts.barlow(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: SiahColors.textoPrincipal,
                        ),
                      ),
                      Text(
                        'Sequía $_nivelSequia · $_horizonte · $_region',
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
            const SizedBox(height: 18),

            // Métricas resultado
            Row(
              children: [
                _buildMetricaResultado(
                  label: 'Reducción jornales',
                  valor: resultado['reduccionJornales'],
                  color: color,
                ),
                const SizedBox(width: 10),
                _buildMetricaResultado(
                  label: 'Jornales en riesgo',
                  valor: resultado['jornalesRiesgo'],
                  color: color,
                ),
                const SizedBox(width: 10),
                _buildMetricaResultado(
                  label: 'Hectáreas afectadas',
                  valor: resultado['hectareasAfectadas'],
                  color: color,
                ),
              ],
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: color.withOpacity(0.06),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withOpacity(0.2)),
              ),
              child: Text(
                resultado['descripcion'],
                style: GoogleFonts.nunito(
                  fontSize: 13,
                  color: SiahColors.textoPrincipal,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricaResultado({
    required String label,
    required String valor,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: SiahColors.crema,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: SiahColors.cardBorde),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              valor,
              style: GoogleFonts.barlow(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
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
  }
}