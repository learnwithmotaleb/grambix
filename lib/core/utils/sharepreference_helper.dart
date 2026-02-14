import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static SharedPreferences? _prefs;

  /// Initialize (call in main before runApp)
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Keys
  static const String _tokenKey = 'token';
  static const String _userIdKey = 'userId';
  static const String _isLoggedInKey = 'isLoggedIn';

  /// Save Token
  static Future<void> saveToken(String token) async {
    await _prefs?.setString(_tokenKey, token);
  }

  /// Get Token
  static String get token => _prefs?.getString(_tokenKey) ?? '';

  /// Save User ID
  static Future<void> saveUserId(String userId) async {
    await _prefs?.setString(_userIdKey, userId);
  }

  /// Get User ID
  static String get userId => _prefs?.getString(_userIdKey) ?? '';

  /// Save Login Status
  static Future<void> setLoginStatus(bool value) async {
    await _prefs?.setBool(_isLoggedInKey, value);
  }

  /// Get Login Status
  static bool get isLoggedIn =>
      _prefs?.getBool(_isLoggedInKey) ?? false;

  /// Clear All Data
  static Future<void> clear() async {
    await _prefs?.clear();
  }
}
