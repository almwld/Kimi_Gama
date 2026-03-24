import 'package:hive/hive.dart';

part 'notification_model.g.dart';

@HiveType(typeId: 9)
class NotificationModel extends HiveObject {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String userId;
  
  @HiveField(2)
  final String type;
  
  @HiveField(3)
  final String title;
  
  @HiveField(4)
  final String body;
  
  @HiveField(5)
  final String? imageUrl;
  
  @HiveField(6)
  final Map<String, dynamic>? data;
  
  @HiveField(7)
  final bool isRead;
  
  @HiveField(8)
  final DateTime createdAt;
  
  @HiveField(9)
  final DateTime? readAt;
  
  @HiveField(10)
  final String? actionUrl;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    required this.body,
    this.imageUrl,
    this.data,
    this.isRead = false,
    required this.createdAt,
    this.readAt,
    this.actionUrl,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      type: json['type'] ?? 'system',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      imageUrl: json['image_url'],
      data: json['data'] != null 
          ? Map<String, dynamic>.from(json['data']) 
          : null,
      isRead: json['is_read'] ?? false,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
      readAt: json['read_at'] != null 
          ? DateTime.parse(json['read_at']) 
          : null,
      actionUrl: json['action_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'type': type,
      'title': title,
      'body': body,
      'image_url': imageUrl,
      'data': data,
      'is_read': isRead,
      'created_at': createdAt.toIso8601String(),
      'read_at': readAt?.toIso8601String(),
      'action_url': actionUrl,
    };
  }

  // بيانات وهمية
  static List<NotificationModel> get dummyNotifications => [
    NotificationModel(
      id: 'notif_001',
      userId: 'user_001',
      type: 'order',
      title: 'تم تأكيد طلبك',
      body: 'تم تأكيد طلبك رقم #12345 وسيتم شحنه قريباً',
      imageUrl: 'https://picsum.photos/400/400?random=1',
      data: {'order_id': 'ord_001'},
      isRead: false,
      createdAt: DateTime.now().subtract(Duration(minutes: 30)),
      actionUrl: '/orders/ord_001',
    ),
    NotificationModel(
      id: 'notif_002',
      userId: 'user_001',
      type: 'message',
      title: 'رسالة جديدة',
      body: 'أرسل لك فاطمة عبدالله رسالة جديدة',
      imageUrl: 'https://i.pravatar.cc/150?img=5',
      data: {'chat_id': 'chat_001'},
      isRead: true,
      createdAt: DateTime.now().subtract(Duration(hours: 2)),
      readAt: DateTime.now().subtract(Duration(hours: 1)),
      actionUrl: '/chats/chat_001',
    ),
    NotificationModel(
      id: 'notif_003',
      userId: 'user_001',
      type: 'product',
      title: 'منتج جديد متاح',
      body: 'تم إضافة منتج جديد قد يعجبك: آيفون 15 برو',
      imageUrl: 'https://picsum.photos/400/400?random=5',
      data: {'product_id': 'p004'},
      isRead: false,
      createdAt: DateTime.now().subtract(Duration(hours: 5)),
      actionUrl: '/products/p004',
    ),
    NotificationModel(
      id: 'notif_004',
      userId: 'user_001',
      type: 'wallet',
      title: 'تم إيداع مبلغ',
      body: 'تم إيداع 500,000 ريال يمني في محفظتك',
      data: {'transaction_id': 'txn_001'},
      isRead: true,
      createdAt: DateTime.now().subtract(Duration(days: 1)),
      readAt: DateTime.now().subtract(Duration(hours: 20)),
      actionUrl: '/wallet/transactions',
    ),
    NotificationModel(
      id: 'notif_005',
      userId: 'user_001',
      type: 'system',
      title: 'تحديث التطبيق',
      body: 'يتوفر إصدار جديد من التطبيق مع ميزات جديدة',
      isRead: false,
      createdAt: DateTime.now().subtract(Duration(days: 2)),
    ),
    NotificationModel(
      id: 'notif_006',
      userId: 'user_001',
      type: 'promotion',
      title: 'عرض خاص!',
      body: 'خصم 20% على جميع منتجات الإلكترونيات هذا الأسبوع',
      imageUrl: 'https://picsum.photos/400/400?random=10',
      isRead: true,
      createdAt: DateTime.now().subtract(Duration(days: 3)),
      readAt: DateTime.now().subtract(Duration(days: 2)),
    ),
  ];
}
