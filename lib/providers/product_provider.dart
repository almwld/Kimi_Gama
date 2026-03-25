import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/local_storage_service.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> _products = [];
  List<String> _favorites = [];

  List<ProductModel> get products => _products;
  List<String> get favorites => _favorites;

  ProductProvider() {
    _loadFavorites();
  }

  void _loadFavorites() {
    _favorites = LocalStorageService.getFavorites();
  }

  bool isFavorite(String productId) {
    return _favorites.contains(productId);
  }

  void toggleFavorite(String productId) {
    if (_favorites.contains(productId)) {
      _favorites.remove(productId);
      LocalStorageService.removeFromFavorites(productId);
    } else {
      _favorites.add(productId);
      LocalStorageService.addToFavorites(productId);
    }
    notifyListeners();
  }

  void setProducts(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }
}
