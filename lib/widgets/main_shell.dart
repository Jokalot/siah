import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_siah/core/theme/app_theme.dart';
import 'package:proyecto_siah/screens/home_screen.dart';
import 'package:proyecto_siah/screens/datos_climaticos_screen.dart';
import 'package:proyecto_siah/screens/empleo_agricola_screen.dart';
import 'package:proyecto_siah/screens/escenarios_sequia_screen.dart';
import 'package:proyecto_siah/widgets/cactus_icon.dart';
import 'package:proyecto_siah/widgets/siah_chat_fab.dart';
import 'package:proyecto_siah/screens/absorcion_laboral_screen.dart';
import 'package:proyecto_siah/screens/correlacion_screen.dart';
import 'package:proyecto_siah/screens/mapa_regional_screen.dart';
import 'package:proyecto_siah/screens/fuentes_datos_screen.dart';
import 'package:proyecto_siah/screens/acerca_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); 
  late final List<Widget> _screens;

@override
void initState() {
  super.initState();
  _screens = [
    HomeScreen(onNavigate: (index) => setState(() => _currentIndex = index)),
    const DatosClimaticosScreen(),
    const EmpleoAgricolaScreen(),
    const AbsorcionLaboralScreen(),
    const CorrelacionScreen(),
    const MapaRegionalScreen(),
    FuentesDatosScreen(),
    const AcercaScreen(),
  ];
}

final List<_NavItem> _navItems = const [
  _NavItem(icon: Icons.home_rounded, label: 'Inicio'),
  _NavItem(icon: Icons.water_drop_outlined, label: 'Clima'),
  _NavItem(icon: Icons.people_outline_rounded, label: 'Empleo'),
  _NavItem(icon: Icons.trending_up_rounded, label: 'Sectores'),
  _NavItem(icon: Icons.bar_chart_rounded, label: 'Correlación'),
  _NavItem(icon: Icons.map_outlined, label: 'Mapa'),
  _NavItem(icon: Icons.source_outlined, label: 'Fuentes'),
  _NavItem(icon: Icons.info_outline_rounded, label: 'Acerca'),
];

  void navigateTo(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  key: _scaffoldKey,
  body: IndexedStack(
    index: _currentIndex,
    children: _screens,
  ),
  floatingActionButton: const SiahChatFab(), 
  floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, 
  bottomNavigationBar: _buildBottomNav(),
  drawer: _buildDrawer(),
);
  }

Widget _buildBottomNav() {
  final items = [
    {'screenIndex': 1, 'icon': Icons.water_drop_outlined, 'label': 'Clima'},
    {'screenIndex': 2, 'icon': Icons.people_outline_rounded, 'label': 'Empleo'},
  ];
  final rightItems = [
    {'screenIndex': 3, 'icon': Icons.trending_up_rounded, 'label': 'Sectores'},
  ];

  return Container(
    decoration: BoxDecoration(
      color: SiahColors.blanco,
      border: Border(
        top: BorderSide(color: SiahColors.cardBorde, width: 1),
      ),
      boxShadow: [
        BoxShadow(
          color: SiahColors.textoPrincipal.withOpacity(0.06),
          blurRadius: 12,
          offset: const Offset(0, -4),
        ),
      ],
    ),
    child: SafeArea(
      child: SizedBox(
        height: 64,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Más — izquierda
            Expanded(
              child: GestureDetector(
                onTap: () => _scaffoldKey.currentState?.openDrawer(),
                child: _buildNavItem(
                  icon: Icons.menu_rounded,
                  label: 'Más',
                  isSelected: [4, 5, 6, 7].contains(_currentIndex),
                ),
              ),
            ),

            // Clima
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _currentIndex = 1),
                child: _buildNavItem(
                  icon: Icons.water_drop_outlined,
                  label: 'Clima',
                  isSelected: _currentIndex == 1,
                ),
              ),
            ),

            // Inicio — centro
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _currentIndex = 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _currentIndex == 0
                            ? SiahColors.terracota
                            : SiahColors.cremaOscura,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: _currentIndex == 0
                            ? [
                                BoxShadow(
                                  color:
                                      SiahColors.terracota.withOpacity(0.35),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                            : [],
                      ),
                      child: Icon(
                        Icons.home_rounded,
                        size: 22,
                        color: _currentIndex == 0
                            ? SiahColors.blanco
                            : SiahColors.textoSecundario,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Inicio',
                      style: GoogleFonts.nunito(
                        fontSize: 10,
                        fontWeight: _currentIndex == 0
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: _currentIndex == 0
                            ? SiahColors.terracota
                            : SiahColors.textoSecundario,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Empleo
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _currentIndex = 2),
                child: _buildNavItem(
                  icon: Icons.people_outline_rounded,
                  label: 'Empleo',
                  isSelected: _currentIndex == 2,
                ),
              ),
            ),

            // Sectores
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _currentIndex = 3),
                child: _buildNavItem(
                  icon: Icons.trending_up_rounded,
                  label: 'Sectores',
                  isSelected: _currentIndex == 3,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildNavItem({
  required IconData icon,
  required String label,
  required bool isSelected,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        icon,
        size: 22,
        color: isSelected ? SiahColors.terracota : SiahColors.textoSecundario,
      ),
      const SizedBox(height: 3),
      Text(
        label,
        style: GoogleFonts.nunito(
          fontSize: 10,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          color:
              isSelected ? SiahColors.terracota : SiahColors.textoSecundario,
        ),
      ),
    ],
  );
}

  Widget _buildDrawer() {
    final drawerItems = [
  {'index': 4, 'icon': Icons.bar_chart_rounded, 'label': 'Correlación'},
  {'index': 5, 'icon': Icons.map_outlined, 'label': 'Mapa regional'},
  {'index': 6, 'icon': Icons.source_outlined, 'label': 'Fuentes de datos'},
  {'index': 7, 'icon': Icons.info_outline_rounded, 'label': 'Acerca de SIAH'},
];

    return Drawer(
      backgroundColor: SiahColors.crema,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header drawer
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  CactusIcon(
  size: 28,
  color: SiahColors.verdeCactus,
),
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
                        'SISTEMA INTELIGENTE DE\nANÁLISIS HÍDRICO',
                        style: GoogleFonts.nunito(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: SiahColors.textoSecundario,
                          letterSpacing: 0.5,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(color: SiahColors.cardBorde, height: 1),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'MÁS SECCIONES',
                style: GoogleFonts.nunito(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: SiahColors.textoSecundario,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(height: 8),
            ...drawerItems.map((item) {
              final index = item['index'] as int;
              final isSelected = _currentIndex == index;
              return ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? SiahColors.terracota.withOpacity(0.12)
                        : SiahColors.cremaOscura,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    size: 20,
                    color: isSelected
                        ? SiahColors.terracota
                        : SiahColors.textoSecundario,
                  ),
                ),
                title: Text(
                  item['label'] as String,
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight:
                        isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected
                        ? SiahColors.terracota
                        : SiahColors.textoPrincipal,
                  ),
                ),
                selected: isSelected,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onTap: () {
                  setState(() => _currentIndex = index);
                  Navigator.pop(context);
                },
              );
            }),
            const Spacer(),
            Divider(color: SiahColors.cardBorde, height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: SiahColors.verdeCactus,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Sistema activo · v1.0.0',
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
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}