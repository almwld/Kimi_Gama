import 'package:flutter/material.dart';
import 'package:flex_yemen/models/chat_model.dart';
import 'package:flex_yemen/services/supabase_service.dart';

class ChatProvider extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();

  List<ChatModel> _chats = [];
  List<MessageModel> _messages = [];
  ChatModel? _currentChat;
  bool _isLoading = false;
  String? _error;
  bool _isTyping = false;

  // Getters
  List<ChatModel> get chats => _chats;
  List<MessageModel> get messages => _messages;
  ChatModel? get currentChat => _currentChat;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isTyping => _isTyping;
  int get unreadCount => _chats.fold(0, (sum, chat) => sum + chat.unreadCount);

  // الحصول على المحادثات
  Future<void> getChats() async {
    _setLoading(true);
    _clearError();

    try {
      _chats = await _supabaseService.getChats();
      notifyListeners();
    } catch (e) {
      _error = 'فشل جلب المحادثات: ${e.toString()}';
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // إنشاء محادثة جديدة
  Future<ChatModel?> createChat({
    required String otherUserId,
    String? productId,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final chat = await _supabaseService.createChat(
        otherUserId: otherUserId,
        productId: productId,
      );
      
      _chats.insert(0, chat);
      _currentChat = chat;
      notifyListeners();
      return chat;
    } catch (e) {
      _error = 'فشل إنشاء المحادثة: ${e.toString()}';
      notifyListeners();
      return null;
    } finally {
      _setLoading(false);
    }
  }

  // فتح محادثة
  Future<void> openChat(String chatId) async {
    _setLoading(true);
    _clearError();

    try {
      _currentChat = _chats.firstWhere(
        (c) => c.id == chatId,
        orElse: () => ChatModel(
          id: chatId,
          participants: [],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
      
      // جلب الرسائل
      await getMessages(chatId);
      
      notifyListeners();
    } catch (e) {
      _error = 'فشل فتح المحادثة: ${e.toString()}';
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // الحصول على الرسائل
  Future<void> getMessages(String chatId, {int page = 1}) async {
    _setLoading(true);
    _clearError();

    try {
      _messages = await _supabaseService.getMessages(chatId, page: page);
      notifyListeners();
    } catch (e) {
      _error = 'فشل جلب الرسائل: ${e.toString()}';
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // إرسال رسالة
  Future<bool> sendMessage({
    required String chatId,
    required String text,
    String? imageUrl,
  }) async {
    if (text.trim().isEmpty && imageUrl == null) return false;

    try {
      final message = await _supabaseService.sendMessage(
        chatId: chatId,
        text: text,
        imageUrl: imageUrl,
      );

      _messages.add(message);
      
      // تحديث آخر رسالة في المحادثة
      final chatIndex = _chats.indexWhere((c) => c.id == chatId);
      if (chatIndex != -1) {
        _chats[chatIndex] = _chats[chatIndex].copyWith(
          lastMessage: message,
          updatedAt: DateTime.now(),
        );
      }

      notifyListeners();
      return true;
    } catch (e) {
      _error = 'فشل إرسال الرسالة: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  // تحميل صورة
  Future<String?> uploadImage(String chatId, String imagePath) async {
    _setLoading(true);
    _clearError();

    try {
      final imageUrl = await _supabaseService.uploadChatImage(chatId, imagePath);
      return imageUrl;
    } catch (e) {
      _error = 'فشل تحميل الصورة: ${e.toString()}';
      notifyListeners();
      return null;
    } finally {
      _setLoading(false);
    }
  }

  // إرسال صورة
  Future<bool> sendImage(String chatId, String imagePath) async {
    _setLoading(true);
    _clearError();

    try {
      final imageUrl = await uploadImage(chatId, imagePath);
      if (imageUrl != null) {
        return await sendMessage(chatId: chatId, text: '', imageUrl: imageUrl);
      }
      return false;
    } catch (e) {
      _error = 'فشل إرسال الصورة: ${e.toString()}';
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // محاكاة الكتابة
  void setTyping(bool typing) {
    _isTyping = typing;
    notifyListeners();
  }

  // محاكاة استلام رسالة
  Future<void> simulateIncomingMessage(String chatId) async {
    setTyping(true);
    await Future.delayed(Duration(seconds: 2));
    setTyping(false);

    final replyMessage = MessageModel(
      id: 'msg_reply_${DateTime.now().millisecondsSinceEpoch}',
      chatId: chatId,
      senderId: _currentChat?.participants.firstWhere(
        (p) => p != 'user_001',
        orElse: () => 'user_002',
      ) ?? 'user_002',
      text: 'شكراً لتواصلك معي، سأرد عليك في أقرب وقت',
      type: 'text',
      createdAt: DateTime.now(),
    );

    _messages.add(replyMessage);
    
    // تحديث آخر رسالة
    final chatIndex = _chats.indexWhere((c) => c.id == chatId);
    if (chatIndex != -1) {
      _chats[chatIndex] = _chats[chatIndex].copyWith(
        lastMessage: replyMessage,
        updatedAt: DateTime.now(),
        unreadCount: _chats[chatIndex].unreadCount + 1,
      );
    }

    notifyListeners();
  }

  // تحديد الرسائل كمقروءة
  Future<void> markAsRead(String chatId) async {
    try {
      final chatIndex = _chats.indexWhere((c) => c.id == chatId);
      if (chatIndex != -1) {
        _chats[chatIndex] = _chats[chatIndex].copyWith(unreadCount: 0);
        notifyListeners();
      }
    } catch (e) {
      print('Error marking as read: $e');
    }
  }

  // حذف محادثة
  Future<void> deleteChat(String chatId) async {
    try {
      _chats.removeWhere((c) => c.id == chatId);
      if (_currentChat?.id == chatId) {
        _currentChat = null;
        _messages = [];
      }
      notifyListeners();
    } catch (e) {
      _error = 'فشل حذف المحادثة: ${e.toString()}';
      notifyListeners();
    }
  }

  // مسح الرسائل
  void clearMessages() {
    _messages = [];
    notifyListeners();
  }

  // إغلاق المحادثة الحالية
  void closeCurrentChat() {
    _currentChat = null;
    _messages = [];
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
