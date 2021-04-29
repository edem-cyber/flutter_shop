import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import 'package:shop_app/provider/cartProvider.dart';
import 'package:shop_app/provider/productProvider.dart';
import 'package:shop_app/screens/cartPage.dart';
import 'package:shop_app/screens/product_hower_image.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProduct = Provider.of<ProductProvider>(
      context,
      listen: false,
    ).findById(productId);
    List<String> _des = loadedProduct.description.split("  ");
    List<Widget> des = _des.map((element) {
      return element.trim() == ""
          ? SizedBox()
          : Text(
              "\u2022  $element",
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.subtitle2,
            );
    }).toList();
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(ProductImageHover.routeName,
                      arguments: loadedProduct.image);
                },
                child: Container(
                  constraints: BoxConstraints(
                      minHeight: 200,
                      maxHeight: 500,
                      // minWidth: ,
                      maxWidth: 400),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Hero(
                      tag: productId,
                      child: CachedNetworkImage(
                        imageUrl: loadedProduct.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                loadedProduct.name,
                style: GoogleFonts.poppins(
                    fontSize: 24, fontWeight: FontWeight.w600),
              ),
              Text('${loadedProduct.price}',
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Seller - ##TODO',
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.blue)),
              SizedBox(
                height: 16,
              ),
              Text('Features',
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              ...des,
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orange),
              ),
              onPressed: () {
                Provider.of<Cart>(context, listen: false).addItem(
                  loadedProduct.id,
                  loadedProduct.price,
                  loadedProduct.name,
                  loadedProduct.image,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Product added to cart!'),
                    action: SnackBarAction(
                      label: 'Go to Cart',
                      onPressed: () {
                        Navigator.of(context).pushNamed(CartPage.routeName);
                      },
                    ),
                  ),
                );
              },
              child: Container(
                height: 60,
                child: Center(child: Text('Add to cart')),
              ),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              onPressed: () {},
              child: Container(
                height: 60,
                child: Center(child: Text('Buy')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
