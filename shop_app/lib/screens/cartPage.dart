import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemBuilder: (context, index) {
            print(cartItems[index]);
            return Card(
              child: Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 4,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 120,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Center(
                              child: Text(
                                cartItems[index].title,
                                style: GoogleFonts.poppins(),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "₹ ${cartItems[index].price * cartItems[index].quantity}",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            height: 120,
                            child: Center(
                              child: CachedNetworkImage(
                                imageUrl: cartItems[index].image,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Card(
                                    child: Container(
                                  width: 30,
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text('-',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center),
                                )),
                              ),
                              Text('Qty: ${cartItems[index].quantity}'),
                              InkWell(
                                onTap: () {},
                                child: Card(
                                    child: Container(
                                  width: 30,
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text('+',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                )),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: cartItems.length,
        ),
      ),
    );
  }
}
