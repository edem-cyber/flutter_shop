import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';

class ProductGridItem extends StatefulWidget {
  const ProductGridItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _ProductGridItemState createState() => _ProductGridItemState();
}

class _ProductGridItemState extends State<ProductGridItem> {
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHovering = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHovering = false;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: isHovering ? Colors.grey.shade200 : Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: isHovering ? 8 : 4,
              spreadRadius: isHovering ? 4 : 0,
              offset: Offset(4, 6),
              color: Colors.black38,
            )
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                widget.product.image,
                color: isHovering ? Colors.grey.shade300 : null,
                colorBlendMode: BlendMode.colorBurn,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.product.name),
                  Text('₹ ${widget.product.price.toString()}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
