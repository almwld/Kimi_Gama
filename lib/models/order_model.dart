class OrderItem {
  final String productId;
  final String productName;
  final int quantity;
  final double price;
  final String? imageUrl;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
    this.imageUrl,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['product_id'],
      productName: json['product_name'],
      quantity: json['quantity'],
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image_url'],
    );
  }
}

class OrderModel {
  final String id;
  final String userId;
  final double total;
  final String status;
  final String? shippingAddress;
  final String? paymentMethod;
  final DateTime createdAt;
  final List<OrderItem> items;
  final Map<String, dynamic>? seller;

  OrderModel({
    required this.id,
    required this.userId,
    required this.total,
    required this.status,
    this.shippingAddress,
    this.paymentMethod,
    required this.createdAt,
    this.items = const [],
    this.seller,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      userId: json['user_id'],
      total: (json['total'] as num).toDouble(),
      status: json['status'],
      shippingAddress: json['shipping_address'],
      paymentMethod: json['payment_method'],
      createdAt: DateTime.parse(json['created_at']),
      items: (json['items'] as List?)?.map((e) => OrderItem.fromJson(e)).toList() ?? [],
      seller: json['seller'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'total': total,
      'status': status,
      'shipping_address': shippingAddress,
      'payment_method': paymentMethod,
      'created_at': createdAt.toIso8601String(),
    };
  }

  OrderModel copyWith({
    String? id,
    String? userId,
    double? total,
    String? status,
    String? shippingAddress,
    String? paymentMethod,
    DateTime? createdAt,
    List<OrderItem>? items,
    Map<String, dynamic>? seller,
  }) {
    return OrderModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      total: total ?? this.total,
      status: status ?? this.status,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      createdAt: createdAt ?? this.createdAt,
      items: items ?? this.items,
      seller: seller ?? this.seller,
    );
  }
}
