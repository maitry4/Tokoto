import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokoto/controllers/user_controller.dart';
import 'package:tokoto/models/category_model.dart';
import 'package:tokoto/pages/logged_in_user_pages/product_detail_page.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class PopularProductSubtile extends StatelessWidget {
  final String name;
  final String price;
  final String image_path;
  final UserController userController = Get.put(UserController());
   PopularProductSubtile({
    super.key,
    required this.name,
    required this.price,
    required this.image_path,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        bool isInWishlist = userController.wishList!.any((item) =>
            item["name"] == name &&
            item["price"] == price &&
            item["image_path"] == image_path);

        return  Column(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return  ProductDetailPage(productName: name,);
              }));
            },
            
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.sw()),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: 2.sh(), left: 19.sw(), right: 19.sw(), bottom: 17.sh()),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.sh()),
                      image: DecorationImage(
                        image: NetworkImage(image_path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: 34.sw(), // or any width you desire
                    child: Text(
                      name,
                      overflow: TextOverflow.clip,
                    ),
                  ),    
                ],
              ),
            ),
          ),
          Row(
                  children: [
                    Text(price),
                    SizedBox(
                      width: 16.sw(),
                    ),
                     GestureDetector(
                    onTap: () async {
                      String message;
                      if (isInWishlist) {
                        message = await userController.removeFromWishList(MyProduct(name: name, price: price, image_path: image_path));
                      } else {
                        message = await userController.addToWishList(MyProduct(name: name, price: price, image_path: image_path));
                      }
                      print(message);
                      print("wishlist Here");
                      print(userController.wishList);
                      if (message == "Success") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(isInWishlist ? "Removed from wishlist" : "Added to wishlist"),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Something went wrong"),
                          ),
                        );
                      }
                    },
                    child: Icon(
                      isInWishlist ? Icons.favorite : Icons.favorite_outline,
                      color: isInWishlist ? Colors.red : null,
                    ),
                  ),
                
                  ],
                ),
        ],
      );
      }
    );
  }
}
