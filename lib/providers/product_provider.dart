import 'package:flutter/material.dart';
import 'package:flex_yemen/models/product_model.dart';
import 'package:flex_yemen/models/rating_model.dart';
import 'package:flex_yemen/services/supabase_service.dart';
import 'package:flex_yemen/services/local_storage_service.dart';

class ProductProvider extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();
  final LocalStorageService _localStorage = LocalStorageService();

  List<ProductModel> _products = [];
  List<ProductModel> _featuredProducts = [];
  List<ProductModel> _favorites = [];
  ProductModel? _selectedProduct;
  List<RatingModel> _productRatings = [];
  bool _isLoading = false;
  String? _error;
  bool _hasMore = true;
  int _currentPage = 1;

  // Getters
  List<ProductModel> get products => _products;
  List<ProductModel> get featuredProducts => _featuredProducts;
  List<ProductModel> get favorites => _favorites;
  ProductModel? get selectedProduct => _selectedProduct;
  List<RatingModel> get productRatings => _productRatings;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasMore => _hasMore;

  ProductProvider() {
    _loadFavorites();
  }

  // تحميل المفضلة من التخزين المحلي
  Future<void> _loadFavorites() async {
    _favorites = _localStorage.getFavorites();
    notifyListeners();
  }

  // الحصول على قائمة المنتجات
  Future<void> getProducts({
    bool refresh = false,
    String? categoryId,
    String? city,
    String? searchQuery,
    String sortBy = 'created_at',
  }) async {
    if (refresh) {
      _currentPage = 1;
      _hasMore = true;
      _products = [];
    }

    if (!_hasMore || _isLoading) return;

    _setLoading(true);
    _clearError();

    try {
      final newProducts = await _supabaseService.getProducts(
        page: _currentPage,
        limit: 20,
        categoryId: categoryId,
        city: city,
        searchQuery: searchQuery,
        sortBy: sortBy,
      );

      if (newProducts.length < 20) {
        _hasMore = false;
      }

      _products.addAll(newProducts);
      _currentPage++;
      
      notifyListeners();
    } catch (e) {
      _error = 'فشل جلب المنتجات: ${e.toString()}';
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // الحصول على المنتجات المميزة
  Future<void> getFeaturedProducts() async {
    _setLoading(true);
    _clearError();

    try {
      final products = await _supabaseService.getProducts(
        limit: 10,
        sortBy: 'views',
      );
      
      _featuredProducts = products.where((p) => p.isFeatured).toList();
      notifyListeners();
    } catch (e) {
      _error = 'فشل جلب المنتجات المميزة: ${e.toString()}';
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // الحصول على منتج واحد
  Future<void> getProduct(String productId) async {
    _setLoading(true);
    _clearError();

    try {
      _selectedProduct = await _supabaseService.getProduct(productId);
      
      // جلب التقييمات
      await getProductRatings(productId);
      
      notifyListeners();
    } catch (e) {
      _error = 'فشل جلب المنتج: ${e.toString()}';
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // إضافة منتج جديد
  Future<bool> addProduct(ProductModel product) async {
    _setLoading(true);
    _clearError();

    try {
      final newProduct = await _supabaseService.addProduct(product);
      _products.insert(0, newProduct);
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'فشل إضافة المنتج: ${e.toString()}';
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // تحديث منتج
  Future<bool> updateProduct(ProductModel product) async {
    _setLoading(true);
    _clearError();

    try {
      final updatedProduct = await _supabaseService.updateProduct(product);
      
      final index = _products.indexWhere((p) => p.id == product.id);
      if (index != -1) {
        _products[index] = updatedProduct;
      }
      
      if (_selectedProduct?.id == product.id) {
        _selectedProduct = updatedProduct;
      }
      
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'فشل تحديث المنتج: ${e.toString()}';
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // حذف منتج
  Future<bool> deleteProduct(String productId) async {
    _setLoading(true);
    _clearError();

    try {
      await _supabaseService.deleteProduct(productId);
      _products.removeWhere((p) => p.id == productId);
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'فشل حذف المنتج: ${e.toString()}';
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // إضافة/إزالة من المفضلة
  Future<bool> toggleFavorite(String productId) async {
    try {
      final isFavorite = await _supabaseService.toggleFavorite(productId);
      
      final index = _products.indexWhere((p) => p.id == productId);
      if (index != -1) {
        _products[index] = _products[index].copyWith(isFavorite: isFavorite);
      }
      
      if (_selectedProduct?.id == productId) {
        _selectedProduct = _selectedProduct!.copyWith(isFavorite: isFavorite);
      }

      if (isFavorite) {
        final product = _products.firstWhere((p) => p.id == productId);
        await _localStorage.addToFavorites(product);
        _favorites.add(product);
      } else {
        await _localStorage.removeFromFavorites(productId);
        _favorites.removeWhere((p) => p.id == productId);
      }

      notifyListeners();
      return isFavorite;
    } catch (e) {
      _error = 'فشل تحديث المفضلة: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  // الحصول على المفضلة
  Future<void> getFavorites() async {
    _setLoading(true);
    _clearError();

    try {
      _favorites = await _supabaseService.getFavorites();
      notifyListeners();
    } catch (e) {
      _error = 'فشل جلب المفضلة: ${e.toString()}';
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // الحصول على تقييمات منتج
  Future<void> getProductRatings(String productId) async {
    try {
      _productRatings = await _supabaseService.getProductRatings(productId);
      notifyListeners();
    } catch (e) {
      _error = 'فشل جلب التقييمات: ${e.toString()}';
    }
  }

  // إضافة تقييم
  Future<bool> addRating({
    required String productId,
    required double rating,
    String? comment,
    List<String>? images,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final newRating = await _supabaseService.addRating(
        productId: productId,
        rating: rating,
        comment: comment,
        images: images,
      );
      
      _productRatings.insert(0, newRating);
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'فشل إضافة التقييم: ${e.toString()}';
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // البحث عن منتجات
  Future<void> searchProducts(String query) async {
    await getProducts(refresh: true, searchQuery: query);
  }

  // مسح البحث
  void clearSearch() {
    _products = [];
    _currentPage = 1;
    _hasMore = true;
    notifyListeners();
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
