import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
                Text("We show the Easy way to shop.\n      Just stay at home with us.", style:TextStyle(fontSize: 15, fontWeight:FontWeight.w400)),
        
          SizedBox(height: 65,),
          SizedBox(width:350, height:250,child: Lottie.network(
                  'https://lottie.host/5b4e0b9a-ff25-4217-93b8-a909fcb1a0d7/7B8XntIJSI.json'),),
        ],
      );
  }
}