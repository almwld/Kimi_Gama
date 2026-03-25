import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';

class ProductProvider extends ChangeNotifier {
  List<String> _favoriteIds = [];

  ProductProvider() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    _favoriteIds = await LocalStorageService.getFavoritesAsync();
    notifyListeners();
  }

  bool isFavorite(String productId) {
    return _favoriteIds.contains(productId);
  }

  Future<void> toggleFavorite(String productId) async {
    if (isFavorite(productId)) {
      _favoriteIds.remove(productId);
      await LocalStorageService.removeFromFavorites(productId);
    } else {
      _favoriteIds.add(productId);
      await LocalStorageService.addToFavorites(productId);
    }
    notifyListeners();
  }
}
