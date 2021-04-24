import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/provider/productProvider.dart';
import 'package:shop_app/screens/mainPage.dart';
import 'package:shop_app/widgets/product_grid_item.dart';

class ProductGrid extends StatelessWidget {
  final ScreenSize size;
  final Size screenSize;
  ProductGrid(this.size, this.screenSize);
  @override
  Widget build(BuildContext context) {
    List<Product> product = Provider.of<ProductProvider>(context).products;
    return CupertinoScrollbar(
      thickness: 4,
      radius: Radius.circular(20),
      child: StaggeredGridView.countBuilder(
        crossAxisCount: size == ScreenSize.small
            ? 2
            : size == ScreenSize.extraLarge
                ? 4
                : 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: product.length,
        itemBuilder: (context, index) {
          return ProductGridItem(
            product: product[index],
            screenSize: size,
          );
        },
        staggeredTileBuilder: (int i) => new StaggeredTile.fit(1),
      ),
    );
  }
}
