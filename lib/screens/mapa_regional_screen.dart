import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_siah/core/theme/app_theme.dart';

class MapaRegionalScreen extends StatefulWidget {
  const MapaRegionalScreen({super.key});

  @override
  State<MapaRegionalScreen> createState() => _MapaRegionalScreenState();
}

class _MapaRegionalScreenState extends State<MapaRegionalScreen> {
  final Set<String> _capasActivas = {
    'agua',
    'cultivo',
  };

  final List<Map<String, dynamic>> _capas = [
    {'id': 'agua', 'color': const Color(0xFF4A90D9), 'label': 'Cuerpos de agua y presas'},
    {'id': 'cultivo', 'color': const Color(0xFF5A9E6F), 'label': 'Zonas de cultivo activo'},
    {'id': 'sequia_moderada', 'color': const Color(0xFFE0A030), 'label': 'Zonas con sequía moderada'},
    {'id': 'sequia_severa', 'color': const Color(0xFFD4622A), 'label': 'Zonas con sequía severa'},
    {'id': 'parques', 'color': const Color(0xFF7B5EA7), 'label': 'Parques industriales'},
    {'id': 'vacantes', 'color': const Color(0xFFE07B4A), 'label': 'Municipios con vacantes'},
  ];

  final List<Map<String, dynamic>> _puntos = [
    {
      'nombre': 'Presa Mocúzari',
      'subtitulo': 'Álamos, Sonora',
      'icono': Icons.water_rounded,
      'color': const Color(0xFF4A90D9),
      'nivel': '34%',
      'labelNivel': 'Nivel actual',
      'detalle': 'Capacidad crítica. Principal fuente hídrica del DRRY.',
    },
    {
      'nombre': 'Valle del Yaqui',
      'subtitulo': 'Ciudad Obregón',
      'icono': Icons.agriculture_rounded,
      'color': const Color(0xFF5A9E6F),
      'nivel': '187,000 ha',
      'labelNivel': 'Superficie total',
      'detalle': 'Distrito de riego más grande del noroeste de México.',
    },
    {
      'nombre': 'Valle del Mayo',
      'subtitulo': 'Navojoa',
      'icono': Icons.grass_rounded,
      'color': const Color(0xFFE0A030),
      'nivel': '98,000 ha',
      'labelNivel': 'Superficie total',
      'detalle': 'Segundo distrito más importante. Alta producción de garbanzo y trigo.',
    },
    {
      'nombre': 'DRRY — Distrito de Riego',
      'subtitulo': 'Río Yaqui',
      'icono': Icons.account_balance_rounded,
      'color': SiahColors.terracota,
      'nivel': '84 módulos',
      'labelNivel': 'Módulos de riego',
      'detalle': 'Administra la distribución de agua para más de 30,000 productores.',
    },
  ];

