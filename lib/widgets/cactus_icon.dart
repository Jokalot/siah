import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proyecto_siah/core/theme/app_theme.dart';

class CactusIcon extends StatelessWidget {
  final double size;
  final Color? color;

  const CactusIcon({
    super.key,
    this.size = 24,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/cactus.svg',
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(
        color ?? SiahColors.verdeCactus,
        BlendMode.srcIn,
      ),
    );
  }
}