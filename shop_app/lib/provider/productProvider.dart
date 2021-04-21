import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shop_app/models/product.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  List<Product> products = [];
  final String _authToken;
  final String _userId;

  ProductProvider(this._authToken, this._userId, this.products);

  Future<void> getProducts() async {
    final Uri url = Uri.http("192.168.0.195:3000", 'products');
    final response = await http.get(url);
    final responeData = json.decode(response.body);
    final productData = responeData['products'] as List<dynamic>;
    final List<Product> loadedProduct = [];
    productData.forEach((p) {
      loadedProduct.add(
        Product(
          id: p['id'],
          name: p['name'],
          price: p['price'],
          seller: p['seller'],
          description: p['description'],
          image: p['image'],
        ),
      );
    });
    products = loadedProduct;
    notifyListeners();
    // responeData['products'].fore
  }
}
