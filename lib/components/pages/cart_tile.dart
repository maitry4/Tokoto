import 'package:flutter/material.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class CartTile extends StatelessWidget {
  final String name;
  final String price;
  final String qty;
  final String image_path;
  const CartTile({
    super.key,
    required this.name,
    required this.price,
    required this.qty,
    required this.image_path,
    });

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
                image: AssetImage(image_path),
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
              ]
            ),
          )
        ]
      ),
    );
  }
}