import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/local_storage_service.dart';
import '../services/supabase_service.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> _products = [];
  List<String> _favoriteIds = [];
  bool _isLoading = false;

  List<ProductModel> get products => _products;
  List<String> get favorites => _favoriteIds;
  bool get isLoading => _isLoading;

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

  Future<void> getProducts({bool refresh = false}) async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();

    try {
      final productsData = await SupabaseService.getProducts();
      _products = productsData.map((p) => ProductModel.fromJson(p)).toList();
    } catch (e) {
      print('Error loading products: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
