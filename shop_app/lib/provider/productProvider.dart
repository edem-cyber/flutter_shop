import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shop_app/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

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

  Future<void> addProduct(Map<String, String> m) async {
    final Uri url = Uri.http("fluttershop-backend.herokuapp.com", 'products');
    Map<String, String> headers = <String, String>{
      'Authorization': "Bearer $_authToken"
    };
    // print(m['image']);
    print(headers['Authorization']);
    print(_userId);
    var request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..fields['name'] = m['name']!
      ..fields['price'] = m['price']!
      ..fields['description'] = m['description']!
      ..fields['category'] = m['category']!
      ..fields['sellerId'] = _userId
      ..files.add(
        await http.MultipartFile.fromPath(
          'productImage',
          m['path']!,
          contentType: new MediaType('image', 'jpeg'),
        ),
      );
    print(request.fields);
    print(request.files[0].contentType);
    var response = await request.send();
    print(response.statusCode);
    print(response.reasonPhrase);
  }
}
