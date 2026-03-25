import 'package:hive/hive.dart';


@HiveType(typeId: 3)
class WalletModel extends HiveObject {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String userId;
  
  @HiveField(2)
  final double yerBalance;
  
  @HiveField(3)
  final double sarBalance;
  
  @HiveField(4)
  final double usdBalance;
  
  @HiveField(5)
  final bool isActive;
  
  @HiveField(6)
  final DateTime createdAt;
  
  @HiveField(7)
  final DateTime? updatedAt;
  
  @HiveField(8)
  final double totalDeposits;
  
  @HiveField(9)
  final double totalWithdrawals;
  
  @HiveField(10)
  final int transactionCount;

  WalletModel({
    required this.id,
    required this.userId,
    this.yerBalance = 0.0,
    this.sarBalance = 0.0,
    this.usdBalance = 0.0,
    this.isActive = true,
    required this.createdAt,
    this.updatedAt,
    this.totalDeposits = 0.0,
    this.totalWithdrawals = 0.0,
    this.transactionCount = 0,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      yerBalance: (json['yer_balance'] ?? 0.0).toDouble(),
      sarBalance: (json['sar_balance'] ?? 0.0).toDouble(),
      usdBalance: (json['usd_balance'] ?? 0.0).toDouble(),
      isActive: json['is_active'] ?? true,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at']) 
          : null,
      totalDeposits: (json['total_deposits'] ?? 0.0).toDouble(),
      totalWithdrawals: (json['total_withdrawals'] ?? 0.0).toDouble(),
      transactionCount: json['transaction_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'yer_balance': yerBalance,
      'sar_balance': sarBalance,
      'usd_balance': usdBalance,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'total_deposits': totalDeposits,
      'total_withdrawals': totalWithdrawals,
      'transaction_count': transactionCount,
    };
  }

  WalletModel copyWith({
    String? id,
    String? userId,
    double? yerBalance,
    double? sarBalance,
    double? usdBalance,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? totalDeposits,
    double? totalWithdrawals,
    int? transactionCount,
  }) {
    return WalletModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      yerBalance: yerBalance ?? this.yerBalance,
      sarBalance: sarBalance ?? this.sarBalance,
      usdBalance: usdBalance ?? this.usdBalance,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      totalDeposits: totalDeposits ?? this.totalDeposits,
      totalWithdrawals: totalWithdrawals ?? this.totalWithdrawals,
      transactionCount: transactionCount ?? this.transactionCount,
    );
  }

  // الرصيد الإجمالي بالريال اليمني
  double get totalBalanceInYer {
    return yerBalance + (sarBalance * 66.67) + (usdBalance * 250);
  }

  // بيانات وهمية
  static WalletModel get dummyWallet => WalletModel(
    id: 'wallet_001',
    userId: 'user_001',
    yerBalance: 2500000,
    sarBalance: 5000,
    usdBalance: 1000,
    isActive: true,
    createdAt: DateTime.now().subtract(Duration(days: 365)),
    updatedAt: DateTime.now(),
    totalDeposits: 5000000,
    totalWithdrawals: 2000000,
    transactionCount: 156,
  );
}

@HiveType(typeId: 4)
class TransactionModel extends HiveObject {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String walletId;
  
  @HiveField(2)
  final String userId;
  
  @HiveField(3)
  final String type;
  
  @HiveField(4)
  final String status;
  
  @HiveField(5)
  final double amount;
  
  @HiveField(6)
  final String currency;
  
  @HiveField(7)
  final String? description;
  
  @HiveField(8)
  final String? recipientId;
  
  @HiveField(9)
  final String? recipientName;
  
  @HiveField(10)
  final String? paymentMethod;
  
  @HiveField(11)
  final String? referenceNumber;
  
  @HiveField(12)
  final DateTime createdAt;
  
  @HiveField(13)
  final DateTime? completedAt;
  
  @HiveField(14)
  final double? fee;
  
  @HiveField(15)
  final Map<String, dynamic>? metadata;

