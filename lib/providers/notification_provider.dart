import 'package:flutter/material.dart';
import '../services/supabase_service.dart';

class NotificationProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _notifications = [];
  bool _isLoading = false;

  List<Map<String, dynamic>> get notifications => _notifications;
  bool get isLoading => _isLoading;
  
  int get unreadCount {
    return _notifications.where((n) => !(n['is_read'] ?? false)).length;
  }

  Future<void> loadNotifications(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _notifications = await SupabaseService.getNotifications(userId);
    } catch (e) {
      print('Error loading notifications: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> markAsRead(String notificationId) async {
    final index = _notifications.indexWhere((n) => n['id'] == notificationId);
    if (index != -1) {
      _notifications[index]['is_read'] = true;
      notifyListeners();
    }
  }

  void addNotification(Map<String, dynamic> notification) {
    _notifications.insert(0, notification);
    notifyListeners();
  }
}
