import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/provider/cartProvider.dart';
import 'package:shop_app/widgets/cart_item.dart';

class CartPage extends StatelessWidget {
  static const routeName = "/cart-page";
  @override
  Widget build(BuildContext context) {
    var list = Provider.of<Cart>(context).items;
    var cartItems = list.values.toList();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Container(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...cartItems.map((cartItem) => GenCartItem(cartItem)).toList(),
                Text('Some addition info here'),
              ],
            ),
          )),
    );
  }
}
