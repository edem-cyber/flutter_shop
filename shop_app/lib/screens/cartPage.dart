import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart.dart';
import 'package:shop_app/provider/cartProvider.dart';
import 'package:shop_app/widgets/quantity_control.dart';

class CartPage extends StatelessWidget {
  static const routeName = "/cart-page";
  @override
  Widget build(BuildContext context) {
    var list = Provider.of<Cart>(context).items;
    var cartItems = list.values.toList();
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
            var image = Container(
              padding: const EdgeInsets.all(8),
              height: 120,
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: cartItems[index].image,
                ),
              ),
            );
            var totalPricrPerItem = Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "₹ ${cartItems[index].price * cartItems[index].quantity}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            );
            var itemTitle = Container(
              height: 120,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: Text(
                  cartItems[index].title,
                  style: GoogleFonts.poppins(),
                  textAlign: TextAlign.start,
                ),
              ),
            );
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Card(
                child: Container(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: itemTitle,
                            flex: 3,
                          ),
                          Flexible(
                            child: image,
                            flex: 2,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: totalPricrPerItem,
                            flex: 3,
                            fit: FlexFit.tight,
                          ),
                          Flexible(
                            child: QuantityControl(cartItem: cartItems[index]),
                            flex: 2,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.favorite),
                              label: Text('Save for later'),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.favorite),
                                  Text('Remove')
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Icon(Icons.delete), Text('Remove')],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
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
