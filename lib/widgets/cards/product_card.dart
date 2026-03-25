import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback? onTap;
  
  const ProductCard({
    super.key, 
    required this.product,
    this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: ListTile(
          title: Text(product['title'] ?? 'منتج'),
          subtitle: Text('${product['price']} ر.ي'),
        ),
      ),
    );
  }
}
