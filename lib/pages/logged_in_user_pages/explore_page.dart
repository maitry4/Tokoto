import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokoto/components/custom_search_bar.dart';
import 'package:tokoto/components/sub_components/temp_comp.dart';
import 'package:tokoto/components/tiles/categories_tile.dart';
import 'package:tokoto/components/custom_icon.dart';
import 'package:tokoto/components/tiles/explore_tile_2.dart';
import 'package:tokoto/components/tiles/explore_tile_purple.dart';
import 'package:tokoto/components/tiles/popular_product_tile.dart';
import 'package:tokoto/components/tiles/special_for_you_tile.dart';
import 'package:tokoto/controllers/product_controller.dart';
import 'package:tokoto/controllers/search_controller.dart';
import 'package:tokoto/models/category_model.dart';
import 'package:tokoto/pages/logged_in_user_pages/cart_page.dart';
import 'package:tokoto/pages/logged_in_user_pages/category_page.dart';
import 'package:tokoto/pages/logged_in_user_pages/all_product_page.dart';
import 'package:tokoto/responsive/responsive_extension.dart';
import 'package:tokoto/responsive/size_config.dart';

class ExplorePage extends StatelessWidget {
  final ProductController categoryController = Get.put(ProductController());
  final MySearchController searchController = Get.put(MySearchController());
  ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isSearching = false.obs;
    bool some = false; // Rx variable to track search state

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
                  child: CustomSearchBar(
                    onChanged: (value) {
                      // Flattening all products from different categories into a single list
                      List<MyProduct> allProductsList = [];
                      categoryController.allProducts
                          .forEach((categoryName, products) {
                        allProductsList.addAll(products
                            .where((product) => product != null)
                            .cast<MyProduct>());
                      });
                      // List of names of the products.
                      List<String> productNames = [];
                      for (int i = 0; i < allProductsList.length; i++) {
                        productNames.add(allProductsList[i].name);
                      }
                      // Call search method from the search controller
                      searchController.search(value, productNames);
                      // Update search state
                      isSearching.value = value.isNotEmpty;
                      print(searchController.searchResults);
                    },
                  ),
                ),
                // CART
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
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
            Obx(() {
              if(!categoryController.allProducts.isEmpty){

              
              if (isSearching.toString() == "false") {
                return Column(
                  children: [
                    // Tile 1
                    ExploreTilePurple(),
                    const ExploreTile2(),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 2.sh(),
                              right: 3.sh(),
                              top: 2.sh(),
                              bottom: 1.sh()),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Special for you".tr,
                                style: TextStyle(
                                    fontSize: 2.sh(),
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "See More".tr,
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
                              left: 2.sh(),
                              right: 3.sh(),
                              top: 2.sh(),
                              bottom: 1.sh()),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Popular Products".tr,
                                style: TextStyle(
                                    fontSize: 2.sh(),
                                    fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return AllProductPage();
                                    }));
                                  },
                                  child:  Text(
                                    "See More".tr,
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
                                "Categories".tr,
                                style: TextStyle(
                                    fontSize: 2.sh(),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          // TabBar
                          children: [
                            TabBar(
                              labelColor: Theme.of(context).primaryColor,
                              indicatorColor: Theme.of(context).primaryColor,
                              controller: categoryController.tabController,
                              isScrollable: true,
                              tabs:
                                  categoryController.categories.map((category) {
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
                                  children: categoryController.categories
                                      .map((category) {
                                    return GestureDetector(
                                      onTap: () {
                                        print("whts wrong");
                                        print(category);
                                        String cat = category["name"];
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return CategoryPage(category: cat);
                                        }));
                                      },
                                      child: CatTile(
                                        category: category[
                                            'name'], // Access document name
                                        image_path:
                                            category['bannerImage'], // Access
                                        brands: "",
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                );
              } else {
                return Padding(
                  padding:  EdgeInsets.symmetric(horizontal:2.sw(), vertical:2.sh()),
                  child: Container(
                    width: 90.sw(),
                    height: 100.sh(),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns in the grid
                        childAspectRatio: 0.81, // Aspect ratio of each item
                      ),
                      itemCount: searchController.searchResults.length,
                      itemBuilder: (context, index) {
                        // Flattening all products from different categories into a single list
                        List<MyProduct> allProductsList = [];
                        categoryController.allProducts
                            .forEach((categoryName, products) {
                          allProductsList.addAll(products
                              .where((product) => product != null)
                              .cast<MyProduct>());
                        });
                        MyProduct? product = MyProduct.findProductByName(
                            allProductsList, searchController.searchResults[index]);
                        // final product = allProductsList[index];
                        return TempComp(
                          is_discounted: false,
                          name: product!.name,
                          price: product.price,
                          image_path: product.image_path,
                        );
                      },
                    ),
                  ),
                );
              }
            } else{
              return Text("Loading data");
            }
            }),
          ],
        ),
        // Tile 2
        // Special
      ),
    );
  }
}
