import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokoto/providers/category_provider.dart';
import 'package:tokoto/responsive/responsive_extension.dart';
import 'package:tokoto/components/sub_components/temp_comp.dart';

class CategoryPage extends StatefulWidget {
  final String category;
  const CategoryPage({super.key, required this.category});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  @override
  Widget build(BuildContext context) {
    // Retrieve the CategoryProvider instance
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    categoryProvider.getProducts(widget.category);
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.sw()),
            child: Text(widget.category),
          ),
        ),
        body: Consumer<CategoryProvider>(
        builder: (context, categoryProvider, _) {
          if (categoryProvider.keys.isEmpty) {
            return CircularProgressIndicator(); // Show loading indicator while fetching data
          }

          return GridView.builder(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.87,
            ),
            itemCount: categoryProvider.keys.length,
            itemBuilder: (context, index) {
              final currentKey = categoryProvider.keys[index];
              final currentImage = categoryProvider.images[index];
              final currentPrice = categoryProvider.prices[index];

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
