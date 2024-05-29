import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokoto/components/custom_search_bar.dart';
import 'package:tokoto/components/tiles/categories_tile.dart';
import 'package:tokoto/components/custom_icon.dart';
import 'package:tokoto/components/tiles/explore_tile_2.dart';
import 'package:tokoto/components/tiles/explore_tile_purple.dart';
import 'package:tokoto/components/tiles/popular_product_tile.dart';
import 'package:tokoto/components/tiles/special_for_you_tile.dart';
import 'package:tokoto/controllers/product_controller.dart';
import 'package:tokoto/pages/logged_in_user_pages/cart_page.dart';
import 'package:tokoto/pages/logged_in_user_pages/category_page.dart';
import 'package:tokoto/pages/logged_in_user_pages/all_product_page.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class ExplorePage extends StatelessWidget {
  final ProductController categoryController = Get.put(ProductController());
  ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 2.sh(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomSearchBar(),
                  ),
                  // CART
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return CartPage();
                      }));
                    },
                    child: const CustomIcon(
                      icon: Icon(Icons.shopping_cart_outlined),
                      padding: 4,
                    ),
                  ),
                  SizedBox(width: 2.sw()),
                  // NOTIFICATION
                  const CustomIcon(
                    icon: Icon(Icons.notifications_outlined),
                    padding: 4,
                  ),
                  SizedBox(width: 2.sw()),
                ],
              ),
              // Tile 1
              const ExploreTilePurple(),
              // Tile 2
              const ExploreTile2(),
              // Special
              Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 2.sh(), right: 3.sh(), top: 2.sh(), bottom: 1.sh()),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Special for you",
                            style: TextStyle(fontSize: 2.sh(), fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "See More",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                     Padding(
                  padding: EdgeInsets.only(left: 3.sw()),
                  child: Special4UTile(),
                ),
                // Popular Products
                Padding(
                  padding: EdgeInsets.only(left: 2.sh(), right: 3.sh(), top: 2.sh(), bottom: 1.sh()),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Popular Products",
                        style: TextStyle(fontSize: 2.sh(), fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return AllProductPage();
                            }));
                          },
                          child: const Text(
                            "See More",
                            style: TextStyle(color: Colors.grey),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3.sw()),
                  child: PopularProductsTile(),
                ),
                // Categories
                Padding(
                  padding: EdgeInsets.only(left: 2.sh(), right: 3.sh(), bottom: 1.sh()),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Categories",
                        style: TextStyle(fontSize: 2.sh(), fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () {
                    return Column(
                // TabBar
                      children: [
                        TabBar(
                          labelColor: Theme.of(context).primaryColor,
                          indicatorColor: Theme.of(context).primaryColor,
                          controller: categoryController.tabController,
                          isScrollable: true,
                          tabs: categoryController.categories.map((category) {
                            return Tab(text: category["name"]);
                          }).toList(),
                        ),
                        // TabBarView with FutureBuilder
                        Container(
                          width: 100.sw(),
                          height: 22.sh(),
                          child: Padding(
                            padding: EdgeInsets.all(2.sh()),
                            child: TabBarView(
                              controller: categoryController.tabController,
                              children: categoryController.categories.map((category) {
                                return GestureDetector(
                                  onTap: () {
                                    print("whts wrong");
                                    print(category);
                                    String cat = category["name"];
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return CategoryPage(category: cat);
                                    }));
                                  },
                                  child: CatTile(
                                    category: category['name'], // Access document name
                                    image_path: category['bannerImage'], // Access 
                                    brands: "",
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                            
                  ],
                )
             ],
              )
          ),
        
      );
        
  }
}
