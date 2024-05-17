import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokoto/components/tiles/categories_tile.dart';
import 'package:tokoto/pages/logged_in_user_pages/category_page.dart';
import 'package:tokoto/providers/category_provider.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class Special4UTile extends StatelessWidget {
  const Special4UTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child:  Consumer<CategoryProvider>(
        builder:(context, value, child) => Container(
                  width: 250.sw(),
                  height: 15.sh(),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                      children: value.categories.map((category) {
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
      ),
             
             
              );
            }
  }