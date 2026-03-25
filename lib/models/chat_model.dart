import 'package:equatable/equatable.dart';

class ChatModel extends Equatable {
  final String id;
  final String userId;
  final String otherUserId;
  final String? lastMessage;
  final DateTime? lastMessageTime;
  final int unreadCount;
  final Map<String, dynamic>? otherUser;

  const ChatModel({
    required this.id,
    required this.userId,
    required this.otherUserId,
    this.lastMessage,
    this.lastMessageTime,
    this.unreadCount = 0,
    this.otherUser,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      userId: json['user_id'],
      otherUserId: json['other_user_id'],
      lastMessage: json['last_message'],
      lastMessageTime: json['last_message_time'] != null
          ? DateTime.parse(json['last_message_time'])
          : null,
      unreadCount: json['unread_count'] ?? 0,
      otherUser: json['other_user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'other_user_id': otherUserId,
      'last_message': lastMessage,
      'last_message_time': lastMessageTime?.toIso8601String(),
      'unread_count': unreadCount,
    };
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

  @override
  List<Object?> get props => [
        id,
        userId,
        otherUserId,
        lastMessage,
        lastMessageTime,
        unreadCount,
        otherUser,
      ];
}
