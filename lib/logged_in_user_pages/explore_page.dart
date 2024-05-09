import 'package:flutter/material.dart';
import 'package:tokoto/components/custom_icon.dart';
import 'package:tokoto/components/custom_search_bar.dart';
import 'package:tokoto/components/explore_tile_2.dart';
import 'package:tokoto/components/explore_tile_purple.dart';
import 'package:tokoto/components/popular_product_tile.dart';
import 'package:tokoto/components/special_for_you_tile.dart';
import 'package:tokoto/logged_in_user_pages/cart_page.dart';
import 'package:tokoto/logged_in_user_pages/popular_product_page.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading:false,toolbarHeight: 2.sh(), ),
      body: ListView(
        children: [
          Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    child: CustomSearchBar(),
                  ),

                  // CART
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const CartPage();
                            }));
                    },
                    child: const CustomIcon(icon: Icon(Icons.shopping_cart_outlined), padding: 4,)
                    ),

                  SizedBox(
                    width: 2.sw(),
                  ),
                  
                  // NOTIFICATION
                  const CustomIcon(icon: Icon(Icons.notifications_outlined),padding:4),

                  SizedBox(
                    width: 2.sw(),
                  ),
                ],
              ),

              // Tile 1
              ExploreTilePurple(),

              // Tile 2
              ExploreTile2(),

              // Special
              Padding(
                padding:  EdgeInsets.only(left:2.sh(), right:3.sh(), top:2.sh(), bottom:1.sh()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Special for you", style: TextStyle(fontSize: 2.sh(), fontWeight: FontWeight.bold),),
                    Text("See More", style: TextStyle(color:Colors.grey),)
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left:3.sw()),
                child: Special4UTile(),
              ),
              

              // Popular Products
              Padding(
                padding:  EdgeInsets.only(left:2.sh(), right:3.sh(), top:2.sh(), bottom:1.sh()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Popular Products", style: TextStyle(fontSize: 2.sh(), fontWeight: FontWeight.bold),),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const PopularProductPage();
                            }));
                      },
                      child: Text("See More", style: TextStyle(color:Colors.grey),)
                      )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left:3.sw()),
                child: PopularProductsTile(),
              )
            ],
          )
        ],
      ),
    );
  }
}
