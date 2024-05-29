import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokoto/components/sub_components/temp_comp.dart';
import 'package:tokoto/controllers/user_controller.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class FavoritePage extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  FavoritePage({super.key});

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
      body: Obx(
        () {
          var wishList = userController.wishList;
          
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
