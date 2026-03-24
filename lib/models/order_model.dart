import 'package:hive/hive.dart';

part 'order_model.g.dart';

@HiveType(typeId: 7)
class OrderModel extends HiveObject {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String buyerId;
  
  @HiveField(2)
  final String sellerId;
  
  @HiveField(3)
  final List<OrderItemModel> items;
  
  @HiveField(4)
  final double subtotal;
  
  @HiveField(5)
  final double shippingCost;
  
  @HiveField(6)
  final double tax;
  
  @HiveField(7)
  final double total;
  
  @HiveField(8)
  final String status;
  
  @HiveField(9)
  final String paymentMethod;
  
  @HiveField(10)
  final String paymentStatus;
  
  @HiveField(11)
  final String shippingAddress;
  
  @HiveField(12)
  final String? trackingNumber;
  
  @HiveField(13)
  final String? notes;
  
  @HiveField(14)
  final DateTime createdAt;
  
  @HiveField(15)
  final DateTime? confirmedAt;
  
  @HiveField(16)
  final DateTime? shippedAt;
  
  @HiveField(17)
  final DateTime? deliveredAt;
  
  @HiveField(18)
  final DateTime? cancelledAt;
  
  @HiveField(19)
  final String? cancellationReason;
  
  @HiveField(20)
  final double? discount;
  
  @HiveField(21)
  final String? couponCode;

  OrderModel({
    required this.id,
    required this.buyerId,
    required this.sellerId,
    required this.items,
    required this.subtotal,
    required this.shippingCost,
    required this.tax,
    required this.total,
    required this.status,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.shippingAddress,
    this.trackingNumber,
    this.notes,
    required this.createdAt,
    this.confirmedAt,
    this.shippedAt,
    this.deliveredAt,
    this.cancelledAt,
    this.cancellationReason,
    this.discount,
    this.couponCode,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      buyerId: json['buyer_id'] ?? '',
      sellerId: json['seller_id'] ?? '',
      items: (json['items'] as List?)
          ?.map((e) => OrderItemModel.fromJson(e))
          .toList() ?? [],
      subtotal: (json['subtotal'] ?? 0.0).toDouble(),
      shippingCost: (json['shipping_cost'] ?? 0.0).toDouble(),
      tax: (json['tax'] ?? 0.0).toDouble(),
      total: (json['total'] ?? 0.0).toDouble(),
      status: json['status'] ?? 'pending',
      paymentMethod: json['payment_method'] ?? '',
      paymentStatus: json['payment_status'] ?? 'pending',
      shippingAddress: json['shipping_address'] ?? '',
      trackingNumber: json['tracking_number'],
      notes: json['notes'],
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
      confirmedAt: json['confirmed_at'] != null 
          ? DateTime.parse(json['confirmed_at']) 
          : null,
      shippedAt: json['shipped_at'] != null 
          ? DateTime.parse(json['shipped_at']) 
          : null,
      deliveredAt: json['delivered_at'] != null 
          ? DateTime.parse(json['delivered_at']) 
          : null,
      cancelledAt: json['cancelled_at'] != null 
          ? DateTime.parse(json['cancelled_at']) 
          : null,
      cancellationReason: json['cancellation_reason'],
      discount: json['discount']?.toDouble(),
      couponCode: json['coupon_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'buyer_id': buyerId,
      'seller_id': sellerId,
      'items': items.map((e) => e.toJson()).toList(),
      'subtotal': subtotal,
      'shipping_cost': shippingCost,
      'tax': tax,
      'total': total,
      'status': status,
      'payment_method': paymentMethod,
      'payment_status': paymentStatus,
      'shipping_address': shippingAddress,
      'tracking_number': trackingNumber,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'confirmed_at': confirmedAt?.toIso8601String(),
      'shipped_at': shippedAt?.toIso8601String(),
      'delivered_at': deliveredAt?.toIso8601String(),
      'cancelled_at': cancelledAt?.toIso8601String(),
      'cancellation_reason': cancellationReason,
      'discount': discount,
      'coupon_code': couponCode,
    };
  }

  // بيانات وهمية
  static List<OrderModel> get dummyOrders => [
    OrderModel(
      id: 'ord_001',
      buyerId: 'user_001',
      sellerId: 'user_002',
      items: [
        OrderItemModel.dummyItems[0],
      ],
      subtotal: 450000,
      shippingCost: 5000,
      tax: 0,
      total: 455000,
      status: 'delivered',
      paymentMethod: 'wallet',
      paymentStatus: 'paid',
      shippingAddress: 'صنعاء - شارع تعز',
      trackingNumber: 'TRK123456',
      createdAt: DateTime.now().subtract(Duration(days: 10)),
      confirmedAt: DateTime.now().subtract(Duration(days: 9)),
      shippedAt: DateTime.now().subtract(Duration(days: 7)),
      deliveredAt: DateTime.now().subtract(Duration(days: 5)),
    ),
    OrderModel(
      id: 'ord_002',
      buyerId: 'user_001',
      sellerId: 'user_003',
      items: [
        OrderItemModel.dummyItems[1],
      ],
      subtotal: 380000,
      shippingCost: 0,
      tax: 0,
      total: 380000,
      status: 'shipped',
      paymentMethod: 'wallet',
      paymentStatus: 'paid',
      shippingAddress: 'صنعاء - شارع الستين',
      trackingNumber: 'TRK789012',
      createdAt: DateTime.now().subtract(Duration(days: 5)),
      confirmedAt: DateTime.now().subtract(Duration(days: 4)),
      shippedAt: DateTime.now().subtract(Duration(days: 2)),
    ),
    OrderModel(
      id: 'ord_003',
      buyerId: 'user_001',
      sellerId: 'user_002',
      items: [
        OrderItemModel.dummyItems[2],
      ],
      subtotal: 180000,
      shippingCost: 3000,
      tax: 0,
      total: 183000,
      status: 'pending',
      paymentMethod: 'cod',
      paymentStatus: 'pending',
      shippingAddress: 'صنعاء - حدة',
      createdAt: DateTime.now().subtract(Duration(hours: 5)),
    ),
    OrderModel(
      id: 'ord_004',
      buyerId: 'user_001',
      sellerId: 'user_003',
      items: [
        OrderItemModel.dummyItems[3],
      ],
      subtotal: 65000,
      shippingCost: 2000,
      tax: 0,
      total: 67000,
      status: 'cancelled',
      paymentMethod: 'wallet',
      paymentStatus: 'refunded',
      shippingAddress: 'صنعاء - العاصمة',
      createdAt: DateTime.now().subtract(Duration(days: 15)),
      cancelledAt: DateTime.now().subtract(Duration(days: 14)),
      cancellationReason: 'تغيير رأي',
    ),
  ];
}

@HiveType(typeId: 8)
class OrderItemModel extends HiveObject {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String productId;
  
