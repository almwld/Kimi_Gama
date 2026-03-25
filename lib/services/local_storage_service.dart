import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _darkModeKey = 'dark_mode';
  static const String _userKey = 'user';

  static Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  static Future<bool> getDarkMode() async {
    final prefs = await _getPrefs();
    return prefs.getBool(_darkModeKey) ?? false;
  }

  static Future<void> setDarkMode(bool isDark) async {
    final prefs = await _getPrefs();
    await prefs.setBool(_darkModeKey, isDark);
  }

  static Future<Map<String, dynamic>?> getUser() async {
    final prefs = await _getPrefs();
    final userString = prefs.getString(_userKey);
    if (userString != null) {
      return Map<String, dynamic>.from(userString as Map);
    }
    return null;
  }

  static Future<void> saveUser(Map<String, dynamic> user) async {
    final prefs = await _getPrefs();
    await prefs.setString(_userKey, user.toString());
  }

  static Future<void> deleteUser() async {
    final prefs = await _getPrefs();
    await prefs.remove(_userKey);
  }
}
