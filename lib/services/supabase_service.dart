import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flex_yemen/models/user_model.dart';
import 'package:flex_yemen/models/product_model.dart';
import 'package:flex_yemen/models/order_model.dart';
import 'package:flex_yemen/models/chat_model.dart';
import 'package:flex_yemen/models/wallet_model.dart';
import 'package:flex_yemen/models/notification_model.dart';
import 'package:flex_yemen/models/rating_model.dart';
import 'package:flex_yemen/core/constants/app_constants.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  SupabaseClient get client => Supabase.instance.client;
  
  // التحقق من حالة المصادقة
  bool get isAuthenticated => client.auth.currentUser != null;
  
  // الحصول على المستخدم الحالي
  User? get currentUser => client.auth.currentUser;
  
  // ==================== المصادقة ====================
  
  // تسجيل الدخول بالبريد وكلمة المرور
  Future<AuthResponse> signInWithEmail(String email, String password) async {
    try {
      // محاكاة - استخدام بيانات وهمية
      await Future.delayed(Duration(seconds: 1));
      return AuthResponse(session: null, user: null);
    } catch (e) {
      throw Exception('فشل تسجيل الدخول: $e');
    }
  }
  
  // تسجيل الدخول برقم الهاتف
  Future<AuthResponse> signInWithPhone(String phone, String password) async {
    try {
      await Future.delayed(Duration(seconds: 1));
      return AuthResponse(session: null, user: null);
    } catch (e) {
      throw Exception('فشل تسجيل الدخول: $e');
    }
  }
  
  // إنشاء حساب جديد
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required String city,
    required String userType,
  }) async {
    try {
      await Future.delayed(Duration(seconds: 1));
      return AuthResponse(session: null, user: null);
    } catch (e) {
      throw Exception('فشل إنشاء الحساب: $e');
    }
  }
  
  // تسجيل الخروج
  Future<void> signOut() async {
    try {
      await Future.delayed(Duration(milliseconds: 500));
    } catch (e) {
      throw Exception('فشل تسجيل الخروج: $e');
    }
  }
  
  // إعادة تعيين كلمة المرور
  Future<void> resetPassword(String email) async {
    try {
      await Future.delayed(Duration(seconds: 1));
    } catch (e) {
      throw Exception('فشل إرسال رابط إعادة التعيين: $e');
    }
  }
  
  // تحديث كلمة المرور
  Future<void> updatePassword(String newPassword) async {
    try {
      await Future.delayed(Duration(seconds: 1));
    } catch (e) {
      throw Exception('فشل تحديث كلمة المرور: $e');
    }
  }
  
  // ==================== المستخدمين ====================
  
  // الحصول على المستخدم الحالي
  Future<UserModel?> getCurrentUser() async {
    try {
      await Future.delayed(Duration(milliseconds: 500));
    } catch (e) {
      throw Exception('فشل جلب بيانات المستخدم: $e');
    }
  }
  
  // تحديث بيانات المستخدم
  Future<UserModel> updateUser(UserModel user) async {
    try {
      await Future.delayed(Duration(seconds: 1));
      return user;
    } catch (e) {
      throw Exception('فشل تحديث بيانات المستخدم: $e');
    }
  }
  
  // تحديث الصورة الشخصية
  Future<String> updateAvatar(String userId, String imagePath) async {
    try {
      await Future.delayed(Duration(seconds: 1));
      return 'https://i.pravatar.cc/150?img=11';
    } catch (e) {
      throw Exception('فشل تحديث الصورة: $e');
    }
  }
  
  // متابعة مستخدم
  Future<void> followUser(String userId) async {
    try {
      await Future.delayed(Duration(milliseconds: 500));
    } catch (e) {
      throw Exception('فشل المتابعة: $e');
    }
  }
  
  // إلغاء متابعة مستخدم
  Future<void> unfollowUser(String userId) async {
    try {
      await Future.delayed(Duration(milliseconds: 500));
    } catch (e) {
      throw Exception('فشل إلغاء المتابعة: $e');
    }
  }
  
  // ==================== المنتجات ====================
  
  // الحصول على قائمة المنتجات
  Future<List<ProductModel>> getProducts({
    int page = 1,
    int limit = 20,
    String? categoryId,
    String? city,
    String? searchQuery,
    String sortBy = 'created_at',
    bool ascending = false,
  }) async {
    try {
      await Future.delayed(Duration(seconds: 1));
      
      
      // تصفية حسب الفئة
      if (categoryId != null) {
        products = products.where((p) => p.categoryId == categoryId).toList();
      }
      
      // تصفية حسب المدينة
      if (city != null) {
        products = products.where((p) => p.city == city).toList();
      }
      
      // البحث
      if (searchQuery != null && searchQuery.isNotEmpty) {
        products = products.where((p) => 
          p.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          p.description.toLowerCase().contains(searchQuery.toLowerCase())
        ).toList();
      }
      
      // الترتيب
      products.sort((a, b) {
        switch (sortBy) {
          case 'price':
            return ascending 
                ? a.price.compareTo(b.price) 
                : b.price.compareTo(a.price);
          case 'views':
            return ascending 
                ? a.views.compareTo(b.views) 
                : b.views.compareTo(a.views);
          case 'rating':
            return ascending 
                ? a.rating.compareTo(b.rating) 
                : b.rating.compareTo(a.rating);
          default:
            return ascending 
                ? a.createdAt.compareTo(b.createdAt) 
                : b.createdAt.compareTo(a.createdAt);
        }
      });
      
      // التصفية الصفحية
      final startIndex = (page - 1) * limit;
      final endIndex = startIndex + limit;
      
      if (startIndex >= products.length) return [];
      
      return products.sublist(
        startIndex, 
        endIndex > products.length ? products.length : endIndex
      );
    } catch (e) {
      throw Exception('فشل جلب المنتجات: $e');
    }
  }
  
  // الحصول على منتج واحد
  Future<ProductModel> getProduct(String productId) async {
    try {
      await Future.delayed(Duration(milliseconds: 500));
        (p) => p.id == productId,
      );
    } catch (e) {
      throw Exception('فشل جلب المنتج: $e');
    }
  }
  
  // إضافة منتج جديد
  Future<ProductModel> addProduct(ProductModel product) async {
    try {
      await Future.delayed(Duration(seconds: 2));
      return product;
    } catch (e) {
      throw Exception('فشل إضافة المنتج: $e');
    }
  }
  
  // تحديث منتج
  Future<ProductModel> updateProduct(ProductModel product) async {
    try {
      await Future.delayed(Duration(seconds: 1));
      return product;
    } catch (e) {
      throw Exception('فشل تحديث المنتج: $e');
    }
  }
  
  // حذف منتج
  Future<void> deleteProduct(String productId) async {
    try {
      await Future.delayed(Duration(seconds: 1));
    } catch (e) {
      throw Exception('فشل حذف المنتج: $e');
    }
  }
  
  // إضافة/إزالة من المفضلة
  Future<bool> toggleFavorite(String productId) async {
    try {
      await Future.delayed(Duration(milliseconds: 500));
      return true;
    } catch (e) {
      throw Exception('فشل تحديث المفضلة: $e');
    }
  }
  
  // الحصول على المفضلة
  Future<List<ProductModel>> getFavorites() async {
    try {
      await Future.delayed(Duration(seconds: 1));
    } catch (e) {
      throw Exception('فشل جلب المفضلة: $e');
    }
  }
  
  // ==================== الطلبات ====================
  
  // إنشاء طلب جديد
  Future<OrderModel> createOrder(OrderModel order) async {
    try {
      await Future.delayed(Duration(seconds: 2));
      return order;
    } catch (e) {
      throw Exception('فشل إنشاء الطلب: $e');
    }
  }
  
  // الحصول على طلبات المستخدم
  Future<List<OrderModel>> getUserOrders({
    String? status,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      await Future.delayed(Duration(seconds: 1));
      
      
      if (status != null) {
        orders = orders.where((o) => o.status == status).toList();
      }
      
      return orders;
    } catch (e) {
      throw Exception('فشل جلب الطلبات: $e');
    }
  }
  
  // الحصول على تفاصيل طلب
  Future<OrderModel> getOrder(String orderId) async {
    try {
      await Future.delayed(Duration(milliseconds: 500));
        (o) => o.id == orderId,
      );
    } catch (e) {
      throw Exception('فشل جلب الطلب: $e');
    }
  }
  
  // تحديث حالة الطلب
  Future<void> updateOrderStatus(String orderId, String status) async {
    try {
      await Future.delayed(Duration(seconds: 1));
    } catch (e) {
      throw Exception('فشل تحديث حالة الطلب: $e');
    }
  }
  
  // إلغاء طلب
  Future<void> cancelOrder(String orderId, String reason) async {
    try {
      await Future.delayed(Duration(seconds: 1));
    } catch (e) {
      throw Exception('فشل إلغاء الطلب: $e');
    }
  }
  
  // ==================== المحفظة ====================
  
  // الحصول على المحفظة
  Future<WalletModel> getWallet() async {
    try {
      await Future.delayed(Duration(milliseconds: 500));
    } catch (e) {
      throw Exception('فشل جلب المحفظة: $e');
    }
  }
  
  // الحصول على المعاملات
  Future<List<TransactionModel>> getTransactions({
    String? type,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      await Future.delayed(Duration(seconds: 1));
      
      
      if (type != null) {
        transactions = transactions.where((t) => t.type == type).toList();
      }
      
      return transactions;
    } catch (e) {
      throw Exception('فشل جلب المعاملات: $e');
    }
  }
  
  // إيداع
  Future<TransactionModel> deposit({
    required double amount,
    required String currency,
    required String paymentMethod,
  }) async {
    try {
      await Future.delayed(Duration(seconds: 2));
      return TransactionModel(
        id: 'txn_${DateTime.now().millisecondsSinceEpoch}',
        walletId: 'wallet_001',
        userId: 'user_001',
        type: 'deposit',
        status: 'pending',
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod,
        createdAt: DateTime.now(),
      );
    } catch (e) {
      throw Exception('فشل الإيداع: $e');
    }
  }
  
  // سحب
  Future<TransactionModel> withdraw({
    required double amount,
    required String currency,
    required String method,
  }) async {
    try {
      await Future.delayed(Duration(seconds: 2));
      return TransactionModel(
        id: 'txn_${DateTime.now().millisecondsSinceEpoch}',
        walletId: 'wallet_001',
        userId: 'user_001',
        type: 'withdrawal',
        status: 'pending',
        amount: amount,
        currency: currency,
        paymentMethod: method,
        createdAt: DateTime.now(),
      );
    } catch (e) {
      throw Exception('فشل السحب: $e');
    }
  }
  
  // تحويل
  Future<TransactionModel> transfer({
    required double amount,
    required String currency,
    required String recipientId,
    String? description,
  }) async {
    try {
      await Future.delayed(Duration(seconds: 2));
      return TransactionModel(
        id: 'txn_${DateTime.now().millisecondsSinceEpoch}',
        walletId: 'wallet_001',
        userId: 'user_001',
        type: 'transfer',
        status: 'completed',
        amount: amount,
        currency: currency,
        recipientId: recipientId,
        recipientName: 'مستخدم آخر',
        description: description,
        createdAt: DateTime.now(),
        completedAt: DateTime.now(),
      );
    } catch (e) {
      throw Exception('فشل التحويل: $e');
    }
  }
  
  // ==================== المحادثات ====================
  
  // الحصول على المحادثات
  Future<List<ChatModel>> getChats() async {
    try {
      await Future.delayed(Duration(seconds: 1));
    } catch (e) {
      throw Exception('فشل جلب المحادثات: $e');
    }
  }
  
  // إنشاء محادثة جديدة
  Future<ChatModel> createChat({
    required String otherUserId,
    String? productId,
  }) async {
    try {
      await Future.delayed(Duration(seconds: 1));
      return ChatModel(
        id: 'chat_${DateTime.now().millisecondsSinceEpoch}',
        participants: ['user_001', otherUserId],
        productId: productId,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    } catch (e) {
      throw Exception('فشل إنشاء المحادثة: $e');
    }
  }
  
  // الحصول على الرسائل
  Future<List<MessageModel>> getMessages(String chatId, {int page = 1}) async {
    try {
      await Future.delayed(Duration(seconds: 1));
    } catch (e) {
      throw Exception('فشل جلب الرسائل: $e');
    }
  }
  
  // إرسال رسالة
  Future<MessageModel> sendMessage({
    required String chatId,
    required String text,
    String? imageUrl,
  }) async {
    try {
      await Future.delayed(Duration(milliseconds: 500));
      return MessageModel(
        id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
        chatId: chatId,
        senderId: 'user_001',
        text: text,
        imageUrl: imageUrl,
        type: imageUrl != null ? 'image' : 'text',
        createdAt: DateTime.now(),
      );
    } catch (e) {
      throw Exception('فشل إرسال الرسالة: $e');
    }
  }
  
  // تحميل صورة المحادثة
  Future<String> uploadChatImage(String chatId, String imagePath) async {
    try {
      await Future.delayed(Duration(seconds: 2));
      return 'https://picsum.photos/400/400?random=100';
    } catch (e) {
      throw Exception('فشل تحميل الصورة: $e');
    }
  }
  
  // ==================== الإشعارات ====================
  
  // الحصول على الإشعارات
  Future<List<NotificationModel>> getNotifications({bool unreadOnly = false}) async {
    try {
      await Future.delayed(Duration(seconds: 1));
      
      
      if (unreadOnly) {
        notifications = notifications.where((n) => !n.isRead).toList();
      }
      
      return notifications;
    } catch (e) {
      throw Exception('فشل جلب الإشعارات: $e');
    }
  }
  
  // تحديد إشعار كمقروء
  Future<void> markNotificationAsRead(String notificationId) async {
    try {
      await Future.delayed(Duration(milliseconds: 300));
    } catch (e) {
      throw Exception('فشل تحديث الإشعار: $e');
    }
  }
  
  // تحديد كل الإشعارات كمقروءة
  Future<void> markAllNotificationsAsRead() async {
    try {
      await Future.delayed(Duration(milliseconds: 500));
    } catch (e) {
      throw Exception('فشل تحديث الإشعارات: $e');
    }
  }
  
  // ==================== التقييمات ====================
  
  // الحصول على تقييمات منتج
  Future<List<RatingModel>> getProductRatings(String productId) async {
    try {
      await Future.delayed(Duration(seconds: 1));
    } catch (e) {
      throw Exception('فشل جلب التقييمات: $e');
    }
  }
  
  // إضافة تقييم
  Future<RatingModel> addRating({
    required String productId,
    required double rating,
    String? comment,
    List<String>? images,
  }) async {
    try {
      await Future.delayed(Duration(seconds: 1));
      return RatingModel(
        id: 'rate_${DateTime.now().millisecondsSinceEpoch}',
        productId: productId,
        reviewerId: 'user_001',
        reviewerName: 'أحمد محمد',
        reviewerAvatar: 'https://i.pravatar.cc/150?img=11',
        rating: rating,
        comment: comment,
        images: images,
        createdAt: DateTime.now(),
        isVerified: true,
      );
    } catch (e) {
      throw Exception('فشل إضافة التقييم: $e');
    }
  }
  
  // ==================== رفع الملفات ====================
  
  // رفع صورة
  Future<String> uploadImage(String filePath, {String folder = 'images'}) async {
    try {
      await Future.delayed(Duration(seconds: 2));
      return 'https://picsum.photos/400/400?random=${DateTime.now().millisecondsSinceEpoch}';
    } catch (e) {
      throw Exception('فشل رفع الصورة: $e');
    }
  }
  
  // رفع عدة صور
  Future<List<String>> uploadMultipleImages(List<String> filePaths) async {
    try {
      await Future.delayed(Duration(seconds: 3));
      return filePaths.map((_) => 
        'https://picsum.photos/400/400?random=${DateTime.now().millisecondsSinceEpoch + filePaths.indexOf(_)}'
      ).toList();
    } catch (e) {
      throw Exception('فشل رفع الصور: $e');
    }
  }
  
  // حذف ملف
  Future<void> deleteFile(String fileUrl) async {
    try {
      await Future.delayed(Duration(milliseconds: 500));
    } catch (e) {
      throw Exception('فشل حذف الملف: $e');
    }
  }
}
