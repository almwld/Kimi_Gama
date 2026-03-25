import 'package:flutter/material.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';
import '../services/supabase_service.dart';

class ChatProvider extends ChangeNotifier {
  List<ChatModel> _chats = [];
  List<MessageModel> _messages = [];
  ChatModel? _currentChat;
  bool _isLoading = false;

  List<ChatModel> get chats => _chats;
  List<MessageModel> get messages => _messages;
  ChatModel? get currentChat => _currentChat;
  bool get isLoading => _isLoading;

  Future<void> loadChats(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final chatsData = await SupabaseService.getChats(userId);
      _chats = chatsData.map((c) => ChatModel.fromJson(c)).toList();
    } catch (e) {
      print('Error loading chats: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setCurrentChat(ChatModel chat) {
    _currentChat = chat;
    notifyListeners();
  }
}
