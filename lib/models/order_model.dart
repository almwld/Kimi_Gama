import 'package:flex_yemen/models/order_item_model.dart';

class OrderModel {
  final String id;
  final String buyerId;
  final String? sellerId;
  final List<OrderItemModel> items;
  final double subtotal;
  final double shippingCost;
  final double tax;
  final double total;
  final String status;
  final String paymentMethod;
  final String paymentStatus;
  final String shippingAddress;
  final String? notes;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? cancelledAt;
  final String? cancellationReason;

  OrderModel({
    required this.id,
    required this.buyerId,
    this.sellerId,
    required this.items,
    required this.subtotal,
    required this.shippingCost,
    required this.tax,
    required this.total,
    required this.status,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.shippingAddress,
    this.notes,
    required this.createdAt,
    this.updatedAt,
    this.cancelledAt,
    this.cancellationReason,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      buyerId: json['buyerId'] as String,
      sellerId: json['sellerId'] as String?,
      items: (json['items'] as List)
          .map((i) => OrderItemModel.fromJson(i))
          .toList(),
      subtotal: (json['subtotal'] as num).toDouble(),
      shippingCost: (json['shippingCost'] as num).toDouble(),
      tax: (json['tax'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      status: json['status'] as String,
      paymentMethod: json['paymentMethod'] as String,
      paymentStatus: json['paymentStatus'] as String,
      shippingAddress: json['shippingAddress'] as String,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      cancelledAt: json['cancelledAt'] != null
          ? DateTime.parse(json['cancelledAt'] as String)
          : null,
      cancellationReason: json['cancellationReason'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'buyerId': buyerId,
      'sellerId': sellerId,
      'items': items.map((i) => i.toJson()).toList(),
      'subtotal': subtotal,
      'shippingCost': shippingCost,
      'tax': tax,
      'total': total,
      'status': status,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'shippingAddress': shippingAddress,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'cancelledAt': cancelledAt?.toIso8601String(),
      'cancellationReason': cancellationReason,
    };
  }

  OrderModel copyWith({
    String? id,
    String? buyerId,
    String? sellerId,
    List<OrderItemModel>? items,
    double? subtotal,
    double? shippingCost,
    double? tax,
    double? total,
    String? status,
    String? paymentMethod,
    String? paymentStatus,
    String? shippingAddress,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? cancelledAt,
    String? cancellationReason,
  }) {
    return OrderModel(
      id: id ?? this.id,
      buyerId: buyerId ?? this.buyerId,
      sellerId: sellerId ?? this.sellerId,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      shippingCost: shippingCost ?? this.shippingCost,
      tax: tax ?? this.tax,
      total: total ?? this.total,
      status: status ?? this.status,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      cancelledAt: cancelledAt ?? this.cancelledAt,
      cancellationReason: cancellationReason ?? this.cancellationReason,
    );
  }
}
