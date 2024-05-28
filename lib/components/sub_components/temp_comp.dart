import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokoto/models/category_model.dart';
import 'package:tokoto/pages/logged_in_user_pages/product_detail_page.dart';
import 'package:tokoto/providers/user_provider.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class TempComp extends StatelessWidget {
  final String name;
  final String price;
  final String image_path;

  const TempComp({
    super.key,
    required this.name,
    required this.price,
    required this.image_path,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        bool isInWishlist = value.wishList!.any((item) =>
            item["name"] == name &&
            item["price"] == price &&
            item["image_path"] == image_path);

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.sw()),
          child: ListView(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ProductDetailPage(
                      productName: name,
                    );
                  }));
                },
                child: Container(
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
              ),
              Container(
                alignment: Alignment.center,
                width: 34.sw(), // or any width you desire
                child: Text(
                  name,
                  overflow: TextOverflow.clip,
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.sw()),
                    child: Text(price),
                  ),
                  // Text(value.wishList![0].name.toString()),
                  SizedBox(
                    width: 20.sw(),
                  ),
                  GestureDetector(
                    onTap: () async {
                      String message;
                      if (isInWishlist) {
                        message = await value.removeFromWishList(MyProduct(name: name, price: price, image_path: image_path));
                      } else {
                        message = await value.addToWishList(MyProduct(name: name, price: price, image_path: image_path));
                      }
                      print(message);
                      print("wishlist Here");
                      print(value.wishList);
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
          ),
        );
      },
    );
  }
}
