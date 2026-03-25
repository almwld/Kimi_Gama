import 'package:flutter/material.dart';
import '../models/order_item_model.dart';
import '../services/local_storage_service.dart';

class OrderProvider extends ChangeNotifier {
  List<OrderItemModel> _cart = [];

  List<OrderItemModel> get cart => _cart;

  OrderProvider() {
    _loadCart();
  }

  void _loadCart() {
    final cartData = LocalStorageService.getCart();
    _cart = cartData.map((item) => OrderItemModel.fromJson(item)).toList();
  }

  void addToCart(OrderItemModel item) {
    _cart.add(item);
    LocalStorageService.addToCart(item.toJson());
    notifyListeners();
  }

  void removeFromCart(String productId) {
    _cart.removeWhere((item) => item.productId == productId);
    LocalStorageService.removeFromCart(productId);
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    LocalStorageService.clearCart();
    notifyListeners();
  }

  double getCartTotal() {
    return _cart.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }
}
