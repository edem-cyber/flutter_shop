import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/screens/mainPage.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

class ProductGridItem extends StatefulWidget {
  const ProductGridItem({
    Key? key,
    required this.product,
    required this.screenSize,
  }) : super(key: key);

  final Product product;
  final ScreenSize screenSize;
  @override
  _ProductGridItemState createState() => _ProductGridItemState();
}

class _ProductGridItemState extends State<ProductGridItem> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    Image image = Image.network(
      widget.product.image,
      color: isHovering ? Colors.grey.shade300 : null,
      colorBlendMode: BlendMode.colorBurn,
    );
    Completer<ui.Image> completer = new Completer<ui.Image>();
    image.image
        .resolve(new ImageConfiguration())
        .addListener(ImageStreamListener((info, _) {
      print(info.image.width > info.image.height &&
          widget.screenSize == ScreenSize.small);
    }));
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
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
              arguments: widget.product.id);
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
            borderRadius: BorderRadius.circular(
                widget.screenSize == ScreenSize.small ||
                        widget.screenSize == ScreenSize.medium
                    ? 6
                    : 10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                        widget.screenSize == ScreenSize.small ||
                                widget.screenSize == ScreenSize.medium
                            ? 6
                            : 10),
                    child: Image.network(
                      widget.product.image,
                      color: isHovering ? Colors.grey.shade300 : null,
                      colorBlendMode: BlendMode.colorBurn,
                    ),
                  ),
                  if (widget.screenSize != ScreenSize.small)
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 300),
                      right: isHovering ? 0 : -100,
                      child: Container(
                        width: isHovering ? 100 : 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                height: 50,
                                width: 40,
                                child: Icon(
                                  Icons.favorite,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                height: 50,
                                width: 40,
                                child: Icon(
                                  Icons.add,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(left: 16, top: 4),
                child: Text(
                  widget.product.name,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 16, bottom: 4),
                child: Text(
                  '₹ ${widget.product.price.toString()}',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