  int? _puntoSeleccionado;

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
            _buildMapaPlaceholder(),
            const SizedBox(height: 14),
            _buildCapasMapa(),
            const SizedBox(height: 14),
            _buildPuntosReferencia(),
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
          'Mapa regional',
          style: GoogleFonts.barlow(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: SiahColors.textoPrincipal,
            height: 1,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Visualización geoespacial del sur de Sonora: valles del Yaqui y Mayo, presas, distritos de riego y zonas de inversión.',
          style: GoogleFonts.nunito(
            fontSize: 12,
            color: SiahColors.textoSecundario,
          ),
        ),
      ],
    );
  }

  Widget _buildMapaPlaceholder() {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: SiahColors.blanco,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: SiahColors.cardBorde),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            // Fondo simulado de mapa
            Container(
              color: const Color(0xFFE8F4E8),
            ),
            // Forma simulada de río
            Positioned(
              left: 0,
              right: 0,
              top: 80,
              child: CustomPaint(
                size: const Size(double.infinity, 60),
                painter: _RioPainter(),
              ),
            ),
            // Puntos simulados en el mapa
            Positioned(
              left: 60,
              top: 40,
              child: _buildMapPin(Icons.water_rounded, const Color(0xFF4A90D9)),
            ),
            Positioned(
              left: 140,
              top: 100,
              child: _buildMapPin(Icons.agriculture_rounded, const Color(0xFF5A9E6F)),
            ),
            Positioned(
              right: 100,
              top: 120,
              child: _buildMapPin(Icons.grass_rounded, const Color(0xFFE0A030)),
            ),
            Positioned(
              right: 60,
              top: 60,
              child: _buildMapPin(Icons.factory_rounded, const Color(0xFF7B5EA7)),
            ),
            // Overlay próximamente
            Container(
              color: Colors.black.withOpacity(0.03),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: SiahColors.blanco.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: SiahColors.cardBorde),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.map_outlined,
                            size: 18,
                            color: SiahColors.textoSecundario),
                        const SizedBox(width: 8),
                        Text(
                          'Mapa interactivo de Sonora — Próximamente',
                          style: GoogleFonts.nunito(
                            fontSize: 12,
                            color: SiahColors.textoSecundario,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Se integrarán capas de: zonas agrícolas · niveles de sequía\nubicación de empresas · municipios con vacantes',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      fontSize: 11,
                      color: SiahColors.textoSecundario.withOpacity(0.6),
                      height: 1.5,
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

  Widget _buildMapPin(IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.5), width: 1.5),
          ),
          child: Icon(icon, color: color, size: 14),
        ),
        Container(
          width: 2,
          height: 8,
          color: color.withOpacity(0.5),
        ),
      ],
    );
  }

  Widget _buildCapasMapa() {
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
            'Capas del mapa',
            style: GoogleFonts.barlow(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: SiahColors.textoPrincipal,
            ),
          ),
          const SizedBox(height: 12),
          ..._capas.map((capa) {
            final isActive = _capasActivas.contains(capa['id']);
            final color = capa['color'] as Color;
            return GestureDetector(
              onTap: () => setState(() {
                if (isActive) {
                  _capasActivas.remove(capa['id']);
                } else {
                  _capasActivas.add(capa['id'] as String);
                }
              }),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: isActive ? color : Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isActive ? color : SiahColors.cardBorde,
                          width: 2,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      capa['label'] as String,
                      style: GoogleFonts.nunito(
                        fontSize: 13,
                        fontWeight: isActive
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: isActive
                            ? SiahColors.textoPrincipal
                            : SiahColors.textoSecundario,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildPuntosReferencia() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PUNTOS DE REFERENCIA',
          style: GoogleFonts.nunito(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: SiahColors.textoSecundario,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 10),
        ...List.generate(_puntos.length, (index) {
          final punto = _puntos[index];
          final isSelected = _puntoSeleccionado == index;
          final color = punto['color'] as Color;

          return GestureDetector(
            onTap: () => setState(() {
              _puntoSeleccionado = isSelected ? null : index;
            }),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: SiahColors.blanco,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? color : SiahColors.cardBorde,
                  width: isSelected ? 1.5 : 1,
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            punto['icono'] as IconData,
                            color: color, size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                punto['nombre'] as String,
                                style: GoogleFonts.barlow(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: SiahColors.textoPrincipal,
                                ),
                              ),
                              Text(
                                punto['subtitulo'] as String,
                                style: GoogleFonts.nunito(
                                  fontSize: 12,
                                  color: SiahColors.textoSecundario,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              punto['nivel'] as String,
                              style: GoogleFonts.barlow(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: color,
                              ),
                            ),
                            Text(
                              punto['labelNivel'] as String,
                              style: GoogleFonts.nunito(
                                fontSize: 10,
                                color: SiahColors.textoSecundario,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          isSelected
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          color: SiahColors.textoSecundario,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: color.withOpacity(0.2)),
                        ),
                        child: Text(
                          punto['detalle'] as String,
                          style: GoogleFonts.nunito(
                            fontSize: 13,
                            color: SiahColors.textoPrincipal,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _RioPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4A90D9).withOpacity(0.3)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, 30);
    path.cubicTo(
      size.width * 0.25, 10,
      size.width * 0.5, 50,
      size.width * 0.75, 20,
    );
    path.cubicTo(
      size.width * 0.85, 10,
      size.width * 0.95, 30,
      size.width, 25,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}