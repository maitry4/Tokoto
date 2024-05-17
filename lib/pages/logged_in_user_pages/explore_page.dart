import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokoto/components/tiles/categories_tile.dart';
import 'package:tokoto/components/custom_icon.dart';
import 'package:tokoto/components/custom_search_bar.dart';
import 'package:tokoto/components/tiles/explore_tile_2.dart';
import 'package:tokoto/components/tiles/explore_tile_purple.dart';
import 'package:tokoto/components/tiles/popular_product_tile.dart';
import 'package:tokoto/components/tiles/special_for_you_tile.dart';
import 'package:tokoto/pages/logged_in_user_pages/cart_page.dart';
import 'package:tokoto/pages/logged_in_user_pages/category_page.dart';
import 'package:tokoto/pages/logged_in_user_pages/all_product_page.dart';
import 'package:tokoto/providers/category_provider.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    return Consumer<CategoryProvider>(
      builder:(context, value, child) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 2.sh(),
        ),
        body: 
            SingleChildScrollView(
              child: Column(
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
                          child: const CustomIcon(
                            icon: Icon(Icons.shopping_cart_outlined),
                            padding: 4,
                          )),
                    
                      SizedBox(
                        width: 2.sw(),
                      ),
                    
                      // NOTIFICATION
                      const CustomIcon(
                          icon: Icon(Icons.notifications_outlined), padding: 4),
                    
                      SizedBox(
                        width: 2.sw(),
                      ),
                    ],
                  ),
                    
                  // Tile 1
                  const ExploreTilePurple(),
                    
                  // Tile 2
                  const ExploreTile2(),
                    
                  // Special
                  Padding(
                    padding: EdgeInsets.only(
                        left: 2.sh(), right: 3.sh(), top: 2.sh(), bottom: 1.sh()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Special for you",
                          style: TextStyle(
                              fontSize: 2.sh(), fontWeight: FontWeight.bold),
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
                    child: const Special4UTile(),
                  ),
                    
                  // Popular Products
                  Padding(
                    padding: EdgeInsets.only(
                        left: 2.sh(), right: 3.sh(), top: 2.sh(), bottom: 1.sh()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Popular Products",
                          style: TextStyle(
                              fontSize: 2.sh(), fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const AllProductPage();
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
                    padding: EdgeInsets.only(
                        left: 2.sh(), right: 3.sh(), bottom: 1.sh()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Categories",
                          style: TextStyle(
                              fontSize: 2.sh(), fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  // TabBar
                  Container(
                    child: TabBar(
                        labelColor: Theme.of(context).primaryColor,
                        indicatorColor: Theme.of(context).primaryColor,
                        controller: _tabController,
                        isScrollable: true,
                        tabs:value.categories.map((category){
                          return Tab(text: category["name"]);
                        }).toList(),),
                  ),
                    
                  // TabBarView with FutureBuilder
                  Container(
                          width: 100.sw(),
                          height: 22.sh(),
                          child: Padding(
                            padding: EdgeInsets.all(2.sh()),
                            child: TabBarView(
                              controller: _tabController,
                              children: value.categories.map((category) {
                                return GestureDetector(
                                  onTap: () {
                                    print("whts wrong");
                                    print(category);
                                    String cat = category["name"];
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return CategoryPage(
                                        category: cat,
                                      );
                                    }));
                                  },
                                  child: CatTile(
                                    category:
                                        category['name'], // Access document name
                                    image_path: category[
                                        'bannerImage'], // Access Banner_Image field value
                                    brands: "",
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                     
                ],
              ),
            )
          
      ),
    );
  }
}
