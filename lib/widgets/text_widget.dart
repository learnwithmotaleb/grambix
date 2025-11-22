import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../core/themes/model.dart';
import '../core/utils/basic_import.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      this.text, {
        super.key,
        this.textAlign,
        this.textOverflow,
        this.padding = EdgeInsets.zero,
        this.opacity = 1.0,
        this.maxLines,
        this.fontSize,
        this.fontWeight,
        this.color,
        this.style,
        this.onTap,
        this.colorShade = ColorShade.full,
        this.typographyStyle = TypographyStyle.titleMedium,
      });

  final String text;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final EdgeInsetsGeometry padding;
  final double opacity;
  final int? maxLines;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextStyle? style;
  final VoidCallback? onTap;
  final TypographyStyle typographyStyle;
  final ColorShade colorShade;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = (style ?? _style(typographyStyle)).copyWith(
      color: color ?? _color(colorShade),
      fontSize: fontSize,
      fontWeight: fontWeight,
    );

    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Opacity(
        opacity: opacity,
        child: Padding(
          padding: padding,
          child: Text(
            text,
            textAlign: textAlign,
            overflow: textOverflow,
            maxLines: maxLines,
            textScaler: TextScaler.linear(ScreenUtil().textScaleFactor),
            style: effectiveStyle,
          ),
        ),
      ),
    );
  }
}

TextStyle _style(TypographyStyle type) {
  switch (type) {
    case TypographyStyle.displayLarge:
      return CustomStyle.displayLarge;
    case TypographyStyle.displayMedium:
      return CustomStyle.displayMedium;
    case TypographyStyle.displaySmall:
      return CustomStyle.displaySmall;
    case TypographyStyle.headlineLarge:
      return CustomStyle.headlineLarge;
    case TypographyStyle.headlineMedium:
      return CustomStyle.headlineMedium;
    case TypographyStyle.headlineSmall:
      return CustomStyle.headlineSmall;
    case TypographyStyle.titleLarge:
      return CustomStyle.titleLarge;
    case TypographyStyle.titleMedium:
      return CustomStyle.titleMedium;
    case TypographyStyle.titleSmall:
      return CustomStyle.titleSmall;
    case TypographyStyle.bodyLarge:
      return CustomStyle.bodyLarge;
    case TypographyStyle.bodyMedium:
      return CustomStyle.bodyMedium;
    case TypographyStyle.bodySmall:
      return CustomStyle.bodySmall;
    case TypographyStyle.labelLarge:
      return CustomStyle.labelLarge;
    case TypographyStyle.labelMedium:
      return CustomStyle.labelMedium;
    case TypographyStyle.labelSmall:
      return CustomStyle.labelSmall;
  }
}

Color? _color(ColorShade shade) {
  final CSM csm = Get.isDarkMode
      ? CustomColor.typographyDarkShade
      : CustomColor.typographyShade;

  switch (shade) {
    case ColorShade.full:
      return csm.full;
    case ColorShade.highNinety:
      return csm.highNinety;
    case ColorShade.highEighty:
      return csm.highEighty;
    case ColorShade.highSeventy:
      return csm.highSeventy;
    case ColorShade.mediumSixty:
      return csm.mediumSixty;
    case ColorShade.mediumFifty:
      return csm.mediumFifty;
    case ColorShade.mediumForty:
      return csm.mediumForty;
    case ColorShade.lowThirty:
      return csm.lowThirty;
    case ColorShade.lowTwenty:
      return csm.lowTwenty;
    case ColorShade.lowTen:
      return csm.lowTen;
    case ColorShade.lowFive:
      return csm.lowFive;
    case ColorShade.zero:
      return csm.zero;
  }
}

// Enums (Keep them for developer-friendly usage)
enum TypographyStyle {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
  labelSmall,
}

enum ColorShade {
  full,
  highNinety,
  highEighty,
  highSeventy,
  mediumSixty,
  mediumFifty,
  mediumForty,
  lowThirty,
  lowTwenty,
  lowTen,
  lowFive,
  zero,
}
