import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokoto/components/sub_components/popular_product_subtile.dart';
import 'package:tokoto/models/category_model.dart';
import 'package:tokoto/providers/category_provider.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class PopularProductsTile extends StatelessWidget {

   PopularProductsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, value, child) {
        // Flattening all products from different categories into a single list
        List<dynamic> allProductsList = [];
        value.allProducts.forEach((categoryName, products) {
          allProductsList.addAll(products.where((product) => product != null).cast<MyProduct>());
        });
        return Container(
              width: 200.sw(),
              height: 27.sh(),
              child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              
              itemBuilder: (BuildContext context, int index) {
                final product = allProductsList[index];
                
                return PopularProductSubtile(name:product.name, price:product.price, image_path:product.image_path,);
              },
              ),
            
    );});
  }
}