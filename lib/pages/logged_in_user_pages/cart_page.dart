import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokoto/components/pages/cart_tile.dart';
import 'package:tokoto/components/custom_button.dart';
import 'package:tokoto/providers/user_provider.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder:(context, value, child) {
        List cartList = value.cartList ?? [];
        double totalPrice = 0;
        cartList.forEach((item) {
          totalPrice += double.parse(item["price"].replaceAll("\$", "")) * item["quantity"];
        });
        return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding:  EdgeInsets.symmetric(horizontal:25.sw()),
            child: Column(
              children: [
                Text("Your Cart", style: TextStyle(fontSize:4.sw()),),
                Text("${cartList.length} items", style: TextStyle(fontSize:3.sw()),),
              ],
            ),
          )
        ),
        body: Padding(
          padding:  EdgeInsets.symmetric(vertical: 2.sh(), horizontal:5.sw()),
          child: Column(
            children: [
              Expanded(
                  child: cartList.isEmpty
                      ? Center(
                          child: Text(
                            "Your cart is empty",
                            style: TextStyle(fontSize: 4.sw(), color: Colors.grey),
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
                padding:  EdgeInsets.symmetric(vertical:2.sh(),horizontal:2.sw()),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.document_scanner,color:Theme.of(context).primaryColor),
                        
                        Text("Add voucher code >"),
                      ]
                    ),
                SizedBox(
                  height: 2.sh(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Total:"),
                        Text("\$${totalPrice.toStringAsFixed(2)}"),
                      ],
                    ),
                    Container(width: 35.sw(),child: CustomButtton(onTap: () {}, text: "Check Out"))
                  ]
                ),
                          
                  ],
                ),
              ),
            ],
          ),
        ),
      ); 
    }
    );
  }
}