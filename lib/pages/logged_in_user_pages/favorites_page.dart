import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokoto/components/sub_components/temp_comp.dart';
import 'package:tokoto/providers/user_provider.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.sw()),
          child: Text("Favorites"),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          var wishList = userProvider.wishList;
          
          if (wishList == null || wishList.isEmpty) {
            return Center(
              child: Text("No items in wishlist"),
            );
          } else {
            return GridView.builder(
              itemCount: wishList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.81,
                mainAxisSpacing: 2.sh(),
                crossAxisSpacing: 3.sw(),
              ),
              itemBuilder: (context, index) {
                var item = wishList[index];
                return TempComp(
                  name: item["name"],
                  price: item["price"],
                  image_path: item["image_path"],
                );
              },
            );
          }
        },
      ),
    );
  }
}
