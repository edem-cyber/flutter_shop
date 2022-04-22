import 'dart:ffi';

class Product {
  final String id;
  final String name;
  final int price;
  final String description;
  final String category;
  final String image;
  final String sellerId;
  final String sellerName;
  final int? dollarPrice;
  final int? discountPercent;
  final List<String>? assets;

  Product({
    this.discountPercent,
    this.dollarPrice,
    this.assets,
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.sellerId,
    this.sellerName = '',
  });
}
