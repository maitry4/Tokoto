import 'package:flutter/material.dart';
import 'package:tokoto/components/cart_tile.dart';
import 'package:tokoto/components/custom_button.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding:  EdgeInsets.symmetric(horizontal:25.sw()),
          child: Column(
            children: [
              Text("Your Cart", style: TextStyle(fontSize:4.sw()),),
              Text("3 items", style: TextStyle(fontSize:3.sw()),),
            ],
          ),
        )
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(vertical: 2.sh(), horizontal:5.sw()),
        child: ListView(
          children: [
            CartTile(name: "Wireless Controller for PS4", price: "\$64.99 ", image_path: "assets/game.jpg", qty:" x2"),
            CartTile(name: "Nike Sport White - Man Pant", price: "\$50.5", image_path: "assets/pants.jpg", qty:" x1"),
            CartTile(name: "Logitech Head", price: "\$20.2", image_path: "assets/headphones.jpg", qty:" x1"),

            SizedBox(height: 28.sh(),),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal:2.sw()),
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
                      Text("\$337.15")
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
}