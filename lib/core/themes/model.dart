import 'package:flutter/material.dart';

/// C color S shade M model
class CSM extends ColorSwatch<int> {
  const CSM(super.primary, super.swatch);
  Color? get full => this[100];
  Color? get highNinety => this[90];
  Color? get highEighty => this[80];
  Color? get highSeventy => this[70];
  Color? get mediumSixty => this[60];
  Color? get mediumFifty => this[50];
  Color? get mediumForty => this[40];
  Color? get lowThirty => this[30];
  Color? get lowTwenty => this[20];
  Color? get lowTen => this[10];
  Color? get lowFive => this[5];
  Color? get zero => this[0];
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
