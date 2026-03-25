import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  static const String _userBox = 'userBox';
  static const String _settingsBox = 'settingsBox';
  static const String _favoritesBox = 'favoritesBox';
  static const String _cartBox = 'cartBox';

  static late Box _userBoxInstance;
  static late Box _settingsBoxInstance;
  static late Box _favoritesBoxInstance;
  static late Box _cartBoxInstance;

  static Future<void> init() async {
    await Hive.initFlutter();
    _userBoxInstance = await Hive.openBox(_userBox);
    _settingsBoxInstance = await Hive.openBox(_settingsBox);
    _favoritesBoxInstance = await Hive.openBox(_favoritesBox);
    _cartBoxInstance = await Hive.openBox(_cartBox);
  }

  // المستخدم
  static Map<String, dynamic>? getUser() {
    return _userBoxInstance.get('current_user');
  }

  static Future<void> saveUser(Map<String, dynamic> user) async {
    await _userBoxInstance.put('current_user', user);
  }

  static Future<void> deleteUser() async {
    await _userBoxInstance.delete('current_user');
  }

  // المفضلة
  static List<String> getFavorites() {
    return _favoritesBoxInstance.get('favorites', defaultValue: <String>[]);
  }

  static Future<void> addToFavorites(String productId) async {
    List<String> favs = getFavorites();
    if (!favs.contains(productId)) {
      favs.add(productId);
      await _favoritesBoxInstance.put('favorites', favs);
    }
  }

  static Future<void> removeFromFavorites(String productId) async {
    List<String> favs = getFavorites();
    favs.remove(productId);
    await _favoritesBoxInstance.put('favorites', favs);
  }

  // سلة التسوق
  static List<Map<String, dynamic>> getCart() {
    return _cartBoxInstance.get('cart', defaultValue: <Map<String, dynamic>>[]);
  }

  static Future<void> addToCart(Map<String, dynamic> item) async {
    List<Map<String, dynamic>> cart = getCart();
    cart.add(item);
    await _cartBoxInstance.put('cart', cart);
  }

  static Future<void> removeFromCart(String productId) async {
    List<Map<String, dynamic>> cart = getCart();
    cart.removeWhere((item) => item['productId'] == productId);
    await _cartBoxInstance.put('cart', cart);
  }

  static Future<void> clearCart() async {
    await _cartBoxInstance.delete('cart');
  }

  // الإعدادات
  static bool getDarkMode() {
    return _settingsBoxInstance.get('dark_mode', defaultValue: false);
  }

  static Future<void> setDarkMode(bool isDark) async {
    await _settingsBoxInstance.put('dark_mode', isDark);
  }

  static String getLanguage() {
    return _settingsBoxInstance.get('language', defaultValue: 'ar');
  }

  static Future<void> setLanguage(String lang) async {
    await _settingsBoxInstance.put('language', lang);
  }
}
