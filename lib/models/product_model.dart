class Product {
  final String id;
  final String title;
  final String image;
  final double price;
  final String description;

  Product({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    this.description = '',
  });
}
