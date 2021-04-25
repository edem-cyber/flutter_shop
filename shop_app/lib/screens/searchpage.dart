import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/provider/productProvider.dart';

class SearchPage extends StatefulWidget {
  static const routeName = "/search";

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Product> product = [];
  @override
  void initState() {
    product = Provider.of<ProductProvider>(context, listen: false).products;
    super.initState();
  }

  search(String query) {
    if (query == "") {
      product = Provider.of<ProductProvider>(context, listen: false).products;
    } else {
      product = product.where((element) {
        return element.name.toLowerCase().startsWith(query) == true;
      }).toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
          ),
          cursorColor: Colors.white,
          onChanged: (value) {
            search(value);
          },
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => Container(
          padding: const EdgeInsets.all(8.0),
          decoration:
              BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
          child: ListTile(
            leading: CachedNetworkImage(
              imageUrl: product[index].image,
              height: 60,
              width: 60,
            ),
            title: Text(product[index].name),
          ),
        ),
        itemCount: product.length,
      ),
    );
  }
}
