import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/provider/productProvider.dart';

class OrderPageItem extends StatelessWidget {
  final List<dynamic> _items;
  final List<dynamic> _q;
  final DateTime dateTime;
  final String id;
  OrderPageItem(this._items, this._q, this.dateTime, this.id);
  @override
  Widget build(BuildContext context) {
    List<Product> products =
        Provider.of<ProductProvider>(context, listen: false)
            .getItemOfProduct(_items);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Card(
        elevation: 16,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order ID - #${id.toUpperCase()}',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                DateFormat.yMMMEd().format(dateTime),
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              ...products.map((e) {
                int index = _items.indexWhere((element) => element == e.id);
                int quantity = _q[index];
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        width: 1,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white54
                            : Colors.black54,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: CachedNetworkImage(
                              imageUrl: e.image,
                              height: 130,
                            )),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        flex: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              e.name,
                              maxLines: 2,
                              style: GoogleFonts.poppins(fontSize: 14),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '$quantity x ${e.price} = ₹${quantity * e.price}',
                                  style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