  @HiveField(2)
  final String productName;
  
  @HiveField(3)
  final String? productImage;
  
  @HiveField(4)
  final double price;
  
  @HiveField(5)
  final int quantity;
  
  @HiveField(6)
  final double total;
  
  @HiveField(7)
  final String? sellerId;
  
  @HiveField(8)
  final String? sellerName;

  OrderItemModel({
    required this.id,
    required this.productId,
    required this.productName,
    this.productImage,
    required this.price,
    required this.quantity,
    required this.total,
    this.sellerId,
    this.sellerName,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'] ?? '',
      productId: json['product_id'] ?? '',
      productName: json['product_name'] ?? '',
      productImage: json['product_image'],
      price: (json['price'] ?? 0.0).toDouble(),
      quantity: json['quantity'] ?? 1,
      total: (json['total'] ?? 0.0).toDouble(),
      sellerId: json['seller_id'],
      sellerName: json['seller_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'product_name': productName,
      'product_image': productImage,
      'price': price,
      'quantity': quantity,
      'total': total,
      'seller_id': sellerId,
      'seller_name': sellerName,
    };
  }

  // بيانات وهمية
  static List<OrderItemModel> get dummyItems => [
    OrderItemModel(
      id: 'item_001',
      productId: 'p001',
      productName: 'آيفون 15 برو ماكس 256GB',
      productImage: 'https://picsum.photos/400/400?random=1',
      price: 450000,
      quantity: 1,
      total: 450000,
      sellerId: 'user_002',
      sellerName: 'فاطمة عبدالله',
    ),
    OrderItemModel(
      id: 'item_002',
      productId: 'p002',
      productName: 'سامسونج جالكسي S24 الترا',
      productImage: 'https://picsum.photos/400/400?random=3',
      price: 380000,
      quantity: 1,
      total: 380000,
      sellerId: 'user_003',
      sellerName: 'خالد سعيد',
    ),
    OrderItemModel(
      id: 'item_003',
      productId: 'p003',
      productName: 'شاومي 14 برو',
      productImage: 'https://picsum.photos/400/400?random=4',
      price: 180000,
      quantity: 1,
      total: 180000,
      sellerId: 'user_002',
      sellerName: 'فاطمة عبدالله',
    ),
    OrderItemModel(
      id: 'item_004',
      productId: 'p025',
      productName: 'نظارة شمسية راي بان',
      productImage: 'https://picsum.photos/400/400?random=26',
      price: 65000,
      quantity: 1,
      total: 65000,
      sellerId: 'user_003',
      sellerName: 'خالد سعيد',
    ),
  ];
}
