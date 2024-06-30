import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokoto/components/pages/cart_tile.dart';
import 'package:tokoto/components/custom_button.dart';
import 'package:tokoto/controllers/user_controller.dart';
import 'package:tokoto/pages/logged_in_user_pages/order_success_page.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class CartPage extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List cartList = userController.cartList ?? [];
      double totalPrice = 0;
      cartList.forEach((item) {
        totalPrice +=
            double.parse(item["price"].replaceAll("\$", "")) * item["quantity"];
      });
      return Scaffold(
        appBar: AppBar(
            title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.sw()),
          child: Column(
            children: [
              Text(
                "Your Cart".tr,
                style: TextStyle(fontSize: 4.sw()),
              ),
              Text(
                "${cartList.length} " + "items".tr,
                style: TextStyle(fontSize: 3.sw()),
              ),
            ],
          ),
        )),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.sh(), horizontal: 5.sw()),
          child: Column(
            children: [
              Expanded(
                child: cartList.isEmpty
                    ? Center(
                        child: Text(
                          "Your cart is empty",
                          style:
                              TextStyle(fontSize: 4.sw(), color: Colors.grey),
                        ),
                      )
                    : ListView(
                        children: cartList.map((item) {
                          return CartTile(
                            name: item["name"],
                            price: item["price"],
                            image_path: item["image_path"],
                            qty: " x ${item["quantity"]}",
                          );
                        }).toList(),
                      ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 2.sh(), horizontal: 2.sw()),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.document_scanner,
                              color: Theme.of(context).primaryColor),
                          Text("Add voucher code".tr + " >"),
                        ]),
                    SizedBox(
                      height: 2.sh(),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Total".tr + ":"),
                              Text("\$${totalPrice.toStringAsFixed(2)}"),
                            ],
                          ),
                          Container(
                              width: 35.sw(),
                              child: CustomButtton(
                                  onTap: () async {
                                    final res =
                                        await userController.placeOrder();
                                    if (res == "Success") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text("Order Placed"),
                                        ),
                                      );
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return OrderSuccessPage();
                                      }));
                                    } 
                                    else if(res=="database"){
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text("Database"),
                                        ),
                                      );
                                    }
                                    else if(res=="error"){
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text("Logic"),
                                        ),
                                      );
                                    }
                                    else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text("Something went wrong"),
                                        ),
                                      );
                                    }
                                  },
                                  text: "Check Out".tr))
                        ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
