import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokoto/components/sub_components/temp_comp.dart';
import 'package:tokoto/components/tiles/explore_tile_purple.dart';
import 'package:tokoto/controllers/product_controller.dart';
import 'package:tokoto/models/category_model.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class FlashDealPage extends StatelessWidget {
  final ProductController categoryController = Get.put(ProductController());
   FlashDealPage({super.key,});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Padding(
        padding:  EdgeInsets.symmetric(horizontal:20.sw()),
        child: Text("Grab The Deals".tr, style: TextStyle(fontSize:4.sw()),),
      ),),
      body:Container(
        padding: EdgeInsets.symmetric(horizontal: 2.sw()),
        child: Obx(
        () {
          // Flattening all products from different categories into a single list
          List<dynamic> allProductsList = [];
          categoryController.allProducts.forEach((categoryName, products) {
            allProductsList.addAll(products.where((product) => product != null).cast<MyProduct>());
          });
          List discounted_products = [];
          for(int i = 0; i < allProductsList.length; i++) {
            if(allProductsList[i].discount_percent != "0"){
              discounted_products.add(allProductsList[i]);
            }
          }
          if(discounted_products.length>0){
            
          return Padding(
            padding:  EdgeInsets.symmetric(vertical: 0.sh()),
            child: Column(
              children: [
                ExploreTilePurple(color:Color.fromARGB(255, 252, 88, 29), text1:"Grab Crazy Deals!!", text2:"Heavy Discounts!!"),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns in the grid
                      childAspectRatio: 0.79, // Aspect ratio of each item
                    ),
                    itemCount: discounted_products.length,
                    itemBuilder: (context, index) {
                      final product = discounted_products[index];
                      if(product.discount_percent != "0"){
                        return TempComp(
                          is_discounted: true,
                          discount_percent: product.discount_percent,
                          name: product.name,
                          price: product.price,
                          image_path: product.image_path,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        } else{
          return Text("No Deals currently");
        }
        },
            ),
      ));
  }
}