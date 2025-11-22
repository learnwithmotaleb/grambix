import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'model.dart';

part 'custom_colors.dart';

part 'themes.dart';

// LIGHT THEME DATA - - - - - - - - - - - - - - - - -

final ThemeData lightThemeData = ThemeData.light().copyWith(
  primaryColor: CustomColor.primary,
  dividerColor: Colors.transparent,
  colorScheme: ColorScheme.light(tertiary: CustomColor.tertiary),
  scaffoldBackgroundColor: CustomColor.background,
  appBarTheme: AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.light),
  textTheme: ThemeData.light().textTheme.apply(
    // fontFamily: GoogleFonts.montserrat().fontFamily,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      backgroundColor: CustomColor.primary,
      side: BorderSide(color: CustomColor.primary),
    ),
  ),
);

// DARK THEME DATA - - - - - - - - - - - - - - - - -

final ThemeData darkThemeData = ThemeData.dark().copyWith(
  primaryColor: CustomColor.primaryDark,
  colorScheme: ColorScheme.dark(surface: CustomColor.tertiaryDark),
  scaffoldBackgroundColor: CustomColor.backgroundDark,
  brightness: Brightness.dark,
  textTheme: ThemeData.dark().textTheme.apply(
    // fontFamily: GoogleFonts.inter().fontFamily,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      backgroundColor: CustomColor.primary,
      side: BorderSide(color: CustomColor.primary),
    ),
  ),
);
