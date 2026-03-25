import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _isDarkMode = LocalStorageService.getDarkMode();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    LocalStorageService.setDarkMode(_isDarkMode);
    notifyListeners();
  }

  void setDarkMode(bool value) {
    _isDarkMode = value;
    LocalStorageService.setDarkMode(value);
    notifyListeners();
  }
}
