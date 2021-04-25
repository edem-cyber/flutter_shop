import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hover_effect/hover_effect.dart';

class ProductImageHover extends StatelessWidget {
  static const routeName = "/product-image";
  @override
  Widget build(BuildContext context) {
    final imageUrl = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5,
              maxWidth: MediaQuery.of(context).size.width * 0.9),
          color: Colors.white,
          child: HoverCard(
            depthColor: Colors.white,
            builder: (context, isHovered) {
              return Hero(
                tag: imageUrl,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.contain,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
