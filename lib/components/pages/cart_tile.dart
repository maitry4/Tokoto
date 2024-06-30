import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokoto/controllers/user_controller.dart';
import 'package:tokoto/models/category_model.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class CartTile extends StatelessWidget {
  final String name;
  final String price;
  final String qty;
  final String image_path;
   CartTile({
    super.key,
    required this.name,
    required this.price,
    required this.qty,
    required this.image_path,
    });

  final UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.sh()),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: 2.sh(), left: 13.sw(), right: 13.sw(), bottom: 11.sh()),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.sh()),
              image: DecorationImage(
                image: NetworkImage(image_path),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left:5.sw()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,style: TextStyle(fontSize: 2.sh()),),
                    SizedBox(height: 1.sh(),),
                Row(
                    children: [
                     Text(price, style: TextStyle(color:Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 2.sh()),),
                      Text(qty, textAlign: TextAlign.left, style: TextStyle(fontSize: 2.sh())),
                    ],
                  ),
                  Obx(
                    ()=> Row(
                        children: [
                          // - button
                          Container(
                              child: IconButton(
                                  onPressed: () async {
                                    final res = await userController.removeFromCart(MyProduct(
                                        name: name,
                                        price: price,
                                        image_path: image_path));
                                    if (res == "Success") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text("Removed from cart"),
                                        ),
                                      );
                                    } else if (res == "database") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text("Database not modified"),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text("Something went wrong"),
                                        ),
                                      );
                                    }
                                  },
                                  icon: Icon(Icons.remove_circle,))),
                          // qty
                          Text(userController.getProductQuantity(name).toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold)),
                          
                          // + button
                          Container(
                              child: IconButton(
                                  onPressed: () async {
                                    final message = await userController.addToCart(
                                        MyProduct(
                                            name: name,
                                            price: price,
                                            image_path: image_path));
                                    print(message);
                                    if (message == "Success") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text("Added to cart"),
                                        ),
                                      );
                                    } else if (message == "database") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text("Database not modified"),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text("Something went wrong"),
                                        ),
                                      );
                                    }
                                    print(userController.cartList);
                                  },
                                  icon: Icon(Icons.add_circle,))),
                        ],
                      ),
                  )
                
              ]
            ),
          )
        ]
      ),
    );
  }
}