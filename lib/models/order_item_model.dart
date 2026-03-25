class OrderItemModel {
  final String id;
  final String productId;
  final String productName;
  final String? productImage;
  final double price;
  final int quantity;
  final double total;
  final String? sellerId;
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
      id: json['id'] as String,
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      productImage: json['productImage'] as String?,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
      total: (json['total'] as num).toDouble(),
      sellerId: json['sellerId'] as String?,
      sellerName: json['sellerName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'price': price,
      'quantity': quantity,
      'total': total,
      'sellerId': sellerId,
      'sellerName': sellerName,
    };
  }

  OrderItemModel copyWith({
    String? id,
    String? productId,
    String? productName,
    String? productImage,
    double? price,
    int? quantity,
    double? total,
    String? sellerId,
    String? sellerName,
  }) {
    return OrderItemModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      total: total ?? this.total,
      sellerId: sellerId ?? this.sellerId,
      sellerName: sellerName ?? this.sellerName,
    );
  }
}
