import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      alignment: Alignment(0,-1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
                Text("Welcome to Tokoto, Let's shop!", style:TextStyle(fontSize: 15, fontWeight:FontWeight.w400)),
        
          SizedBox(height: 65,),
          SizedBox(width:400, height:250,child: Lottie.network(
                  'https://lottie.host/286c2228-c3b5-477d-82d0-41c9cd7b7892/JjW7Y5qdPt.json'),),
        ],
      ),
    );
  }
}