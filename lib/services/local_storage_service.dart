import 'package:hive_flutter/hive_flutter.dart';
import 'package:flex_yemen/models/user_model.dart';
import 'package:flex_yemen/models/product_model.dart';
import 'package:flex_yemen/models/order_model.dart';
import 'package:flex_yemen/models/chat_model.dart';
import 'package:flex_yemen/models/wallet_model.dart';
import 'package:flex_yemen/models/notification_model.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();
  factory LocalStorageService() => _instance;
  LocalStorageService._internal();

  // Boxes
  Box<UserModel>? _userBox;
  Box<ProductModel>? _favoritesBox;
  Box<OrderItemModel>? _cartBox;
  Box<dynamic>? _settingsBox;
  Box<String>? _searchHistoryBox;
  Box<NotificationModel>? _notificationsBox;

  // تهيئة Hive
  Future<void> init() async {
    await Hive.initFlutter();
    
    // تسجيل المحولات
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(ProductModelAdapter());
    Hive.registerAdapter(OrderItemModelAdapter());
    Hive.registerAdapter(WalletModelAdapter());
    Hive.registerAdapter(TransactionModelAdapter());
    Hive.registerAdapter(ChatModelAdapter());
    Hive.registerAdapter(MessageModelAdapter());
    Hive.registerAdapter(NotificationModelAdapter());
    Hive.registerAdapter(RatingModelAdapter());
    Hive.registerAdapter(AdModelAdapter());
    
    // فتح الصناديق
    _userBox = await Hive.openBox<UserModel>('user');
    _favoritesBox = await Hive.openBox<ProductModel>('favorites');
    _cartBox = await Hive.openBox<OrderItemModel>('cart');
    _settingsBox = await Hive.openBox<dynamic>('settings');
    _searchHistoryBox = await Hive.openBox<String>('search_history');
    _notificationsBox = await Hive.openBox<NotificationModel>('notifications');
  }

  // ==================== المستخدم ====================
  
  Future<void> saveUser(UserModel user) async {
    await _userBox?.put('current_user', user);
  }

  UserModel? getUser() {
    return _userBox?.get('current_user');
  }

  Future<void> deleteUser() async {
    await _userBox?.delete('current_user');
  }

  bool get isLoggedIn => getUser() != null;

  // ==================== المفضلة ====================
  
  Future<void> addToFavorites(ProductModel product) async {
    await _favoritesBox?.put(product.id, product);
  }

  Future<void> removeFromFavorites(String productId) async {
    await _favoritesBox?.delete(productId);
  }

  List<ProductModel> getFavorites() {
    return _favoritesBox?.values.toList() ?? [];
  }

  bool isFavorite(String productId) {
    return _favoritesBox?.containsKey(productId) ?? false;
  }

  Future<void> clearFavorites() async {
    await _favoritesBox?.clear();
  }

  // ==================== سلة التسوق ====================
  
  Future<void> addToCart(OrderItemModel item) async {
    await _cartBox?.put(item.productId, item);
  }

  Future<void> updateCartItem(String productId, int quantity) async {
    final item = _cartBox?.get(productId);
    if (item != null) {
      final updatedItem = OrderItemModel(
        id: item.id,
        productId: item.productId,
        productName: item.productName,
        productImage: item.productImage,
        price: item.price,
        quantity: quantity,
        total: item.price * quantity,
        sellerId: item.sellerId,
        sellerName: item.sellerName,
      );
      await _cartBox?.put(productId, updatedItem);
    }
  }

  Future<void> removeFromCart(String productId) async {
    await _cartBox?.delete(productId);
  }

  List<OrderItemModel> getCart() {
    return _cartBox?.values.toList() ?? [];
  }

  int get cartItemCount {
    return _cartBox?.length ?? 0;
  }

  double get cartTotal {
    return _cartBox?.values.fold(0.0, (sum, item) => sum + item.total) ?? 0.0;
  }

  Future<void> clearCart() async {
    await _cartBox?.clear();
  }

  // ==================== الإعدادات ====================
  
  Future<void> setSetting(String key, dynamic value) async {
    await _settingsBox?.put(key, value);
  }

  dynamic getSetting(String key, {dynamic defaultValue}) {
    return _settingsBox?.get(key, defaultValue: defaultValue);
  }

  // الثيم
  Future<void> setTheme(String theme) async {
    await setSetting('theme', theme);
  }

  String getTheme() {
    return getSetting('theme', defaultValue: 'system');
  }

  // اللغة
  Future<void> setLanguage(String language) async {
    await setSetting('language', language);
  }

  String getLanguage() {
    return getSetting('language', defaultValue: 'ar');
  }

  // الإشعارات
  Future<void> setNotificationsEnabled(bool enabled) async {
    await setSetting('notifications_enabled', enabled);
  }

  bool getNotificationsEnabled() {
    return getSetting('notifications_enabled', defaultValue: true);
  }

  // صوت الإشعارات
  Future<void> setNotificationSound(bool enabled) async {
    await setSetting('notification_sound', enabled);
  }

  bool getNotificationSound() {
    return getSetting('notification_sound', defaultValue: true);
  }

  // ==================== سجل البحث ====================
  
  Future<void> addSearchQuery(String query) async {
    if (query.trim().isEmpty) return;
    
    // إزالة الاستعلام إذا كان موجوداً مسبقاً
    final existingIndex = _searchHistoryBox?.values.toList().indexOf(query);
    if (existingIndex != null && existingIndex >= 0) {
      await _searchHistoryBox?.deleteAt(existingIndex);
    }
    
    // إضافة الاستعلام في البداية
    await _searchHistoryBox?.add(query);
    
    // الاحتفاظ بآخر 20 استعلام فقط
    if ((_searchHistoryBox?.length ?? 0) > 20) {
      await _searchHistoryBox?.deleteAt(0);
    }
  }

  List<String> getSearchHistory() {
    return _searchHistoryBox?.values.toList().reversed.toList() ?? [];
  }

  Future<void> clearSearchHistory() async {
    await _searchHistoryBox?.clear();
  }

  Future<void> removeSearchQuery(String query) async {
    final key = _searchHistoryBox?.values.toList().indexOf(query);
    if (key != null && key >= 0) {
      await _searchHistoryBox?.deleteAt(key);
    }
  }

  // ==================== الإشعارات المحلية ====================
  
  Future<void> saveNotification(NotificationModel notification) async {
    await _notificationsBox?.put(notification.id, notification);
  }

  List<NotificationModel> getNotifications() {
    return _notificationsBox?.values.toList() ?? [];
  }

  Future<void> deleteNotification(String notificationId) async {
    await _notificationsBox?.delete(notificationId);
  }

  Future<void> clearNotifications() async {
    await _notificationsBox?.clear();
  }

  // ==================== مسح جميع البيانات ====================
  
  Future<void> clearAll() async {
    await _userBox?.clear();
    await _favoritesBox?.clear();
    await _cartBox?.clear();
    await _settingsBox?.clear();
    await _searchHistoryBox?.clear();
    await _notificationsBox?.clear();
  }

  // ==================== تخزين مؤقت للمنتجات ====================
  
  Future<void> cacheProducts(List<ProductModel> products, String key) async {
    final box = await Hive.openBox<ProductModel>('cached_products_$key');
    await box.clear();
    for (var product in products) {
      await box.put(product.id, product);
    }
  }

  Future<List<ProductModel>> getCachedProducts(String key) async {
    final box = await Hive.openBox<ProductModel>('cached_products_$key');
    return box.values.toList();
  }

  Future<void> clearCachedProducts(String key) async {
    final box = await Hive.openBox<ProductModel>('cached_products_$key');
    await box.clear();
  }
}
