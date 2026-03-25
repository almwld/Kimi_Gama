import 'package:flex_yemen/models/message_model.dart';

class ChatModel {
  final String id;
  final List<String> participants;
  final MessageModel? lastMessage;
  final int unreadCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  ChatModel({
    required this.id,
    required this.participants,
    this.lastMessage,
    this.unreadCount = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'] as String,
      participants: List<String>.from(json['participants']),
      lastMessage: json['lastMessage'] != null
          ? MessageModel.fromJson(json['lastMessage'])
          : null,
      unreadCount: json['unreadCount'] as int? ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'participants': participants,
      'lastMessage': lastMessage?.toJson(),
      'unreadCount': unreadCount,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  ChatModel copyWith({
    String? id,
    List<String>? participants,
    MessageModel? lastMessage,
    int? unreadCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ChatModel(
      id: id ?? this.id,
      participants: participants ?? this.participants,
      lastMessage: lastMessage ?? this.lastMessage,
      unreadCount: unreadCount ?? this.unreadCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
