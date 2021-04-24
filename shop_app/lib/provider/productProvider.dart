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
    final Uri url = Uri.http("fluttershop-backend.herokuapp.com", 'products');
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
          description: p['description'],
          image: p['productImage'],
        ),
      );
    });
    products = loadedProduct;
    notifyListeners();
    // responeData['products'].fore
  }

  Product findById(String id) {
    return products.firstWhere((product) => product.id == id);
  }
}
