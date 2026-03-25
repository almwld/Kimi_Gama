class MessageModel {
  final String id;
  final String chatId;
  final String senderId;
  final String text;
  final DateTime timestamp;
  final bool isRead;

  MessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.text,
    required this.timestamp,
    this.isRead = false,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String,
      chatId: json['chat_id'] as String,
      senderId: json['sender_id'] as String,
      text: json['text'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isRead: json['is_read'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chat_id': chatId,
      'sender_id': senderId,
      'text': text,
      'timestamp': timestamp.toIso8601String(),
      'is_read': isRead,
    };
  }
}
