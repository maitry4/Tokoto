import 'package:flutter/material.dart';
import 'package:tokoto/components/sub_components/popular_product_subtile.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(title: Padding(
        padding:  EdgeInsets.symmetric(horizontal:30.sw()),
        child: Text("Favorites"),
      ), automaticallyImplyLeading:false,),
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