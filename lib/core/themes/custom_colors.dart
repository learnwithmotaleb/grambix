part of 'token.dart';

class CustomColor {
  //Light Color
  static Color primary = HexColor('#FFBA00');
  static Color secondary = HexColor('#6F6F6F');
  static Color secondaryTextColor = HexColor('#9F9C96');
  static Color tertiary = HexColor('#F5F5F5');
  static Color background = HexColor('#171717');
  static Color typography = HexColor('#1D1D1D');
  static Color disableColor = HexColor('#BCBCBC');

  //Dark Color
  static Color primaryDark = HexColor('#007bff');
  static Color secondaryDark = HexColor('#FC5B3F');
  static Color tertiaryDark = HexColor('#1D1D1D');
  static Color backgroundDark = HexColor('#171717');
  static Color typographyDark = HexColor('#FFFFFF');

  // Status Color
  static Color ongoing = HexColor('#FFFFFF');
  static Color pending = HexColor('#FF9E45');
  static Color saved = HexColor('#2C8CFA');
  static Color canceled = HexColor('#FFFFFF');
  static Color selected = HexColor('#27B059');
  static Color rejected = HexColor('#DC3A3A');
  static Color bottomNavColor = HexColor('#00000033');

  // Grey Shades (for Dark Mode)
  static Color grey850 = const Color(0xFF212121);
  static Color grey800 = const Color(0xFF424242);
  static Color grey700 = const Color(0xFF616161);
  static Color grey600 = const Color(0xFF757575);
  static Color grey400 = const Color(0xFFBDBDBD);
  static Color grey200 = const Color(0xFFEEEEEE);

  // Shade Color
  static CSM typographyShade = CSM(typography.value, typographyShadeToken);
  static CSM typographyDarkShade = CSM(typography.value, typoDarkShadeToken);
  static CSM primaryShade = CSM(primary.value, primaryShadeToken);

  // Others
  static const Color whiteColor = Color(0xffFFFFFF);
  static const Color blackColor = Color(0xFF000000);
  static const Color blueColor = Color(0xFF2323FF);
  static const Color primaryColorShadeZero = Color(0xFFFFF2F0);

  /// SHADE TOKENS (Done)
  static Map<int, Color> typographyShadeToken = {
    100: HexColor('#0A0A0A'),
    90: HexColor('#0D0D0D'),
    80: HexColor('#111111'),
    70: HexColor('#161616'),
    60: HexColor('#171717'),
    50: HexColor('#1A1A1A'),
    40: HexColor('#8C8C8C'),
    30: HexColor('#B9B9B9'),
    20: HexColor('#DDDDDD'),
    10: HexColor('#BBBBBB'),
    5: HexColor('#D2D2D2'),
    0: HexColor('#E8E8E8'),
  };

  //( Not Done)
  static Map<int, Color> typoDarkShadeToken = {
    100: HexColor('#FFFFFF'),
    90: HexColor('#0D0D0D'),
    80: HexColor('#111111'),
    70: HexColor('#161616'),
    60: HexColor('#171717'),
    50: HexColor('#1A1A1A'),
    40: HexColor('#FFFFFF'),
    30: HexColor('#B9B9B9'),
    20: HexColor('#DDDDDD'),
    10: HexColor('#BBBBBB'),
    5: HexColor('#D2D2D2'),
    0: HexColor('#E8E8E8'),
  };

  static Map<int, Color> primaryShadeToken = {
    100: HexColor('#FFFFFF'),
    80: HexColor('#FFFFFF'),
    70: HexColor('#FFFFFF'),
    60: HexColor('#FFFFFF'),
    50: HexColor('#FFFFFF'),
    40: HexColor('#FFFFFF'),
    30: HexColor('#FFFFFF'),
    20: HexColor('#FFFFFF'),
    10: HexColor('#FFFFFF'),
    0: HexColor('#FFFFFF'),
  };
}