  TransactionModel({
    required this.id,
    required this.walletId,
    required this.userId,
    required this.type,
    required this.status,
    required this.amount,
    required this.currency,
    this.description,
    this.recipientId,
    this.recipientName,
    this.paymentMethod,
    this.referenceNumber,
    required this.createdAt,
    this.completedAt,
    this.fee,
    this.metadata,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] ?? '',
      walletId: json['wallet_id'] ?? '',
      userId: json['user_id'] ?? '',
      type: json['type'] ?? '',
      status: json['status'] ?? '',
      amount: (json['amount'] ?? 0.0).toDouble(),
      currency: json['currency'] ?? 'YER',
      description: json['description'],
      recipientId: json['recipient_id'],
      recipientName: json['recipient_name'],
      paymentMethod: json['payment_method'],
      referenceNumber: json['reference_number'],
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
      completedAt: json['completed_at'] != null 
          ? DateTime.parse(json['completed_at']) 
          : null,
      fee: json['fee']?.toDouble(),
      metadata: json['metadata'] != null 
          ? Map<String, dynamic>.from(json['metadata']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'wallet_id': walletId,
      'user_id': userId,
      'type': type,
      'status': status,
      'amount': amount,
      'currency': currency,
      'description': description,
      'recipient_id': recipientId,
      'recipient_name': recipientName,
      'payment_method': paymentMethod,
      'reference_number': referenceNumber,
      'created_at': createdAt.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
      'fee': fee,
      'metadata': metadata,
    };
  }

  // بيانات وهمية
  static List<TransactionModel> get dummyTransactions => [
    TransactionModel(
      id: 'txn_001',
      walletId: 'wallet_001',
      userId: 'user_001',
      type: 'deposit',
      status: 'completed',
      amount: 500000,
      currency: 'YER',
      description: 'إيداع عبر كريمي',
      paymentMethod: 'krem',
      referenceNumber: 'KRM123456',
      createdAt: DateTime.now().subtract(Duration(hours: 2)),
      completedAt: DateTime.now().subtract(Duration(hours: 1)),
    ),
    TransactionModel(
      id: 'txn_002',
      walletId: 'wallet_001',
      userId: 'user_001',
      type: 'payment',
      status: 'completed',
      amount: 150000,
      currency: 'YER',
      description: 'شراء منتج - آيفون 15',
      recipientId: 'user_002',
      recipientName: 'فاطمة عبدالله',
      createdAt: DateTime.now().subtract(Duration(days: 1)),
      completedAt: DateTime.now().subtract(Duration(days: 1)),
    ),
    TransactionModel(
      id: 'txn_003',
      walletId: 'wallet_001',
      userId: 'user_001',
      type: 'transfer',
      status: 'completed',
      amount: 100000,
      currency: 'YER',
      description: 'تحويل لصديق',
      recipientId: 'user_003',
      recipientName: 'خالد سعيد',
      createdAt: DateTime.now().subtract(Duration(days: 2)),
      completedAt: DateTime.now().subtract(Duration(days: 2)),
    ),
    TransactionModel(
      id: 'txn_004',
      walletId: 'wallet_001',
      userId: 'user_001',
      type: 'withdrawal',
      status: 'completed',
      amount: 200000,
      currency: 'YER',
      description: 'سحب نقدي',
      paymentMethod: 'cash',
      referenceNumber: 'WDR789012',
      createdAt: DateTime.now().subtract(Duration(days: 3)),
      completedAt: DateTime.now().subtract(Duration(days: 3)),
      fee: 1000,
    ),
    TransactionModel(
      id: 'txn_005',
      walletId: 'wallet_001',
      userId: 'user_001',
      type: 'refund',
      status: 'completed',
      amount: 50000,
      currency: 'YER',
      description: 'استرداد مبلغ',
      createdAt: DateTime.now().subtract(Duration(days: 5)),
      completedAt: DateTime.now().subtract(Duration(days: 5)),
    ),
  ];
}
