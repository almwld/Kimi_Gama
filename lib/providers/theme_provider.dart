import 'package:flutter/material.dart';
import 'package:flex_yemen/services/local_storage_service.dart';

class ThemeProvider extends ChangeNotifier {
  final LocalStorageService _localStorage = LocalStorageService();

  ThemeMode _themeMode = ThemeMode.system;

  // Getters
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get isLightMode => _themeMode == ThemeMode.light;
  bool get isSystemMode => _themeMode == ThemeMode.system;

  ThemeProvider() {
    _loadTheme();
  }

  // تحميل الثيم المحفوظ
  Future<void> _loadTheme() async {
    final savedTheme = LocalStorageService.getTheme();
    
    switch (savedTheme) {
      case 'light':
        _themeMode = ThemeMode.light;
        break;
      case 'dark':
        _themeMode = ThemeMode.dark;
        break;
      default:
        _themeMode = ThemeMode.system;
    }
    
    notifyListeners();
  }

  // تعيين الثيم الفاتح
  Future<void> setLightMode() async {
    _themeMode = ThemeMode.light;
    await LocalStorageService.setTheme('light');
    notifyListeners();
  }

  // تعيين الثيم الداكن
  Future<void> setDarkMode() async {
    _themeMode = ThemeMode.dark;
    await LocalStorageService.setTheme('dark');
    notifyListeners();
  }

  // تعيين الثيم حسب النظام
  Future<void> setSystemMode() async {
    _themeMode = ThemeMode.system;
    await LocalStorageService.setTheme('system');
    notifyListeners();
  }

  // تبديل الثيم
  Future<void> toggleTheme() async {
    if (_themeMode == ThemeMode.light) {
      await setDarkMode();
    } else {
      await setLightMode();
    }
  }

  // الحصول على الثيم الحالي كنص
  String getThemeName() {
    switch (_themeMode) {
      case ThemeMode.light:
        return 'فاتح';
      case ThemeMode.dark:
        return 'داكن';
      case ThemeMode.system:
        return 'حسب النظام';
    }
  }
}
