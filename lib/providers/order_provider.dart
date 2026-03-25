import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';

class OrderProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _cart = [];

  OrderProvider() {
    _loadCart();
  }

  Future<void> _loadCart() async {
    _cart = await LocalStorageService.getCartAsync();
    notifyListeners();
  }

  List<Map<String, dynamic>> get cart => _cart;
  int get cartCount => _cart.length;

  Future<void> addToCart(Map<String, dynamic> item) async {
    await LocalStorageService.addToCart(item);
    _cart = await LocalStorageService.getCartAsync();
    notifyListeners();
  }

  Future<void> removeFromCart(String productId) async {
    await LocalStorageService.removeFromCart(productId);
    _cart = await LocalStorageService.getCartAsync();
    notifyListeners();
  }

  Future<void> clearCart() async {
    await LocalStorageService.clearCart();
    _cart = [];
    notifyListeners();
  }
}
