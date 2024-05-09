import 'package:flutter/material.dart';
import 'package:tokoto/components/popular_product_subtile.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class PopularProductPage extends StatefulWidget {
  const PopularProductPage({super.key});

  @override
  State<PopularProductPage> createState() => _PopularProductPageState();
}

class _PopularProductPageState extends State<PopularProductPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Padding(
        padding:  EdgeInsets.symmetric(horizontal:23.sw()),
        child: Text("Products", style: TextStyle(fontSize:4.sw()),),
      ),),
      body: GridView.count(
        childAspectRatio: 0.81,
        padding: EdgeInsets.symmetric(horizontal:3.sw(), vertical:2.sh()),
        crossAxisCount: 2,
        children: [
           PopularProductSubtile(name: "Wireless Controller for PS4", price: "\$64.99", image_path: "assets/game.jpg",),
           PopularProductSubtile(name: "Nike Sport White - Man Pant", price: "\$50.5", image_path: "assets/pants.jpg",),
          PopularProductSubtile(name: "Gloves XC Omega - Polygon", price: "\$36.55", image_path: "assets/gloves.jpg",),
          PopularProductSubtile(name: "Logitech Head", price: "\$20.2", image_path: "assets/headphones.jpg",),
          
           PopularProductSubtile(name: "Wireless Controller for PS4", price: "\$64.99", image_path: "assets/game.jpg",),
           PopularProductSubtile(name: "Nike Sport White - Man Pant", price: "\$50.5", image_path: "assets/pants.jpg",),
          PopularProductSubtile(name: "Gloves XC Omega - Polygon", price: "\$36.55", image_path: "assets/gloves.jpg",),
          PopularProductSubtile(name: "Logitech Head", price: "\$20.2", image_path: "assets/headphones.jpg",),
        ]
        )
    );
  }
}