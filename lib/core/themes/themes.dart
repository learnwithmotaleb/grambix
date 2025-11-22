part of 'token.dart';

class Themes {
  final box = GetStorage();
  final key = 'isDarkMode';

  void saveTheme(bool isDarkMode) => box.write(key, isDarkMode);

  bool loadTheme() => box.read(key) ?? false;

  ThemeMode get currentTheme => loadTheme() ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    final newTheme = loadTheme() ? ThemeMode.light : ThemeMode.dark;
    Get.changeThemeMode(newTheme);
    saveTheme(!loadTheme());
  }

  static final light = lightThemeData;
  static final dark = darkThemeData;
}
