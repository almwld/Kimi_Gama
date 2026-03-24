import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flex_yemen/models/notification_model.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _localNotifications = 
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // تهيئة الإشعارات
  Future<void> init() async {
    // طلب إذن الإشعارات
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // إعدادات الإشعارات المحلية
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // إعداد قناة الإشعارات لنظام Android
    await _createNotificationChannel();

    // الاستماع للإشعارات الواردة
    FirebaseMessaging.onMessage.listen(_onForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // إنشاء قناة الإشعارات
  Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'flex_yemen_channel',
      'Flex Yemen Notifications',
      description: 'إشعارات تطبيق Flex Yemen',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  // عند النقر على الإشعار
  void _onNotificationTapped(NotificationResponse response) {
    // معالجة النقر على الإشعار
    final payload = response.payload;
    if (payload != null) {
      // التنقل إلى الشاشة المناسبة
    }
  }

  // عند استلام إشعار في المقدمة
  void _onForegroundMessage(RemoteMessage message) {
    showLocalNotification(
      title: message.notification?.title ?? 'Flex Yemen',
      body: message.notification?.body ?? '',
      payload: message.data.toString(),
    );
  }

  // عند فتح التطبيق من الإشعار
  void _onMessageOpenedApp(RemoteMessage message) {
    // التنقل إلى الشاشة المناسبة
  }

  // عرض إشعار محلي
  Future<void> showLocalNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'flex_yemen_channel',
      'Flex Yemen Notifications',
      channelDescription: 'إشعارات تطبيق Flex Yemen',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
      enableVibration: true,
      playSound: true,
      icon: '@mipmap/ic_launcher',
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      DateTime.now().millisecond,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  // عرض إشعار تقدم
  Future<void> showProgressNotification({
    required String title,
    required String body,
    required int progress,
    required int maxProgress,
  }) async {
    final AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'flex_yemen_progress_channel',
      'Progress Notifications',
      channelDescription: 'إشعارات التقدم',
      importance: Importance.low,
      priority: Priority.low,
      showProgress: true,
      maxProgress: maxProgress,
      progress: progress,
      onlyAlertOnce: true,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: false,
      presentBadge: false,
      presentSound: false,
    );

    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }

  // الحصول على FCM Token
  Future<String?> getFCMToken() async {
    return await _firebaseMessaging.getToken();
  }

  // الاشتراك في موضوع
  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  // إلغاء الاشتراك من موضوع
  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  // تحديث FCM Token
  Future<void> onTokenRefresh(Function(String) callback) async {
    _firebaseMessaging.onTokenRefresh.listen(callback);
  }

  // إلغاء جميع الإشعارات
  Future<void> cancelAllNotifications() async {
    await _localNotifications.cancelAll();
  }

  // إلغاء إشعار محدد
  Future<void> cancelNotification(int id) async {
    await _localNotifications.cancel(id);
  }

  // الحصول على الإشعارات المعلقة
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _localNotifications.pendingNotificationRequests();
  }

  // جدولة إشعار
  Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    // يتطلب إضافة timezone package
    // await _localNotifications.zonedSchedule(
    //   DateTime.now().millisecond,
    //   title,
    //   body,
    //   tz.TZDateTime.from(scheduledDate, tz.local),
    //   notificationDetails,
    //   payload: payload,
    //   androidAllowWhileIdle: true,
    //   uiLocalNotificationDateInterpretation:
    //       UILocalNotificationDateInterpretation.absoluteTime,
    // );
  }

  // عرض إشعار من NotificationModel
  Future<void> showNotificationFromModel(NotificationModel notification) async {
    await showLocalNotification(
      title: notification.title,
      body: notification.body,
      payload: notification.actionUrl,
    );
  }
}

// معالج الإشعارات في الخلفية
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // معالجة الإشعار في الخلفية
  print('Handling a background message: ${message.messageId}');
}
