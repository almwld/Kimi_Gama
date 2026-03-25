class MessageModel {
  final String id;
  final String chatId;
  final String senderId;
  final String text;
  final String type;
  final String? imageUrl;
  final DateTime createdAt;
  final bool isRead;

  MessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.text,
    this.type = 'text',
    this.imageUrl,
    required this.createdAt,
    this.isRead = false,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String,
      chatId: json['chatId'] as String,
      senderId: json['senderId'] as String,
      text: json['text'] as String,
      type: json['type'] as String? ?? 'text',
      imageUrl: json['imageUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isRead: json['isRead'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chatId': chatId,
      'senderId': senderId,
      'text': text,
      'type': type,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
      'isRead': isRead,
    };
  }

  MessageModel copyWith({
    String? id,
    String? chatId,
    String? senderId,
    String? text,
    String? type,
    String? imageUrl,
    DateTime? createdAt,
    bool? isRead,
  }) {
    return MessageModel(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      text: text ?? this.text,
      type: type ?? this.type,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
    );
  }
}
