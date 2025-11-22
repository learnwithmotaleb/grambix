import 'package:flutter/material.dart';
import 'dimensions.dart';

class Layout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const Layout({super.key, required this.mobile, this.tablet, this.desktop});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < Dimensions.mobileScreenWidth) {
          return mobile;
        } else if (constraints.maxWidth < Dimensions.tabletScreenWidth) {
          // return tablet ?? mobile; =>>  use this for tablet
          return mobile;
        } else {
          return desktop ?? mobile;
        }
      },
    );
  }
}
