import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokoto/components/sub_components/temp_comp.dart';
import 'package:tokoto/models/category_model.dart';
import 'package:tokoto/providers/category_provider.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class AllProductPage extends StatefulWidget {
  const AllProductPage({
    super.key,});

  @override
  State<AllProductPage> createState() => _AllProductPageState();
}

class _AllProductPageState extends State<AllProductPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Padding(
        padding:  EdgeInsets.symmetric(horizontal:23.sw()),
        child: Text("Products", style: TextStyle(fontSize:4.sw()),),
      ),),
      body:Container(
        padding: EdgeInsets.symmetric(horizontal: 2.sw()),
        child: Consumer<CategoryProvider>(
        builder: (context, value, child) {
          // Flattening all products from different categories into a single list
          List<dynamic> allProductsList = [];
          value.allProducts.forEach((categoryName, products) {
            allProductsList.addAll(products.where((product) => product != null).cast<MyProduct>());
          });
        
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns in the grid
              childAspectRatio: 0.95, // Aspect ratio of each item
              // crossAxisSpacing: 10,
              // mainAxisSpacing: 10,
            ),
            itemCount: allProductsList.length,
            itemBuilder: (context, index) {
              final product = allProductsList[index];
              return TempComp(
                name: product.name,
                price: product.price,
                image_path: product.image_path,
              );
            },
          );
        },
            ),
      ));
  }
}