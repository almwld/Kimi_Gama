import 'package:flutter/material.dart';
class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  const ProductCard({super.key, required this.product});
  @override
  Widget build(BuildContext context) => Card(child: ListTile(title: Text(product['title'] ?? 'منتج')));
}
