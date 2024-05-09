import 'package:flutter/material.dart';
import 'package:tokoto/components/popular_product_subtile.dart';

class PopularProductsTile extends StatelessWidget {
  const PopularProductsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          PopularProductSubtile(name: "Wireless Controller for PS4", price: "\$64.99", image_path: "assets/game.jpg",),
           PopularProductSubtile(name: "Nike Sport White - Man Pant", price: "\$50.5", image_path: "assets/pants.jpg",),
          PopularProductSubtile(name: "Gloves XC Omega - Polygon", price: "\$36.55", image_path: "assets/gloves.jpg",),
          PopularProductSubtile(name: "Wireless Controller for PS4", price: "\$64.99", image_path: "assets/game.jpg",),
           PopularProductSubtile(name: "Nike Sport White - Man Pant", price: "\$50.5", image_path: "assets/pants.jpg",),
          PopularProductSubtile(name: "Gloves XC Omega - Polygon", price: "\$36.55", image_path: "assets/gloves.jpg",),
        ],
      ),
    );
  }
}