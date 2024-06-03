import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class ExploreTilePurple extends StatelessWidget {
  final Color color;
   String text1;
   String text2;
  ExploreTilePurple({super.key,
  this.color = const Color(0Xff533D9C),
  this.text1 = "A Summer Surprise",
  this.text2 = "Cashback 20%",
  });

  @override
  Widget build(BuildContext context) {
    text1 = text1.tr;
    text2 = text2.tr;
    return Padding(
                padding: EdgeInsets.all(2.sh()),
                child: Container(
                  padding: EdgeInsets.only(top: 3.sh(), bottom: 3.sh(),right: 41.sw(), left: 5.sw()),
                  decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2.sh()),
                  ),
                  child:Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Text(
                        text1, 
                        style: TextStyle(color: Colors.white,)
                      ),
                      Text(
                        text2, 
                        style: TextStyle(
                          color: Colors.white,
                          fontSize:3.sh(),
                          fontWeight: FontWeight.bold,
                          )
                        ),
                    ],
                  ),
                ),
              );
  }
}