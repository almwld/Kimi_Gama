import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/local_storage_service.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> _products = [];
  List<String> _favoriteIds = [];

  List<ProductModel> get products => _products;
  List<String> get favorites => _favoriteIds;

  ProductProvider() {
    _loadFavorites();
  }

  void _loadFavorites() {
    _favoriteIds = LocalStorageService.getFavorites();
  }

  bool isFavorite(String productId) {
    return _favoriteIds.contains(productId);
  }

  void toggleFavorite(String productId) {
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
      LocalStorageService.removeFromFavorites(productId);
    } else {
      _favoriteIds.add(productId);
      LocalStorageService.addToFavorites(productId);
    }
    notifyListeners();
  }

  void setProducts(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }
}
