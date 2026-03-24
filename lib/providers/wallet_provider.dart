import 'package:flutter/material.dart';
import 'package:flex_yemen/models/wallet_model.dart';
import 'package:flex_yemen/services/supabase_service.dart';
import 'package:flex_yemen/services/payment_service.dart';

class WalletProvider extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();
  final PaymentService _paymentService = PaymentService();

  WalletModel? _wallet;
  List<TransactionModel> _transactions = [];
  bool _isLoading = false;
  String? _error;
  bool _hasMoreTransactions = true;
  int _transactionsPage = 1;

  // Getters
  WalletModel? get wallet => _wallet;
  List<TransactionModel> get transactions => _transactions;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasWallet => _wallet != null;
  double get yerBalance => _wallet?.yerBalance ?? 0.0;
  double get sarBalance => _wallet?.sarBalance ?? 0.0;
  double get usdBalance => _wallet?.usdBalance ?? 0.0;
  double get totalBalanceInYer => _wallet?.totalBalanceInYer ?? 0.0;

  // الحصول على المحفظة
  Future<void> getWallet() async {
    _setLoading(true);
    _clearError();

    try {
      _wallet = await _supabaseService.getWallet();
      notifyListeners();
    } catch (e) {
      _error = 'فشل جلب المحفظة: ${e.toString()}';
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // الحصول على المعاملات
  Future<void> getTransactions({bool refresh = false, String? type}) async {
    if (refresh) {
      _transactionsPage = 1;
      _hasMoreTransactions = true;
      _transactions = [];
    }

    if (!_hasMoreTransactions || _isLoading) return;

    _setLoading(true);
    _clearError();

    try {
      final newTransactions = await _supabaseService.getTransactions(
        type: type,
        page: _transactionsPage,
        limit: 20,
      );

      if (newTransactions.length < 20) {
        _hasMoreTransactions = false;
      }

      _transactions.addAll(newTransactions);
      _transactionsPage++;
      
      notifyListeners();
    } catch (e) {
      _error = 'فشل جلب المعاملات: ${e.toString()}';
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // إيداع
  Future<bool> deposit({
    required double amount,
    required String currency,
    required String paymentMethod,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      // معالجة الدفع أولاً
      final paymentResult = await _paymentService.depositToWallet(
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod,
      );

      if (!paymentResult.success) {
        _error = paymentResult.message;
        notifyListeners();
        return false;
      }

      // إنشاء المعاملة
      final transaction = await _supabaseService.deposit(
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod,
      );

      _transactions.insert(0, transaction);
      
      // تحديث الرصيد
      await getWallet();
      
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'فشل الإيداع: ${e.toString()}';
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // سحب
  Future<bool> withdraw({
    required double amount,
    required String currency,
    required String method,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      // التحقق من الرصيد
      double currentBalance;
      switch (currency) {
        case 'SAR':
          currentBalance = sarBalance;
          break;
        case 'USD':
          currentBalance = usdBalance;
          break;
        case 'YER':
        default:
          currentBalance = yerBalance;
      }

      if (currentBalance < amount) {
        _error = 'رصيد غير كافٍ';
        notifyListeners();
        return false;
      }

      // معالجة السحب
      final paymentResult = await _paymentService.withdrawFromWallet(
        amount: amount,
        currency: currency,
        withdrawalMethod: method,
      );

      if (!paymentResult.success) {
        _error = paymentResult.message;
        notifyListeners();
        return false;
      }

      // إنشاء المعاملة
      final transaction = await _supabaseService.withdraw(
        amount: amount,
        currency: currency,
        method: method,
      );

      _transactions.insert(0, transaction);
      
      // تحديث الرصيد
      await getWallet();
      
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'فشل السحب: ${e.toString()}';
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // تحويل
  Future<bool> transfer({
    required double amount,
    required String currency,
    required String recipientId,
    String? description,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      // التحقق من الرصيد
      double currentBalance;
      switch (currency) {
        case 'SAR':
          currentBalance = sarBalance;
          break;
        case 'USD':
          currentBalance = usdBalance;
          break;
        case 'YER':
        default:
          currentBalance = yerBalance;
      }

      if (currentBalance < amount) {
        _error = 'رصيد غير كافٍ';
        notifyListeners();
        return false;
      }

      // معالجة التحويل
      final paymentResult = await _paymentService.transferToUser(
        amount: amount,
        currency: currency,
        recipientId: recipientId,
        description: description,
      );

      if (!paymentResult.success) {
        _error = paymentResult.message;
        notifyListeners();
        return false;
      }

      // إنشاء المعاملة
      final transaction = await _supabaseService.transfer(
        amount: amount,
        currency: currency,
        recipientId: recipientId,
        description: description,
      );

      _transactions.insert(0, transaction);
      
      // تحديث الرصيد
      await getWallet();
      
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'فشل التحويل: ${e.toString()}';
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // دفع
  Future<bool> pay({
    required double amount,
    required String currency,
    required String paymentMethod,
    String? description,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      // التحقق من الرصيد إذا كان الدفع من المحفظة
      if (paymentMethod == 'wallet') {
        double currentBalance;
        switch (currency) {
          case 'SAR':
            currentBalance = sarBalance;
            break;
          case 'USD':
            currentBalance = usdBalance;
            break;
          case 'YER':
          default:
            currentBalance = yerBalance;
        }

        if (currentBalance < amount) {
          _error = 'رصيد غير كافٍ';
          notifyListeners();
          return false;
        }
      }

      // معالجة الدفع
      final paymentResult = await _paymentService.processPayment(
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod,
      );

      if (!paymentResult.success) {
        _error = paymentResult.message;
        notifyListeners();
        return false;
      }

      // تحديث الرصيد
      await getWallet();
      
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'فشل الدفع: ${e.toString()}';
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // دفع فاتورة
  Future<bool> payBill({
    required double amount,
    required String billType,
    required String billNumber,
    String? description,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final paymentResult = await _paymentService.payBill(
        amount: amount,
        billType: billType,
        billNumber: billNumber,
        description: description,
      );

      if (!paymentResult.success) {
        _error = paymentResult.message;
        notifyListeners();
        return false;
      }

      // تحديث الرصيد
      await getWallet();
      
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'فشل دفع الفاتورة: ${e.toString()}';
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // شحن رصيد
  Future<bool> rechargeBalance({
    required double amount,
    required String phoneNumber,
    required String operator,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final paymentResult = await _paymentService.rechargeBalance(
        amount: amount,
        phoneNumber: phoneNumber,
        operator: operator,
      );

      if (!paymentResult.success) {
        _error = paymentResult.message;
        notifyListeners();
        return false;
      }

      // تحديث الرصيد
      await getWallet();
      
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'فشل الشحن: ${e.toString()}';
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // شراء بطاقة هدايا
  Future<bool> purchaseGiftCard({
    required double amount,
    required String cardType,
    required String recipientEmail,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final paymentResult = await _paymentService.purchaseGiftCard(
        amount: amount,
        cardType: cardType,
        recipientEmail: recipientEmail,
      );

      if (!paymentResult.success) {
        _error = paymentResult.message;
        notifyListeners();
        return false;
      }

      // تحديث الرصيد
      await getWallet();
      
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'فشل الشراء: ${e.toString()}';
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
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
