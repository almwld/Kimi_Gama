import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flex_yemen/core/constants/app_constants.dart';

class Helpers {
  // تنسيق التاريخ
  static String formatDate(DateTime date, {String format = 'yyyy-MM-dd'}) {
    return DateFormat(format, 'ar').format(date);
  }
  
  static String formatDateTime(DateTime date) {
    return DateFormat('yyyy-MM-dd HH:mm', 'ar').format(date);
  }
  
  static String formatTime(DateTime date) {
    return DateFormat('HH:mm', 'ar').format(date);
  }
  
  static String formatRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 365) {
      return 'منذ ${difference.inDays ~/ 365} سنة';
    } else if (difference.inDays > 30) {
      return 'منذ ${difference.inDays ~/ 30} شهر';
    } else if (difference.inDays > 7) {
      return 'منذ ${difference.inDays ~/ 7} أسبوع';
    } else if (difference.inDays > 0) {
      return 'منذ ${difference.inDays} يوم';
    } else if (difference.inHours > 0) {
      return 'منذ ${difference.inHours} ساعة';
    } else if (difference.inMinutes > 0) {
      return 'منذ ${difference.inMinutes} دقيقة';
    } else {
      return 'الآن';
    }
  }
  
  // تنسيق الأرقام
  static String formatNumber(num number) {
    return NumberFormat('#,##0', 'ar').format(number);
  }
  
  static String formatDecimal(num number, {int decimalPlaces = 2}) {
    return NumberFormat('#,##0.${'0' * decimalPlaces}', 'ar').format(number);
  }
  
  // تنسيق الأسعار
  static String formatPrice(num price, {String currency = 'YER'}) {
    final currencyInfo = AppConstants.currencies.firstWhere(
      (c) => c['code'] == currency,
      orElse: () => AppConstants.currencies[0],
    );
    
    return '${formatNumber(price)} ${currencyInfo['symbol']}';
  }
  
  static String formatPriceWithCurrency(num price, String currencyCode) {
    return formatPrice(price, currency: currencyCode);
  }
  
  // تحويل العملات
  static double convertCurrency(double amount, String from, String to) {
    if (from == to) return amount;
    
    // تحويل إلى ريال يمني أولاً
    double amountInYer;
    switch (from) {
      case 'SAR':
        amountInYer = amount * AppConstants.sarToYer;
        break;
      case 'USD':
        amountInYer = amount * AppConstants.usdToYer;
        break;
      case 'YER':
      default:
        amountInYer = amount;
    }
    
    // تحويل من ريال يمني إلى العملة المطلوبة
    switch (to) {
      case 'SAR':
        return amountInYer * AppConstants.yerToSar;
      case 'USD':
        return amountInYer * AppColors.yerToUsd;
      case 'YER':
      default:
        return amountInYer;
    }
  }
  
  // تنسيق النسب المئوية
  static String formatPercentage(num value, {int decimalPlaces = 0}) {
    return '${formatDecimal(value, decimalPlaces: decimalPlaces)}%';
  }
  
  // اختصار النص
  static String truncateText(String text, int maxLength, {String suffix = '...'}) {
    if (text.length <= maxLength) return text;
    return text.substring(0, maxLength - suffix.length) + suffix;
  }
  
  // إخفاء جزء من النص
  static String maskText(String text, {int visibleStart = 3, int visibleEnd = 3, String mask = '*'}) {
    if (text.length <= visibleStart + visibleEnd) return text;
    
    final start = text.substring(0, visibleStart);
    final end = text.substring(text.length - visibleEnd);
    final maskedLength = text.length - visibleStart - visibleEnd;
    
    return start + mask * maskedLength + end;
  }
  
  // إخفاء رقم الهاتف
  static String maskPhoneNumber(String phone) {
    return maskText(phone, visibleStart: 4, visibleEnd: 2);
  }
  
  // إخفاء البريد الإلكتروني
  static String maskEmail(String email) {
    if (!email.contains('@')) return maskText(email);
    
    final parts = email.split('@');
    final username = maskText(parts[0], visibleStart: 2, visibleEnd: 1);
    final domain = parts[1];
    
    return '$username@$domain';
  }
  
  // توليد أحرف عشوائية
  static String generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    String result = '';
    for (int i = 0; i < length; i++) {
      result += chars[DateTime.now().millisecond % chars.length];
    }
    return result;
  }
  
  // التحقق من صحة البريد الإلكتروني
  static bool isValidEmail(String email) {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }
  
  // التحقق من صحة رقم الهاتف اليمني
  static bool isValidYemeniPhone(String phone) {
    final regex = RegExp(r'^((\+967|00967|0)?[137]\d{8})$');
    return regex.hasMatch(phone.replaceAll(' ', ''));
  }
  
  // تنظيف رقم الهاتف
  static String cleanPhoneNumber(String phone) {
    return phone.replaceAll(RegExp(r'[^\d+]'), '');
  }
  
  // تنسيق رقم الهاتف اليمني
  static String formatYemeniPhone(String phone) {
    final cleaned = cleanPhoneNumber(phone);
    
    if (cleaned.startsWith('+967')) {
      return cleaned;
    } else if (cleaned.startsWith('00967')) {
      return '+967${cleaned.substring(5)}';
    } else if (cleaned.startsWith('0')) {
      return '+967${cleaned.substring(1)}';
    } else {
      return '+967$cleaned';
    }
  }
  
  // الحصول على اسم المدينة
  static String getCityName(String cityId) {
    final city = AppConstants.yemeniCities.firstWhere(
      (c) => c['id'] == cityId,
      orElse: () => {'name': 'غير معروف'},
    );
    return city['name'] as String;
  }
  
  // الحصول على اسم الفئة
  static String getCategoryName(String categoryId) {
    final category = AppConstants.mainCategories.firstWhere(
      (c) => c['id'] == categoryId,
      orElse: () => {'name': 'غير معروف'},
    );
    return category['name'] as String;
  }
  
  // الحصول على حالة الطلب بالعربية
  static String getOrderStatusName(String status) {
    final statusNames = {
      'pending': 'قيد الانتظار',
      'confirmed': 'مؤكد',
      'processing': 'قيد المعالجة',
      'shipped': 'تم الشحن',
      'delivered': 'تم التوصيل',
      'cancelled': 'ملغي',
      'refunded': 'تم الاسترداد',
    };
    return statusNames[status] ?? 'غير معروف';
  }
  
  // الحصول على نوع المعاملة بالعربية
  static String getTransactionTypeName(String type) {
    final typeNames = {
      'deposit': 'إيداع',
      'withdrawal': 'سحب',
      'transfer': 'تحويل',
      'payment': 'دفع',
      'refund': 'استرداد',
      'commission': 'عمولة',
    };
    return typeNames[type] ?? 'غير معروف';
  }
  
  // الحصول على حالة المعاملة بالعربية
  static String getTransactionStatusName(String status) {
    final statusNames = {
      'pending': 'قيد الانتظار',
      'completed': 'مكتمل',
      'failed': 'فاشل',
      'cancelled': 'ملغي',
    };
    return statusNames[status] ?? 'غير معروف';
  }
  
  // إظهار SnackBar
  static void showSnackBar(
    BuildContext context, {
    required String message,
    bool isError = false,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(fontFamily: 'Changa'),
        ),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
  
  // إظهار dialog
  static Future<bool?> showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'تأكيد',
    String cancelText = 'إلغاء',
    bool isDangerous = false,
  }) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          title,
          style: TextStyle(fontFamily: 'Changa', fontWeight: FontWeight.bold),
        ),
        content: Text(
          message,
          style: TextStyle(fontFamily: 'Changa'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              cancelText,
              style: TextStyle(fontFamily: 'Changa'),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: isDangerous ? Colors.red : null,
            ),
            child: Text(
              confirmText,
              style: TextStyle(fontFamily: 'Changa'),
            ),
          ),
        ],
      ),
    );
  }
  
  // انتظار مع تأخير
  static Future<void> delay(int milliseconds) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
  }
  
  // التحقق من أن النص عربي
  static bool isArabic(String text) {
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');
    return arabicRegex.hasMatch(text);
  }
  
  // تحديد اتجاه النص
  static TextDirection getTextDirection(String text) {
    return isArabic(text) ? TextDirection.rtl : TextDirection.ltr;
  }
  
  // توليد ID فريد
  static String generateId() {
    return '${DateTime.now().millisecondsSinceEpoch}_${generateRandomString(8)}';
  }
  
  // مقارنة التواريخ
  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }
  
  // الحصول على بداية اليوم
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
  
  // الحصول على نهاية اليوم
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59);
  }
  
  // تنسيق حجم الملف
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
  
  // الحصول على امتداد الملف
  static String getFileExtension(String fileName) {
    return fileName.split('.').last.toLowerCase();
  }
  
  // التحقق من نوع الملف
  static bool isImageFile(String fileName) {
    final ext = getFileExtension(fileName);
    return AppConstants.allowedImageExtensions.contains(ext);
  }
  
  static bool isVideoFile(String fileName) {
    final ext = getFileExtension(fileName);
    return AppConstants.allowedVideoExtensions.contains(ext);
  }
}
