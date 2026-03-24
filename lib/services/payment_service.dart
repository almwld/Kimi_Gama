import 'package:flex_yemen/models/wallet_model.dart';

class PaymentService {
  static final PaymentService _instance = PaymentService._internal();
  factory PaymentService() => _instance;
  PaymentService._internal();

  // قائمة طرق الدفع المتاحة
  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'id': 'wallet',
      'name': 'المحفظة الإلكترونية',
      'icon': 'account_balance_wallet',
      'description': 'الدفع من رصيد محفظتك',
      'isActive': true,
    },
    {
      'id': 'krem',
      'name': 'كريمي',
      'icon': 'payment',
      'description': 'الدفع عبر كريمي',
      'isActive': true,
    },
    {
      'id': 'amantel',
      'name': 'أمان تل',
      'icon': 'phone_android',
      'description': 'الدفع عبر أمان تل',
      'isActive': true,
    },
    {
      'id': 'cash',
      'name': 'الدفع عند الاستلام',
      'icon': 'money',
      'description': 'ادفع نقداً عند استلام طلبك',
      'isActive': true,
    },
    {
      'id': 'bank_transfer',
      'name': 'تحويل بنكي',
      'icon': 'account_balance',
      'description': 'الدفع عبر التحويل البنكي',
      'isActive': true,
    },
  ];

  // الحصول على طرق الدفع
  List<Map<String, dynamic>> getPaymentMethods() {
    return _paymentMethods.where((m) => m['isActive']).toList();
  }

  // الحصول على طريقة دفع محددة
  Map<String, dynamic>? getPaymentMethod(String id) {
    try {
      return _paymentMethods.firstWhere((m) => m['id'] == id);
    } catch (e) {
      return null;
    }
  }

  // معالجة الدفع
  Future<PaymentResult> processPayment({
    required double amount,
    required String currency,
    required String paymentMethod,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      // محاكاة معالجة الدفع
      await Future.delayed(Duration(seconds: 2));

      // نجاح الدفع (محاكاة)
      final isSuccess = DateTime.now().millisecond % 10 != 0; // 90% نجاح

      if (isSuccess) {
        return PaymentResult(
          success: true,
          transactionId: 'TXN${DateTime.now().millisecondsSinceEpoch}',
          message: 'تم الدفع بنجاح',
          amount: amount,
          currency: currency,
          paymentMethod: paymentMethod,
          timestamp: DateTime.now(),
        );
      } else {
        return PaymentResult(
          success: false,
          message: 'فشل معالجة الدفع، يرجى المحاولة مرة أخرى',
          amount: amount,
          currency: currency,
          paymentMethod: paymentMethod,
          timestamp: DateTime.now(),
        );
      }
    } catch (e) {
      return PaymentResult(
        success: false,
        message: 'حدث خطأ: $e',
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod,
        timestamp: DateTime.now(),
      );
    }
  }

  // التحقق من حالة الدفع
  Future<PaymentStatus> checkPaymentStatus(String transactionId) async {
    try {
      await Future.delayed(Duration(seconds: 1));
      
      // محاكاة - دائماً مكتمل
      return PaymentStatus.completed;
    } catch (e) {
      return PaymentStatus.failed;
    }
  }

  // استرداد المبلغ
  Future<PaymentResult> refundPayment({
    required String originalTransactionId,
    required double amount,
    String? reason,
  }) async {
    try {
      await Future.delayed(Duration(seconds: 2));

      return PaymentResult(
        success: true,
        transactionId: 'REF${DateTime.now().millisecondsSinceEpoch}',
        message: 'تم الاسترداد بنجاح',
        amount: amount,
        currency: 'YER',
        paymentMethod: 'refund',
        timestamp: DateTime.now(),
      );
    } catch (e) {
      return PaymentResult(
        success: false,
        message: 'فشل الاسترداد: $e',
        amount: amount,
        currency: 'YER',
        paymentMethod: 'refund',
        timestamp: DateTime.now(),
      );
    }
  }

  // إيداع في المحفظة
  Future<PaymentResult> depositToWallet({
    required double amount,
    required String currency,
    required String paymentMethod,
  }) async {
    return processPayment(
      amount: amount,
      currency: currency,
      paymentMethod: paymentMethod,
      metadata: {'type': 'deposit'},
    );
  }

  // سحب من المحفظة
  Future<PaymentResult> withdrawFromWallet({
    required double amount,
    required String currency,
    required String withdrawalMethod,
  }) async {
    try {
      await Future.delayed(Duration(seconds: 2));

      return PaymentResult(
        success: true,
        transactionId: 'WDR${DateTime.now().millisecondsSinceEpoch}',
        message: 'تم طلب السحب بنجاح',
        amount: amount,
        currency: currency,
        paymentMethod: withdrawalMethod,
        timestamp: DateTime.now(),
      );
    } catch (e) {
      return PaymentResult(
        success: false,
        message: 'فشل السحب: $e',
        amount: amount,
        currency: currency,
        paymentMethod: withdrawalMethod,
        timestamp: DateTime.now(),
      );
    }
  }

  // تحويل إلى مستخدم آخر
  Future<PaymentResult> transferToUser({
    required double amount,
    required String currency,
    required String recipientId,
    String? description,
  }) async {
    try {
      await Future.delayed(Duration(seconds: 2));

      return PaymentResult(
        success: true,
        transactionId: 'TRF${DateTime.now().millisecondsSinceEpoch}',
        message: 'تم التحويل بنجاح',
        amount: amount,
        currency: currency,
        paymentMethod: 'transfer',
        timestamp: DateTime.now(),
      );
    } catch (e) {
      return PaymentResult(
        success: false,
        message: 'فشل التحويل: $e',
        amount: amount,
        currency: currency,
        paymentMethod: 'transfer',
        timestamp: DateTime.now(),
      );
    }
  }

  // دفع فاتورة
  Future<PaymentResult> payBill({
    required double amount,
    required String billType,
    required String billNumber,
    String? description,
  }) async {
    try {
      await Future.delayed(Duration(seconds: 2));

      return PaymentResult(
        success: true,
        transactionId: 'BILL${DateTime.now().millisecondsSinceEpoch}',
        message: 'تم دفع الفاتورة بنجاح',
        amount: amount,
        currency: 'YER',
        paymentMethod: 'bill_payment',
        timestamp: DateTime.now(),
      );
    } catch (e) {
      return PaymentResult(
        success: false,
        message: 'فشل دفع الفاتورة: $e',
        amount: amount,
        currency: 'YER',
        paymentMethod: 'bill_payment',
        timestamp: DateTime.now(),
      );
    }
  }

  // شحن رصيد
  Future<PaymentResult> rechargeBalance({
    required double amount,
    required String phoneNumber,
    required String operator,
  }) async {
    try {
      await Future.delayed(Duration(seconds: 2));

      return PaymentResult(
        success: true,
        transactionId: 'RCH${DateTime.now().millisecondsSinceEpoch}',
        message: 'تم الشحن بنجاح',
        amount: amount,
        currency: 'YER',
        paymentMethod: 'recharge',
        timestamp: DateTime.now(),
      );
    } catch (e) {
      return PaymentResult(
        success: false,
        message: 'فشل الشحن: $e',
        amount: amount,
        currency: 'YER',
        paymentMethod: 'recharge',
        timestamp: DateTime.now(),
      );
    }
  }

  // شراء بطاقة هدايا
  Future<PaymentResult> purchaseGiftCard({
    required double amount,
    required String cardType,
    required String recipientEmail,
  }) async {
    try {
      await Future.delayed(Duration(seconds: 2));

      return PaymentResult(
        success: true,
        transactionId: 'GC${DateTime.now().millisecondsSinceEpoch}',
        message: 'تم شراء البطاقة بنجاح',
        amount: amount,
        currency: 'USD',
        paymentMethod: 'gift_card',
        timestamp: DateTime.now(),
      );
    } catch (e) {
      return PaymentResult(
        success: false,
        message: 'فشل الشراء: $e',
        amount: amount,
        currency: 'USD',
        paymentMethod: 'gift_card',
        timestamp: DateTime.now(),
      );
    }
  }
}

