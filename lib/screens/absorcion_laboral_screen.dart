import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_siah/core/theme/app_theme.dart';

class AbsorcionLaboralScreen extends StatefulWidget {
  const AbsorcionLaboralScreen({super.key});

  @override
  State<AbsorcionLaboralScreen> createState() => _AbsorcionLaboralScreenState();
}

class _AbsorcionLaboralScreenState extends State<AbsorcionLaboralScreen> {
  int _sectorSeleccionado = 0;

  final List<Map<String, dynamic>> _sectores = [
    {
      'icono': Icons.factory_rounded,
      'titulo': 'Manufactura',
      'tag': '+12% crecimiento',
      'tagColor': Color(0xFF5A9E6F),
      'accentColor': Color(0xFF5A9E6F),
      'descripcion':
          'Parques industriales en expansión en el sur de Sonora. Alta demanda de mano de obra sin necesidad de capacitación especializada inicial.',
      'fuente': 'Fuente: IMSS · Secretaría de Economía',
      'placeholder': 'Mapa de vacantes',
      'placeholderIcon': Icons.map_outlined,
      'stats': [
        {'label': 'Vacantes activas', 'valor': '3,240'},
        {'label': 'Salario promedio', 'valor': '\$312/día'},
        {'label': 'Municipios', 'valor': '8'},
      ],
    },
    {
      'icono': Icons.construction_rounded,
      'titulo': 'Construcción',
      'tag': 'Alta demanda',
      'tagColor': Color(0xFFE07B4A),
      'accentColor': Color(0xFFE07B4A),
      'descripcion':
          'Sector con crecimiento sostenido en obra pública e infraestructura en Sonora. Ofrece ocupación inmediata para trabajadores con experiencia en labores físicas.',
      'fuente': 'Fuente: IMSS · INEGI',
      'placeholder': 'Estadísticas de contratación',
      'placeholderIcon': Icons.bar_chart_rounded,
      'stats': [
        {'label': 'Vacantes activas', 'valor': '1,850'},
        {'label': 'Salario promedio', 'valor': '\$290/día'},
        {'label': 'Municipios', 'valor': '12'},
      ],
    },
    {
      'icono': Icons.room_service_rounded,
      'titulo': 'Servicios',
      'tag': 'Alta demanda',
      'tagColor': Color(0xFFE07B4A),
      'accentColor': Color(0xFF4A90D9),
      'descripcion':
          'Sector de servicios en crecimiento constante: logística, comercio, turismo regional. Diversificación accesible para jornaleros desplazados.',
      'fuente': 'Fuente: IMSS · INEGI',
      'placeholder': 'Estadísticas de empleo',
      'placeholderIcon': Icons.pie_chart_outline_rounded,
      'stats': [
        {'label': 'Vacantes activas', 'valor': '5,120'},
        {'label': 'Salario promedio', 'valor': '\$265/día'},
        {'label': 'Municipios', 'valor': '15'},
      ],
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
            _buildSelectorSectores(),
            const SizedBox(height: 14),
            _buildDetalleSector(),
            const SizedBox(height: 14),
            _buildResumenComparativo(),
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
          padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
          'Absorción laboral',
          style: GoogleFonts.barlow(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: SiahColors.textoPrincipal,
            height: 1,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Análisis de sectores en crecimiento con capacidad de absorber la mano de obra desplazada por la sequía.',
          style: GoogleFonts.nunito(
            fontSize: 12,
            color: SiahColors.textoSecundario,
          ),
        ),
      ],
    );
  }

  Widget _buildSelectorSectores() {
    return Row(
      children: List.generate(_sectores.length, (index) {
        final sector = _sectores[index];
        final isSelected = _sectorSeleccionado == index;
        final color = sector['accentColor'] as Color;

        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _sectorSeleccionado = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.only(
                right: index < _sectores.length - 1 ? 10 : 0,
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? color : SiahColors.blanco,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected ? color : SiahColors.cardBorde,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    sector['icono'] as IconData,
                    color: isSelected ? SiahColors.blanco : color,
                    size: 22,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    sector['titulo'] as String,
                    style: GoogleFonts.barlow(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: isSelected
                          ? SiahColors.blanco
                          : SiahColors.textoPrincipal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildDetalleSector() {
    final sector = _sectores[_sectorSeleccionado];
    final color = sector['accentColor'] as Color;
    final tagColor = sector['tagColor'] as Color;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Container(
        key: ValueKey(_sectorSeleccionado),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          sector['icono'] as IconData,
                          color: color,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          sector['titulo'] as String,
                          style: GoogleFonts.barlow(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: SiahColors.textoPrincipal,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: tagColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          sector['tag'] as String,
                          style: GoogleFonts.nunito(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: tagColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    sector['descripcion'] as String,
                    style: GoogleFonts.nunito(
                      fontSize: 13,
                      color: SiahColors.textoSecundario,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Stats
                  Row(
                    children: (sector['stats'] as List)
                        .map<Widget>((stat) => Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: SiahColors.crema,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: SiahColors.cardBorde),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      stat['valor'] as String,
                                      style: GoogleFonts.barlow(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        color: color,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      stat['label'] as String,
                                      style: GoogleFonts.nunito(
                                        fontSize: 10,
                                        color: SiahColors.textoSecundario,
                                        height: 1.3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),

            // Placeholder gráfica
            Container(
              margin: const EdgeInsets.fromLTRB(18, 0, 18, 0),
              height: 130,
              decoration: BoxDecoration(
                color: SiahColors.cremaOscura.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      sector['placeholderIcon'] as IconData,
                      size: 30,
                      color: SiahColors.textoSecundario.withOpacity(0.4),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${sector['placeholder']} — Próximamente',
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
                sector['fuente'] as String,
                style: GoogleFonts.nunito(
                  fontSize: 11,
                  color: SiahColors.textoSecundario.withOpacity(0.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResumenComparativo() {
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
            'Resumen comparativo',
            style: GoogleFonts.barlow(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: SiahColors.textoPrincipal,
            ),
          ),
          const SizedBox(height: 14),
          ..._sectores.map((sector) {
            final color = sector['accentColor'] as Color;
            final stats = sector['stats'] as List;
            final vacantes = stats[0]['valor'] as String;
            final vacantesNum =
                int.parse(vacantes.replaceAll(',', '').replaceAll('K', '000'));
            final maxVacantes = 5120;
            final porcentaje = vacantesNum / maxVacantes;

            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        sector['icono'] as IconData,
                        color: color,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          sector['titulo'] as String,
                          style: GoogleFonts.nunito(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: SiahColors.textoPrincipal,
                          ),
                        ),
                      ),
                      Text(
                        vacantes,
                        style: GoogleFonts.barlow(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: porcentaje,
                      backgroundColor: SiahColors.cremaOscura,
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                      minHeight: 6,
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