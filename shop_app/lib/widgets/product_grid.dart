import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/provider/productProvider.dart';
import 'package:shop_app/widgets/product_grid_item.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Product> product = Provider.of<ProductProvider>(context).products;
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 12,
        itemCount: product.length,
        itemBuilder: (context, index) {
          return ProductGridItem(product: product[index]);
        },
        staggeredTileBuilder: (int i) => new StaggeredTile.fit(1),
      ),
    );
  }
}
