import 'package:flutter/material.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class PopularProductSubtile extends StatelessWidget {
  final String name;
  final String price;
  final String image_path;
  const PopularProductSubtile({
    super.key,
    required this.name,
    required this.price,
    required this.image_path,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.sw()),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: 2.sh(), left: 19.sw(), right: 19.sw(), bottom: 17.sh()),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.sh()),
              image: DecorationImage(
                image: AssetImage(image_path),
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
         Row(
              children: [
                Text(price),
                SizedBox(
                  width: 16.sw(),
                ),
                Icon(Icons.favorite),
              ],
            ),
        
        ],
      ),
    );
  }
}