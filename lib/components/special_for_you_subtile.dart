import 'package:flutter/material.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class Spe4USub extends StatelessWidget {
  final String category;
  final String brands;
  final String image_path;
  const Spe4USub({
    super.key,
    required this.category,
    required this.brands,
    required this.image_path,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal:3.sw()),
      child: Container(
        padding: EdgeInsets.only(top:2.sh(), left:4.sw(), right:30.sw(), bottom:6.sh()),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.sh()),
            image: DecorationImage(
              image: AssetImage(image_path),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Text(category, style: TextStyle(color:Colors.white, fontSize:2.sh(), fontWeight: FontWeight.bold)),
              Text(brands, style: TextStyle(color:Colors.white)),
            ],
          ),
        ),
    );
  }
}