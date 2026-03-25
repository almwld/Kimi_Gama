import 'package:hive/hive.dart';


@HiveType(typeId: 5)
class ChatModel extends HiveObject {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final List<String> participants;
  
  @HiveField(2)
  final String? productId;
  
  @HiveField(3)
  final String? productTitle;
  
  @HiveField(4)
  final String? productImage;
  
  @HiveField(5)
  final MessageModel? lastMessage;
  
  @HiveField(6)
  final int unreadCount;
  
  @HiveField(7)
  final DateTime createdAt;
  
  @HiveField(8)
  final DateTime updatedAt;
  
  @HiveField(9)
  final bool isActive;
  
  @HiveField(10)
  final Map<String, dynamic>? otherUser;

  ChatModel({
    required this.id,
    required this.participants,
    this.productId,
    this.productTitle,
    this.productImage,
    this.lastMessage,
    this.unreadCount = 0,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
    this.otherUser,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'] ?? '',
      participants: List<String>.from(json['participants'] ?? []),
      productId: json['product_id'],
      productTitle: json['product_title'],
      productImage: json['product_image'],
      lastMessage: json['last_message'] != null 
          ? MessageModel.fromJson(json['last_message']) 
          : null,
      unreadCount: json['unread_count'] ?? 0,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at']) 
          : DateTime.now(),
      isActive: json['is_active'] ?? true,
      otherUser: json['other_user'] != null 
          ? Map<String, dynamic>.from(json['other_user']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'participants': participants,
      'product_id': productId,
      'product_title': productTitle,
      'product_image': productImage,
      'last_message': lastMessage?.toJson(),
      'unread_count': unreadCount,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_active': isActive,
      'other_user': otherUser,
    };
  }

  // بيانات وهمية
  static List<ChatModel> get dummyChats => [
    ChatModel(
      id: 'chat_001',
      participants: ['user_001', 'user_002'],
      productId: 'p001',
      productTitle: 'آيفون 15 برو ماكس',
      productImage: 'https://picsum.photos/400/400?random=1',
      lastMessage: MessageModel.dummyMessages[0],
      unreadCount: 2,
      createdAt: DateTime.now().subtract(Duration(days: 5)),
      updatedAt: DateTime.now().subtract(Duration(hours: 2)),
      otherUser: {
        'id': 'user_002',
        'full_name': 'فاطمة عبدالله',
        'avatar_url': 'https://i.pravatar.cc/150?img=5',
        'is_online': true,
      },
    ),
    ChatModel(
      id: 'chat_002',
      participants: ['user_001', 'user_003'],
      productId: 'p011',
      productTitle: 'تويوتا كامري 2023',
      productImage: 'https://picsum.photos/400/400?random=12',
      lastMessage: MessageModel.dummyMessages[2],
      unreadCount: 0,
      createdAt: DateTime.now().subtract(Duration(days: 10)),
      updatedAt: DateTime.now().subtract(Duration(days: 1)),
      otherUser: {
        'id': 'user_003',
        'full_name': 'خالد سعيد',
        'avatar_url': 'https://i.pravatar.cc/150?img=3',
        'is_online': false,
      },
    ),
    ChatModel(
      id: 'chat_003',
      participants: ['user_001', 'user_004'],
      lastMessage: MessageModel.dummyMessages[4],
      unreadCount: 5,
      createdAt: DateTime.now().subtract(Duration(days: 15)),
      updatedAt: DateTime.now().subtract(Duration(minutes: 30)),
      otherUser: {
        'id': 'user_004',
        'full_name': 'محمد علي',
        'avatar_url': 'https://i.pravatar.cc/150?img=8',
        'is_online': true,
      },
    ),
    ChatModel(
      id: 'chat_004',
      participants: ['user_001', 'user_005'],
      productId: 'p021',
      productTitle: 'ساعة رولكس',
      productImage: 'https://picsum.photos/400/400?random=22',
      lastMessage: MessageModel.dummyMessages[6],
      unreadCount: 0,
      createdAt: DateTime.now().subtract(Duration(days: 20)),
      updatedAt: DateTime.now().subtract(Duration(days: 3)),
      otherUser: {
        'id': 'user_005',
        'full_name': 'سارة أحمد',
        'avatar_url': 'https://i.pravatar.cc/150?img=9',
        'is_online': false,
      },
    ),
  ];
}

@HiveType(typeId: 6)
class MessageModel extends HiveObject {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String chatId;
  
  @HiveField(2)
  final String senderId;
  
  @HiveField(3)
  final String? text;
  
  @HiveField(4)
  final String? imageUrl;
  
  @HiveField(5)
  final String type;
  
  @HiveField(6)
  final DateTime createdAt;
  
