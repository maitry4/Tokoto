import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokoto/controllers/product_controller.dart';
import 'package:tokoto/responsive/responsive_extension.dart';
import 'package:tokoto/components/sub_components/temp_comp.dart';

class CategoryPage extends StatelessWidget {
  final String category;
   CategoryPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    // Retrieve the CategoryController instance
    final ProductController categoryController = Get.put(ProductController());
    // Fetch products for the category
    categoryController.getProducts(category);

    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.sw()),
            child: Text(category),
          ),
        ),
        body: Obx(
        () {
          

          return GridView.builder(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.87,
            ),
            itemCount: categoryController.keys.length,
            itemBuilder: (context, index) {
              final currentKey = categoryController.keys[index];
              final currentImage = categoryController.images[index];
              final currentPrice = categoryController.prices[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: TempComp(
                  name: currentKey,
                  price: currentPrice,
                  image_path: currentImage,
                ),
              );
            },
          );
        },
      ),
);
  }
}