// نتيجة الدفع
class PaymentResult {
  final bool success;
  final String? transactionId;
  final String message;
  final double amount;
  final String currency;
  final String paymentMethod;
  final DateTime timestamp;
  final Map<String, dynamic>? metadata;

  PaymentResult({
    required this.success,
    this.transactionId,
    required this.message,
    required this.amount,
    required this.currency,
    required this.paymentMethod,
    required this.timestamp,
    this.metadata,
  });
}

// حالة الدفع
enum PaymentStatus {
  pending,
  processing,
  completed,
  failed,
  cancelled,
  refunded,
}

// أنواع الفواتير
class BillType {
  static const String electricity = 'electricity';
  static const String water = 'water';
  static const String internet = 'internet';
  static const String phone = 'phone';
  static const String gas = 'gas';
  static const String tv = 'tv';
  static const String government = 'government';
  static const String university = 'university';
}

// أنواع بطاقات الهدايا
class GiftCardType {
  static const String amazon = 'amazon';
  static const String googlePlay = 'google_play';
  static const String appStore = 'app_store';
  static const String steam = 'steam';
  static const String playStation = 'playstation';
  static const String xbox = 'xbox';
  static const String netflix = 'netflix';
  static const String spotify = 'spotify';
}

// مشغلي الهاتف
class PhoneOperator {
  static const String sabafon = 'sabafon';
  static const String yemenMobile = 'yemen_mobile';
  static const String you = 'you';
  static const String y = 'y';
}
