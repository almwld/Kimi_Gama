import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final supabase = Supabase.instance.client;

  // المصادقة
  static Future<AuthResponse> signIn(String email, String password) async {
    return await supabase.auth.signInWithPassword(email: email, password: password);
  }

  static Future<AuthResponse> signUp(String email, String password, {Map<String, dynamic>? data}) async {
    return await supabase.auth.signUp(email: email, password: password, data: data);
  }

  static Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  static Future<void> resetPassword(String email) async {
    await supabase.auth.resetPasswordForEmail(email);
  }

  // المستخدم
  static Future<Map<String, dynamic>?> getUser(String userId) async {
    return await supabase.from('profiles').select().eq('id', userId).maybeSingle();
  }

  static Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    await supabase.from('profiles').update(data).eq('id', userId);
  }

  // المحفظة
  static Future<Map<String, dynamic>?> getWallet(String userId) async {
    return await supabase.from('wallets').select().eq('user_id', userId).maybeSingle();
  }

  static Future<void> createWallet(String userId) async {
    await supabase.from('wallets').insert({'user_id': userId, 'yer_balance': 0, 'sar_balance': 0, 'usd_balance': 0});
  }

  // المنتجات
  static Future<List<Map<String, dynamic>>> getProducts() async {
    final response = await supabase.from('products').select().order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  static Future<Map<String, dynamic>?> getProduct(String id) async {
    return await supabase.from('products').select().eq('id', id).maybeSingle();
  }

  // الطلبات
  static Future<List<Map<String, dynamic>>> getUserOrders(String userId) async {
    final response = await supabase.from('orders').select().eq('user_id', userId).order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  static Future<Map<String, dynamic>> createOrder(Map<String, dynamic> data) async {
    return await supabase.from('orders').insert(data).select().single();
  }

  // المحادثات
  static Future<List<Map<String, dynamic>>> getChats(String userId) async {
    final response = await supabase.from('chats').select().eq('user_id', userId);
    return List<Map<String, dynamic>>.from(response);
  }

  static Future<List<Map<String, dynamic>>> getMessages(String chatId) async {
    final response = await supabase.from('messages').select().eq('chat_id', chatId).order('created_at', ascending: true);
    return List<Map<String, dynamic>>.from(response);
  }

  static Future<Map<String, dynamic>> sendMessage(Map<String, dynamic> data) async {
    return await supabase.from('messages').insert(data).select().single();
  }

  // الإشعارات
  static Future<List<Map<String, dynamic>>> getNotifications(String userId) async {
    final response = await supabase.from('notifications').select().eq('user_id', userId).order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }
}
