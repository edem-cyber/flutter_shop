import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/provider/productProvider.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Product> product = Provider.of<ProductProvider>(context).products;
    return Container();
  }
}