  @HiveField(7)
  final bool isRead;
  
  @HiveField(8)
  final DateTime? readAt;
  
  @HiveField(9)
  final bool isDeleted;
  
  @HiveField(10)
  final String? replyTo;
  
  @HiveField(11)
  final Map<String, dynamic>? metadata;

  MessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    this.text,
    this.imageUrl,
    required this.type,
    required this.createdAt,
    this.isRead = false,
    this.readAt,
    this.isDeleted = false,
    this.replyTo,
    this.metadata,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] ?? '',
      chatId: json['chat_id'] ?? '',
      senderId: json['sender_id'] ?? '',
      text: json['text'],
      imageUrl: json['image_url'],
      type: json['type'] ?? 'text',
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
      isRead: json['is_read'] ?? false,
      readAt: json['read_at'] != null 
          ? DateTime.parse(json['read_at']) 
          : null,
      isDeleted: json['is_deleted'] ?? false,
      replyTo: json['reply_to'],
      metadata: json['metadata'] != null 
          ? Map<String, dynamic>.from(json['metadata']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chat_id': chatId,
      'sender_id': senderId,
      'text': text,
      'image_url': imageUrl,
      'type': type,
      'created_at': createdAt.toIso8601String(),
      'is_read': isRead,
      'read_at': readAt?.toIso8601String(),
      'is_deleted': isDeleted,
      'reply_to': replyTo,
      'metadata': metadata,
    };
  }

  // بيانات وهمية
  static List<MessageModel> get dummyMessages => [
    MessageModel(
      id: 'msg_001',
      chatId: 'chat_001',
      senderId: 'user_002',
      text: 'مرحباً، هل المنتج لا يزال متوفر؟',
      type: 'text',
      createdAt: DateTime.now().subtract(Duration(hours: 3)),
      isRead: true,
      readAt: DateTime.now().subtract(Duration(hours: 2)),
    ),
    MessageModel(
      id: 'msg_002',
      chatId: 'chat_001',
      senderId: 'user_001',
      text: 'نعم متوفر، هل تريد معرفة المزيد من التفاصيل؟',
      type: 'text',
      createdAt: DateTime.now().subtract(Duration(hours: 2)),
      isRead: false,
    ),
    MessageModel(
      id: 'msg_003',
      chatId: 'chat_002',
      senderId: 'user_003',
      text: 'السيارة بحالة ممتازة، هل يمكنني معاينتها؟',
      type: 'text',
      createdAt: DateTime.now().subtract(Duration(days: 1)),
      isRead: true,
      readAt: DateTime.now().subtract(Duration(days: 1)),
    ),
    MessageModel(
      id: 'msg_004',
      chatId: 'chat_002',
      senderId: 'user_001',
      text: 'بالتأكيد، أنا متواجد في صنعاء',
      type: 'text',
      createdAt: DateTime.now().subtract(Duration(days: 1)),
      isRead: true,
      readAt: DateTime.now().subtract(Duration(days: 1)),
    ),
    MessageModel(
      id: 'msg_005',
      chatId: 'chat_003',
      senderId: 'user_004',
      text: 'شكراً لك على التعامل',
      type: 'text',
      createdAt: DateTime.now().subtract(Duration(minutes: 45)),
      isRead: false,
    ),
    MessageModel(
      id: 'msg_006',
      chatId: 'chat_003',
      senderId: 'user_001',
      text: 'العفو، سعيد بالتعامل معك',
      type: 'text',
      createdAt: DateTime.now().subtract(Duration(minutes: 30)),
      isRead: false,
    ),
    MessageModel(
      id: 'msg_007',
      chatId: 'chat_004',
      senderId: 'user_005',
      text: 'هل يمكنك خفض السعر قليلاً؟',
      type: 'text',
      createdAt: DateTime.now().subtract(Duration(days: 3)),
      isRead: true,
      readAt: DateTime.now().subtract(Duration(days: 3)),
    ),
    MessageModel(
      id: 'msg_008',
      chatId: 'chat_004',
      senderId: 'user_001',
      imageUrl: 'https://picsum.photos/400/400?random=50',
      type: 'image',
      createdAt: DateTime.now().subtract(Duration(days: 3)),
      isRead: true,
      readAt: DateTime.now().subtract(Duration(days: 3)),
    ),
  ];
}

  ChatModel copyWith({
    String? id,
    String? userId,
    String? otherUserId,
    String? lastMessage,
    DateTime? lastMessageTime,
    int? unreadCount,
    Map<String, dynamic>? otherUser,
  }) {
    return ChatModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      otherUserId: otherUserId ?? this.otherUserId,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      unreadCount: unreadCount ?? this.unreadCount,
      otherUser: otherUser ?? this.otherUser,
    );
  }
