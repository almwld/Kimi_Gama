import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorageService {
  static const String _darkModeKey = 'dark_mode';
  static const String _userKey = 'user';
  static const String _favoritesKey = 'favorites';
  static const String _cartKey = 'cart';

  static Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  // ===== الثيم =====
  static Future<bool> getDarkMode() async {
    final prefs = await _getPrefs();
    return prefs.getBool(_darkModeKey) ?? false;
  }

  static Future<void> setDarkMode(bool isDark) async {
    final prefs = await _getPrefs();
    await prefs.setBool(_darkModeKey, isDark);
  }

  // ===== المستخدم =====
  static Future<Map<String, dynamic>?> getUser() async {
    final prefs = await _getPrefs();
    final userString = prefs.getString(_userKey);
    if (userString != null) {
      return jsonDecode(userString) as Map<String, dynamic>;
    }
    return null;
  }

  static Future<void> saveUser(Map<String, dynamic> user) async {
    final prefs = await _getPrefs();
    await prefs.setString(_userKey, jsonEncode(user));
  }

  static Future<void> deleteUser() async {
    final prefs = await _getPrefs();
    await prefs.remove(_userKey);
  }

  // ===== المفضلة =====
  static List<String> getFavorites() {
    // هذه الدالة تحتاج إلى أن تكون غير متزامنة، لكن بعض الكود يستدعيها بشكل متزامن
    // سنستخدم Future لاحقاً
    return [];
  }

  static Future<List<String>> getFavoritesAsync() async {
    final prefs = await _getPrefs();
    return prefs.getStringList(_favoritesKey) ?? [];
  }

  static Future<void> addToFavorites(String productId) async {
    final prefs = await _getPrefs();
    final favorites = await getFavoritesAsync();
    if (!favorites.contains(productId)) {
      favorites.add(productId);
      await prefs.setStringList(_favoritesKey, favorites);
    }
  }

  static Future<void> removeFromFavorites(String productId) async {
    final prefs = await _getPrefs();
    final favorites = await getFavoritesAsync();
    favorites.remove(productId);
    await prefs.setStringList(_favoritesKey, favorites);
  }

  static Future<bool> isFavorite(String productId) async {
    final favorites = await getFavoritesAsync();
    return favorites.contains(productId);
  }

  // ===== السلة =====
  static List<Map<String, dynamic>> getCart() {
    return [];
  }

  static Future<List<Map<String, dynamic>>> getCartAsync() async {
    final prefs = await _getPrefs();
    final cartString = prefs.getString(_cartKey);
    if (cartString != null) {
      return List<Map<String, dynamic>>.from(jsonDecode(cartString));
    }
    return [];
  }

  static Future<void> addToCart(Map<String, dynamic> item) async {
    final prefs = await _getPrefs();
    final cart = await getCartAsync();
    cart.add(item);
    await prefs.setString(_cartKey, jsonEncode(cart));
  }

  static Future<void> removeFromCart(String productId) async {
    final prefs = await _getPrefs();
    final cart = await getCartAsync();
    cart.removeWhere((item) => item['productId'] == productId);
    await prefs.setString(_cartKey, jsonEncode(cart));
  }

  static Future<void> clearCart() async {
    final prefs = await _getPrefs();
    await prefs.remove(_cartKey);
  }
}
