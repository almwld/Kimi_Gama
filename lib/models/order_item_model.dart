class OrderItemModel {
  final String id;
  final String productId;
  final String productName;
  final int quantity;
  final double price;
  final double total;

  OrderItemModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
  }) : total = price * quantity;

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'] as String,
      productId: json['product_id'] as String,
      productName: json['product_name'] as String,
      quantity: json['quantity'] as int,
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'product_name': productName,
      'quantity': quantity,
      'price': price,
    };
  }
}
