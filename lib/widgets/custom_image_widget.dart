import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomImageWidget extends StatelessWidget {
  const CustomImageWidget({
    super.key,
    required this.path,
    this.height = 20.0,
    this.width = 25.0,
    this.scale = 1.0,
    this.borderRadius = BorderRadius.zero,
    this.color,
    this.fit = BoxFit.contain,
  });

  final String path;
  final double height;
  final double width;
  final double scale;
  final BorderRadiusGeometry borderRadius;
  final Color? color;
  final BoxFit fit;

  bool get isSvg => path.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: isSvg
          ? SvgPicture.asset(
              path,
              height: height,
              width: width,
              color: color,
              fit: fit,
            )
          : Image.asset(
              path,
              height: height,
              width: width,
              scale: scale,
              fit: fit,
              color: color,
            ),
    );
  }
}
