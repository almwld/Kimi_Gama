import 'package:flutter/material.dart';
import 'package:flex_yemen/theme/app_theme.dart';

class ColorConstants {
  // الوصول إلى الألوان من AppColors
  static Color get goldPrimary => AppColors.goldPrimary;
  static Color get goldLight => AppColors.goldLight;
  static Color get goldDark => AppColors.goldDark;
  static Color get goldAccent => AppColors.goldAccent;
  static Color get error => AppColors.error;
  static Color get success => AppColors.success;
  static Color get warning => AppColors.warning;
  static Color get info => AppColors.info;
  
  // تدرجات ذهبية
  static LinearGradient get goldGradient => LinearGradient(
    colors: [AppColors.goldPrimary, AppColors.goldLight, AppColors.goldAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static LinearGradient get goldGradientVertical => LinearGradient(
    colors: [AppColors.goldPrimary, AppColors.goldDark],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  static LinearGradient get goldGradientHorizontal => LinearGradient(
    colors: [AppColors.goldLight, AppColors.goldPrimary, AppColors.goldDark],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  
  // تدرجات البطاقات
  static LinearGradient get cardGradientLight => LinearGradient(
    colors: [Color(0xFFF8F9FA), Color(0xFFFFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static LinearGradient get cardGradientDark => LinearGradient(
    colors: [Color(0xFF2C2C2C), Color(0xFF1E1E1E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // تدرجات الحالات
  static LinearGradient get successGradient => LinearGradient(
    colors: [Color(0xFF2ECC71), Color(0xFF27AE60)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static LinearGradient get errorGradient => LinearGradient(
    colors: [Color(0xFFE74C3C), Color(0xFFC0392B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static LinearGradient get warningGradient => LinearGradient(
    colors: [Color(0xFFF39C12), Color(0xFFE67E22)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static LinearGradient get infoGradient => LinearGradient(
    colors: [Color(0xFF3498DB), Color(0xFF2980B9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // تدرجات المحفظة
  static LinearGradient get walletYerGradient => LinearGradient(
    colors: [Color(0xFFD4AF37), Color(0xFFB8860B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static LinearGradient get walletSarGradient => LinearGradient(
    colors: [Color(0xFF006C35), Color(0xFF004D26)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static LinearGradient get walletUsdGradient => LinearGradient(
    colors: [Color(0xFF1E3A8A), Color(0xFF0F1F4D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // ظلال
  static List<BoxShadow> get lightShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 10,
      offset: Offset(0, 4),
    ),
  ];
  
  static List<BoxShadow> get mediumShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 20,
      offset: Offset(0, 8),
    ),
  ];
  
  static List<BoxShadow> get heavyShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      blurRadius: 30,
      offset: Offset(0, 12),
    ),
  ];
  
  static List<BoxShadow> get goldShadow => [
    BoxShadow(
      color: AppColors.goldPrimary.withOpacity(0.3),
      blurRadius: 20,
      offset: Offset(0, 8),
    ),
  ];
  
  // ألوان الفئات
  static final Map<String, Color> categoryColors = {
    'electronics': Color(0xFF3498DB),
    'vehicles': Color(0xFFE74C3C),
    'real_estate': Color(0xFF2ECC71),
    'fashion': Color(0xFF9B59B6),
    'furniture': Color(0xFFE67E22),
    'jobs': Color(0xFF1ABC9C),
    'services': Color(0xFFF39C12),
    'sports': Color(0xFF34495E),
    'books': Color(0xFF795548),
    'pets': Color(0xFFFF9800),
    'food': Color(0xFFFF5722),
    'health': Color(0xFF00BCD4),
  };
  
  // الحصول على لون الفئة
  static Color getCategoryColor(String categoryId) {
    return categoryColors[categoryId] ?? AppColors.goldPrimary;
  }
  
  // ألوان حالات الطلب
  static final Map<String, Color> orderStatusColors = {
    'pending': Color(0xFFF39C12),
    'confirmed': Color(0xFF3498DB),
    'processing': Color(0xFF9B59B6),
    'shipped': Color(0xFF1ABC9C),
    'delivered': Color(0xFF2ECC71),
    'cancelled': Color(0xFFE74C3C),
    'refunded': Color(0xFF95A5A6),
  };
  
  static Color getOrderStatusColor(String status) {
    return orderStatusColors[status] ?? AppColors.goldPrimary;
  }
  
  // ألوان حالات المعاملات
  static final Map<String, Color> transactionStatusColors = {
    'pending': Color(0xFFF39C12),
    'completed': Color(0xFF2ECC71),
    'failed': Color(0xFFE74C3C),
    'cancelled': Color(0xFF95A5A6),
  };
  
  static Color getTransactionStatusColor(String status) {
    return transactionStatusColors[status] ?? AppColors.goldPrimary;
  }
  
  // ألوان أنواع المعاملات
  static final Map<String, Color> transactionTypeColors = {
    'deposit': Color(0xFF2ECC71),
    'withdrawal': Color(0xFFE74C3C),
    'transfer': Color(0xFF3498DB),
    'payment': Color(0xFF9B59B6),
    'refund': Color(0xFF1ABC9C),
    'commission': Color(0xFFF39C12),
  };
  
  static Color getTransactionTypeColor(String type) {
    return transactionTypeColors[type] ?? AppColors.goldPrimary;
  }
}
