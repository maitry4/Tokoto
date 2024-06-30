import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokoto/components/custom_button.dart';
import 'package:tokoto/components/pages/order_tile.dart';
import 'package:tokoto/controllers/user_controller.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class OrderPage extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List orderList = userController.orderList ?? [];
      double totalPrice = 0;
      orderList.forEach((item) {
        totalPrice += double.parse(item["price"].replaceAll("\$", "")) * item["quantity"];
      });
      return Scaffold(
        appBar: AppBar(
            title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.sw()),
          child: Column(
            children: [
              Text(
                "Order History".tr,
                style: TextStyle(fontSize: 4.sw()),
              ),
              Text("${orderList.length} "+"items".tr, style: TextStyle(fontSize:3.sw()),),
            ],
          ),
        )),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.sh(), horizontal: 5.sw()),
          child: Column(
            children: [
              Expanded(
                child: orderList.isEmpty
                    ? Center(
                        child: Text(
                          "You haven't ordered anything yet",
                          style:
                              TextStyle(fontSize: 4.sw(), color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: orderList.length,
                        itemBuilder: (context, index) {
                          print("hereee");
                          print(orderList);
                          return OrderTile(
                              name: orderList[index]["name"],
                              price: orderList[index]["price"],
                              qty: orderList[index]["quantity"].toString(),
                              image_path: orderList[index]["image_path"]);
                          
                        },
                      ),
              ),
              Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.document_scanner,
                              color: Theme.of(context).primaryColor),
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
                          ]),
                  ],
                ),
              
            ],
          ),
        ),
      );
    });
  }
}
