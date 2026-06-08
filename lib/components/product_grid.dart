import 'package:flutter/material.dart';
import '../models/product_model.dart';
import 'product_card.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;
  final Function(Product)? onProductTap;

  const ProductGrid({
    super.key,
    required this.products,
    this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(
        child: Text('No products available'),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(
          product: products[index],
          onTap: () => onProductTap?.call(products[index]),
        );
      },
    );
  }
}
