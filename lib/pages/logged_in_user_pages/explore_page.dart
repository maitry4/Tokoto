import 'package:flutter/material.dart';
import 'package:tokoto/components/tiles/categories_tile.dart';
import 'package:tokoto/components/custom_icon.dart';
import 'package:tokoto/components/custom_search_bar.dart';
import 'package:tokoto/components/tiles/explore_tile_2.dart';
import 'package:tokoto/components/tiles/explore_tile_purple.dart';
import 'package:tokoto/components/tiles/popular_product_tile.dart';
import 'package:tokoto/components/tiles/special_for_you_tile.dart';
import 'package:tokoto/pages/logged_in_user_pages/cart_page.dart';
import 'package:tokoto/pages/logged_in_user_pages/category_page.dart';
import 'package:tokoto/pages/logged_in_user_pages/popular_product_page.dart';
import 'package:tokoto/responsive/responsive_extension.dart';
import 'package:tokoto/services/database_services.dart';

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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 2.sh(),
      ),
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
              ExploreTilePurple(),

              // Tile 2
              ExploreTile2(),

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
                    Text(
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
                            return const PopularProductPage();
                          }));
                        },
                        child: Text(
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
                    left: 2.sh(), right: 3.sh(), top: 2.sh(), bottom: 1.sh()),
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
                    tabs: [
                      Tab(text: "Clothes"),
                      Tab(text: "Food"),
                      Tab(text: "Accessories"),
                    ]),
              ),

             // TabBarView with FutureBuilder
        FutureBuilder<List<Map<String, dynamic>>>(
          future: DataBaseService().fetchDocuments(collection: "Categories"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else {
              List<Map<String, dynamic>> categories = snapshot.data!;
              // TabController _tabController = TabController(length: categories.length, vsync: this);
              return Container(
                width: 100.sw(),
                height: 22.sh(),
                child: Padding(
                  padding: EdgeInsets.all(2.sh()),
                  child: TabBarView(
                    controller: _tabController,
                    children: categories.map((category) {
                      return GestureDetector(
                        onTap: () {
                          String cat =category["name"];
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CategoryPage(category: cat,);
                            }));
                          },
                        child: CatTile(
                          category: category['name'], // Access document name
                          image_path: category['bannerImage'], // Access Banner_Image field value
                          brands: "",
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            }
          },
        ),
        
        ],
          
          )
        ],
      ),
    );
  }
}
