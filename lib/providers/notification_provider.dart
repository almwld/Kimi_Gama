import 'package:flutter/material.dart';
import 'package:flex_yemen/models/notification_model.dart';
import 'package:flex_yemen/services/supabase_service.dart';
import 'package:flex_yemen/services/local_storage_service.dart';

class NotificationProvider extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();
  final LocalStorageService _localStorage = LocalStorageService();

  List<NotificationModel> _notifications = [];
  bool _isLoading = false;
  String? _error;
  bool _notificationsEnabled = true;

  // Getters
  List<NotificationModel> get notifications => _notifications;
  List<NotificationModel> get unreadNotifications => 
      _notifications.where((n) => !n.isRead).toList();
  int get unreadCount => unreadNotifications.length;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get notificationsEnabled => _notificationsEnabled;

  NotificationProvider() {
    _loadSettings();
  }

  // تحميل الإعدادات
  Future<void> _loadSettings() async {
    _notificationsEnabled = LocalStorageService.getNotificationsEnabled();
    notifyListeners();
  }

  // الحصول على الإشعارات
  Future<void> getNotifications({bool unreadOnly = false}) async {
    _setLoading(true);
    _clearError();

    try {
      _notifications = await _supabaseService.getNotifications(
        unreadOnly: unreadOnly,
      );
      notifyListeners();
    } catch (e) {
      _error = 'فشل جلب الإشعارات: ${e.toString()}';
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // تحديد إشعار كمقروء
  Future<void> markAsRead(String notificationId) async {
    try {
      await _supabaseService.markNotificationAsRead(notificationId);
      
      final index = _notifications.indexWhere((n) => n.id == notificationId);
      if (index != -1) {
        _notifications[index] = _notifications[index].copyWith(
          isRead: true,
          readAt: DateTime.now(),
        );
        notifyListeners();
      }
    } catch (e) {
      _error = 'فشل تحديث الإشعار: ${e.toString()}';
      notifyListeners();
    }
  }

  // تحديد كل الإشعارات كمقروءة
  Future<void> markAllAsRead() async {
    _setLoading(true);
    _clearError();

    try {
      await _supabaseService.markAllNotificationsAsRead();
      
      _notifications = _notifications.map((n) => 
        n.copyWith(isRead: true, readAt: DateTime.now())
      ).toList();
      
      notifyListeners();
    } catch (e) {
      _error = 'فشل تحديث الإشعارات: ${e.toString()}';
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // حذف إشعار
  Future<void> deleteNotification(String notificationId) async {
    try {
      await LocalStorageService.deleteNotification(notificationId);
      _notifications.removeWhere((n) => n.id == notificationId);
      notifyListeners();
    } catch (e) {
      _error = 'فشل حذف الإشعار: ${e.toString()}';
      notifyListeners();
    }
  }

  // مسح جميع الإشعارات
  Future<void> clearAllNotifications() async {
    _setLoading(true);
    _clearError();

    try {
      await LocalStorageService.clearNotifications();
      _notifications = [];
      notifyListeners();
    } catch (e) {
      _error = 'فشل مسح الإشعارات: ${e.toString()}';
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // تفعيل/تعطيل الإشعارات
  Future<void> setNotificationsEnabled(bool enabled) async {
    _notificationsEnabled = enabled;
    await LocalStorageService.setNotificationsEnabled(enabled);
    notifyListeners();
  }

  // إضافة إشعار محلي
  Future<void> addLocalNotification(NotificationModel notification) async {
    try {
      await LocalStorageService.saveNotification(notification);
      _notifications.insert(0, notification);
      notifyListeners();
    } catch (e) {
      _error = 'فشل إضافة الإشعار: ${e.toString()}';
      notifyListeners();
    }
  }

  // محاكاة استلام إشعار جديد
  Future<void> simulateNewNotification() async {
    final newNotification = NotificationModel(
      id: 'notif_${DateTime.now().millisecondsSinceEpoch}',
      userId: 'user_001',
      type: 'system',
      title: 'إشعار جديد',
      body: 'هذا إشعار تجريبي لاختبار النظام',
      createdAt: DateTime.now(),
      isRead: false,
    );

    await addLocalNotification(newNotification);
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

// Extension لـ NotificationModel
extension NotificationModelExtension on NotificationModel {
  NotificationModel copyWith({
    String? id,
    String? userId,
    String? type,
    String? title,
    String? body,
    String? imageUrl,
    Map<String, dynamic>? data,
    bool? isRead,
    DateTime? createdAt,
    DateTime? readAt,
    String? actionUrl,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      title: title ?? this.title,
      body: body ?? this.body,
      imageUrl: imageUrl ?? this.imageUrl,
      data: data ?? this.data,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      readAt: readAt ?? this.readAt,
      actionUrl: actionUrl ?? this.actionUrl,
    );
  }
}
