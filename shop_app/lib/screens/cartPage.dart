import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart.dart';
import 'package:shop_app/provider/cartProvider.dart';
import 'package:shop_app/widgets/cart_item_button.dart';
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
            Widget image = Container(
              padding: const EdgeInsets.all(8),
              height: 120,
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: cartItems[index].image,
                ),
              ),
            );
            Widget totalPricrPerItem = Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "₹ ${cartItems[index].price * cartItems[index].quantity}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            );
            Widget itemTitle = Container(
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
                  // padding: const EdgeInsets.all(4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      generateRow(itemTitle, image, 3, 2),
                      generateRow(totalPricrPerItem,
                          QuantityControl(cartItem: cartItems[index]), 3, 2),
                      generateRow(
                        CartItemButton(
                            title: 'Save for later', function: () {}),
                        CartItemButton(title: 'Remove', function: () {}),
                        1,
                        1,
                      ),
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

  Row generateRow(Widget item1, Widget item2, int? flex1, int? flex2) {
    return Row(
      children: [
        Flexible(
          child: item1,
          flex: flex1!,
          fit: FlexFit.tight,
        ),
        Flexible(
          child: item2,
          flex: flex2!,
        )
      ],
    );
  }
}
