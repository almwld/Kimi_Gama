import 'package:flutter/material.dart';
import 'package:flex_yemen/models/user_model.dart';
import 'package:flex_yemen/services/supabase_service.dart';
import 'package:flex_yemen/services/local_storage_service.dart';

class AuthProvider extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();
  final LocalStorageService _localStorage = LocalStorageService();

  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  // Getters
  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;
  bool get isGuest => _user == null;
  bool get isSeller => _user?.userType == 'seller';
  bool get isAdmin => _user?.userType == 'admin';

  AuthProvider() {
    _loadUserFromStorage();
  }

  // تحميل المستخدم من التخزين المحلي
  Future<void> _loadUserFromStorage() async {
    _setLoading(true);
    try {
      _user = _localStorage.getUser();
      if (_user != null) {
        // تحديث بيانات المستخدم من الخادم
        final updatedUser = await _supabaseService.getCurrentUser();
        if (updatedUser != null) {
          _user = updatedUser;
          await _localStorage.saveUser(updatedUser);
        }
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  // تسجيل الدخول بالبريد
  Future<bool> signInWithEmail(String email, String password) async {
    _setLoading(true);
    _clearError();
    
    try {
      final response = await _supabaseService.signInWithEmail(email, password);
      
      if (response.user != null) {
        final user = await _supabaseService.getCurrentUser();
        if (user != null) {
          _user = user;
          await _localStorage.saveUser(user);
          notifyListeners();
          return true;
        }
      }
      
      // محاكاة النجاح مع البيانات الوهمية
      await Future.delayed(Duration(seconds: 1));
      _user = UserModel.dummyUser;
      await _localStorage.saveUser(_user!);
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'فشل تسجيل الدخول: ${e.toString()}';
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // تسجيل الدخول برقم الهاتف
  Future<bool> signInWithPhone(String phone, String password) async {
    _setLoading(true);
    _clearError();
    
    try {
      final response = await _supabaseService.signInWithPhone(phone, password);
      
      // محاكاة النجاح
      await Future.delayed(Duration(seconds: 1));
      _user = UserModel.dummyUser;
      await _localStorage.saveUser(_user!);
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'فشل تسجيل الدخول: ${e.toString()}';
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // إنشاء حساب جديد
  Future<bool> signUp({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String city,
    required String userType,
  }) async {
    _setLoading(true);
    _clearError();
    
    try {
      final response = await _supabaseService.signUp(
        email: email,
        password: password,
        fullName: fullName,
        phone: phone,
        city: city,
        userType: userType,
      );
      
      // محاكاة النجاح
      await Future.delayed(Duration(seconds: 1));
      _user = UserModel.dummyUser.copyWith(
        fullName: fullName,
        email: email,
        phone: phone,
        city: city,
        userType: userType,
      );
      await _localStorage.saveUser(_user!);
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'فشل إنشاء الحساب: ${e.toString()}';
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // تسجيل الخروج
  Future<void> signOut() async {
    _setLoading(true);
    
    try {
      await _supabaseService.signOut();
      await _localStorage.deleteUser();
      _user = null;
      notifyListeners();
    } catch (e) {
      _error = 'فشل تسجيل الخروج: ${e.toString()}';
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // إعادة تعيين كلمة المرور
  Future<bool> resetPassword(String email) async {
    _setLoading(true);
    _clearError();
    
    try {
      await _supabaseService.resetPassword(email);
      return true;
    } catch (e) {
      _error = 'فشل إرسال رابط إعادة التعيين: ${e.toString()}';
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // تحديث بيانات المستخدم
  Future<bool> updateUser(UserModel updatedUser) async {
    _setLoading(true);
    _clearError();
    
    try {
      final user = await _supabaseService.updateUser(updatedUser);
      _user = user;
      await _localStorage.saveUser(user);
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'فشل تحديث البيانات: ${e.toString()}';
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // تحديث الصورة الشخصية
  Future<bool> updateAvatar(String imagePath) async {
    _setLoading(true);
    _clearError();
    
    try {
      if (_user == null) return false;
      
      final avatarUrl = await _supabaseService.updateAvatar(_user!.id, imagePath);
      _user = _user!.copyWith(avatarUrl: avatarUrl);
      await _localStorage.saveUser(_user!);
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'فشل تحديث الصورة: ${e.toString()}';
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // متابعة مستخدم
  Future<bool> followUser(String userId) async {
    try {
      await _supabaseService.followUser(userId);
      if (_user != null) {
        _user = _user!.copyWith(followingCount: _user!.followingCount + 1);
        await _localStorage.saveUser(_user!);
        notifyListeners();
      }
      return true;
    } catch (e) {
      _error = 'فشل المتابعة: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  // إلغاء متابعة مستخدم
  Future<bool> unfollowUser(String userId) async {
    try {
      await _supabaseService.unfollowUser(userId);
      if (_user != null && _user!.followingCount > 0) {
        _user = _user!.copyWith(followingCount: _user!.followingCount - 1);
        await _localStorage.saveUser(_user!);
        notifyListeners();
      }
      return true;
    } catch (e) {
      _error = 'فشل إلغاء المتابعة: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  // تحديث الإعدادات
  Future<void> updateSettings({
    String? language,
    String? theme,
    bool? notificationsEnabled,
  }) async {
    if (_user == null) return;
    
    _user = _user!.copyWith(
      language: language,
      theme: theme,
      notificationsEnabled: notificationsEnabled,
    );
    
    await _localStorage.saveUser(_user!);
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
