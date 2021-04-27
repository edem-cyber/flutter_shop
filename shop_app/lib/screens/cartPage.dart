import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart.dart';
import 'package:shop_app/provider/cartProvider.dart';

class CartPage extends StatelessWidget {
  static const routeName = "/cart-page";
  @override
  Widget build(BuildContext context) {
    var list = Provider.of<Cart>(context).items;
    var cartItems = list.values.toList();
    print(list);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          print(cartItems[index]);
          return Card(
            child: ListTile(
              title: Text("${cartItems[index].title}"),
              subtitle: Text(
                  'Total: ₹${cartItems[index].quantity * cartItems[index].price}'),
              trailing: Text('${cartItems[index].quantity} x'),
            ),
          );
        },
        itemCount: cartItems.length,
      ),
    );
  }
}
