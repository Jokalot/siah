import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_siah/core/theme/app_theme.dart';
import 'package:proyecto_siah/widgets/main_shell.dart';
import 'package:proyecto_siah/widgets/cactus_icon.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _slideController;

  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;
  late Animation<Offset> _slideAnim;
  late Animation<double> _subtitleFade;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fadeAnim = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );
    _scaleAnim = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutBack),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOut),
    );
    _subtitleFade = CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeIn,
    );

    _iniciarAnimaciones();
  }

  Future<void> _iniciarAnimaciones() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _fadeController.forward();
    _scaleController.forward();
    await Future.delayed(const Duration(milliseconds: 400));
    _slideController.forward();
    await Future.delayed(const Duration(milliseconds: 1600));
    _navegarAlHome();
  }

  void _navegarAlHome() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const MainShell(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: SiahColors.terracota,
      body: Stack(
        children: [
          // Formas decorativas de fondo
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: SiahColors.blanco.withOpacity(0.05),
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            left: -80,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: SiahColors.blanco.withOpacity(0.05),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.15,
            left: -40,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: SiahColors.blanco.withOpacity(0.04),
              ),
            ),
          ),
          Positioned(
            bottom: size.height * 0.2,
            right: -30,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: SiahColors.blanco.withOpacity(0.04),
              ),
            ),
          ),

          // Línea decorativa diagonal
          Positioned.fill(
            child: CustomPaint(
              painter: _SplashLinePainter(),
            ),
          ),

          // Contenido central
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo animado
                FadeTransition(
                  opacity: _fadeAnim,
                  child: ScaleTransition(
                    scale: _scaleAnim,
                    child: Column(
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: SiahColors.blanco.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(
                              color: SiahColors.blanco.withOpacity(0.3),
                              width: 1.5,
                            ),
                          ),
                          child: const Center(
                            child: 
                            CactusIcon(
  size: 44,
  color: Colors.white,
),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'SIAH',
                          style: GoogleFonts.barlow(
                            fontSize: 56,
                            fontWeight: FontWeight.w900,
                            color: SiahColors.blanco,
                            letterSpacing: -1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Subtítulo animado
                SlideTransition(
                  position: _slideAnim,
                  child: FadeTransition(
                    opacity: _subtitleFade,
                    child: Column(
                      children: [
                        Text(
                          'Sistema Inteligente de',
                          style: GoogleFonts.nunito(
                            fontSize: 15,
                            color: SiahColors.blanco.withOpacity(0.85),
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          'Análisis Hídrico y Laboral',
                          style: GoogleFonts.nunito(
                            fontSize: 15,
                            color: SiahColors.blanco.withOpacity(0.85),
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Footer
          Positioned(
            bottom: 48,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _subtitleFade,
              child: Column(
                children: [
                  Text(
                    'SONORA · SECTOR AGRÍCOLA',
                    style: GoogleFonts.nunito(
                      fontSize: 10,
                      color: SiahColors.blanco.withOpacity(0.45),
                      letterSpacing: 2,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 40,
                    child: LinearProgressIndicator(
                      backgroundColor: SiahColors.blanco.withOpacity(0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        SiahColors.blanco.withOpacity(0.7),
                      ),
                      minHeight: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SplashLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.04)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 5; i++) {
      final path = Path();
      path.moveTo(0, size.height * (0.2 + i * 0.15));
      path.quadraticBezierTo(
        size.width * 0.5,
        size.height * (0.1 + i * 0.15),
        size.width,
        size.height * (0.25 + i * 0.15),
      );
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}