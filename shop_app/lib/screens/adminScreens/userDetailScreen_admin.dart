import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/models/user.dart' as user;
import 'package:shop_app/provider/productProvider.dart';
import 'package:shop_app/provider/userProvider.dart';

class UserDetailScreenAdmin extends StatelessWidget {
  static const routeName = "/user-detail-admin";
  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context)?.settings.arguments as String;
    user.User _user = Provider.of<User>(context).findById(userId);
    List<Product> product =
        Provider.of<ProductProvider>(context).findBySeller(userId);
    print(product.length);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text(_user.email),
            Text(_user.firstname),
            Text(_user.lastname),
            ...product.map((e) {
              return Text(e.name);
            }).toList()
          ],
        ),
      ),
    );
  }
}
