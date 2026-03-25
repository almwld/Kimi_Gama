import 'package:flutter/material.dart';
import 'package:flex_yemen/models/order_model.dart';
import 'package:flex_yemen/models/order_item_model.dart';
import 'package:flex_yemen/services/supabase_service.dart';
import 'package:flex_yemen/services/local_storage_service.dart';

class OrderProvider extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();
  final LocalStorageService _localStorage = LocalStorageService();

  List<OrderModel> _orders = [];
  List<OrderItemModel> _cart = [];
  OrderModel? _currentOrder;
  bool _isLoading = false;
  String? _error;

  // Getters
  List<OrderModel> get orders => _orders;
  List<OrderItemModel> get cart => _cart;
  OrderModel? get currentOrder => _currentOrder;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get cartItemCount => _cart.length;
  double get cartTotal => _cart.fold(0.0, (sum, item) => sum + item.total);
  double get cartSubtotal => _cart.fold(0.0, (sum, item) => sum + (item.price * item.quantity));

  OrderProvider() {
    _loadCart();
  }

  // تحميل السلة من التخزين المحلي
  Future<void> _loadCart() async {
    _cart = LocalStorageService.getCart();
    notifyListeners();
  }

  // الحصول على طلبات المستخدم
  Future<void> getOrders({String? status}) async {
    _setLoading(true);
    _clearError();

    try {
      _orders = await _supabaseService.getUserOrders(status: status);
      notifyListeners();
    } catch (e) {
      _error = 'فشل جلب الطلبات: ${e.toString()}';
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // الحصول على تفاصيل طلب
  Future<void> getOrder(String orderId) async {
    _setLoading(true);
    _clearError();

    try {
      _currentOrder = await _supabaseService.getOrder(orderId);
      notifyListeners();
    } catch (e) {
      _error = 'فشل جلب الطلب: ${e.toString()}';
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // إضافة إلى السلة
  Future<void> addToCart(OrderItemModel item) async {
    try {
      final existingIndex = _cart.indexWhere((i) => i.productId == item.productId);
      
      if (existingIndex != -1) {
        // تحديث الكمية إذا كان المنتج موجوداً
        final existingItem = _cart[existingIndex];
        final newQuantity = existingItem.quantity + item.quantity;
        await updateCartItemQuantity(item.productId, newQuantity);
      } else {
        _cart.add(item);
        await LocalStorageService.addToCart(item);
        notifyListeners();
      }
    } catch (e) {
      _error = 'فشل إضافة المنتج: ${e.toString()}';
      notifyListeners();
    }
  }

  // تحديث كمية منتج في السلة
  Future<void> updateCartItemQuantity(String productId, int quantity) async {
    try {
      if (quantity <= 0) {
        await removeFromCart(productId);
        return;
      }

      await _localStorage.updateCartItem(productId, quantity);
      
      final index = _cart.indexWhere((i) => i.productId == productId);
      if (index != -1) {
        final item = _cart[index];
        _cart[index] = OrderItemModel(
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
        notifyListeners();
      }
    } catch (e) {
      _error = 'فشل تحديث الكمية: ${e.toString()}';
      notifyListeners();
    }
  }

  // إزالة من السلة
  Future<void> removeFromCart(String productId) async {
    try {
      await LocalStorageService.removeFromCart(productId);
      _cart.removeWhere((i) => i.productId == productId);
      notifyListeners();
    } catch (e) {
      _error = 'فشل إزالة المنتج: ${e.toString()}';
      notifyListeners();
    }
  }

  // مسح السلة
  Future<void> clearCart() async {
    try {
      await LocalStorageService.clearCart();
      _cart = [];
      notifyListeners();
    } catch (e) {
      _error = 'فشل مسح السلة: ${e.toString()}';
      notifyListeners();
    }
  }

  // إنشاء طلب
  Future<bool> createOrder({
    required String shippingAddress,
    required String paymentMethod,
    double? shippingCost,
    double? tax,
    String? notes,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      if (_cart.isEmpty) {
        _error = 'السلة فارغة';
        notifyListeners();
        return false;
      }

      final subtotal = cartSubtotal;
      final totalShipping = shippingCost ?? 0;
      final totalTax = tax ?? 0;
      final total = subtotal + totalShipping + totalTax;

      final order = OrderModel(
        id: 'ord_${DateTime.now().millisecondsSinceEpoch}',
        buyerId: 'user_001',
        sellerId: _cart.first.sellerId ?? '',
        items: List.from(_cart),
        subtotal: subtotal,
        shippingCost: totalShipping,
        tax: totalTax,
        total: total,
        status: 'pending',
        paymentMethod: paymentMethod,
        paymentStatus: paymentMethod == 'cod' ? 'pending' : 'paid',
        shippingAddress: shippingAddress,
        notes: notes,
        createdAt: DateTime.now(),
      );

      final createdOrder = await _supabaseService.createOrder(order);
      
      _orders.insert(0, createdOrder);
      _currentOrder = createdOrder;
      
      // مسح السلة بعد إنشاء الطلب
      await clearCart();
      
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'فشل إنشاء الطلب: ${e.toString()}';
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // إلغاء طلب
  Future<bool> cancelOrder(String orderId, String reason) async {
    _setLoading(true);
    _clearError();

    try {
      await _supabaseService.cancelOrder(orderId, reason);
      
      final index = _orders.indexWhere((o) => o.id == orderId);
      if (index != -1) {
        _orders[index] = _orders[index].copyWith(
          status: 'cancelled',
          cancelledAt: DateTime.now(),
          cancellationReason: reason,
        );
      }

      if (_currentOrder?.id == orderId) {
        _currentOrder = _currentOrder!.copyWith(
          status: 'cancelled',
          cancelledAt: DateTime.now(),
          cancellationReason: reason,
        );
      }

      notifyListeners();
      return true;
    } catch (e) {
      _error = 'فشل إلغاء الطلب: ${e.toString()}';
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // تحديث حالة الطلب
  Future<void> updateOrderStatus(String orderId, String status) async {
    try {
      await _supabaseService.updateOrderStatus(orderId, status);
      
      final index = _orders.indexWhere((o) => o.id == orderId);
      if (index != -1) {
        _orders[index] = _orders[index].copyWith(status: status);
      }

      if (_currentOrder?.id == orderId) {
        _currentOrder = _currentOrder!.copyWith(status: status);
      }

      notifyListeners();
    } catch (e) {
      _error = 'فشل تحديث حالة الطلب: ${e.toString()}';
      notifyListeners();
    }
  }

  // التحقق من وجود منتج في السلة
  bool isInCart(String productId) {
    return _cart.any((item) => item.productId == productId);
  }

  // الحصول على كمية منتج في السلة
  int getCartItemQuantity(String productId) {
    final item = _cart.firstWhere(
      (i) => i.productId == productId,
      orElse: () => OrderItemModel(
        id: '',
        productId: '',
        productName: '',
        price: 0,
        quantity: 0,
        total: 0,
      ),
    );
    return item.quantity;
  }

  // مسح الخطأ
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Setters خاصة
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
  }
}
