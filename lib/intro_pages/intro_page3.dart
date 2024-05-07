import 'package:flutter/material.dart';
import 'package:tokoto/responsive/size_config.dart';
import 'package:tokoto/responsive/responsive_extension.dart';
class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: SizeConfig.safeBlockHorizontal,
      height: SizeConfig.safeBlockVertical,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
              children: [
                Padding(
              padding:  EdgeInsets.symmetric(horizontal:30.sw()),
              child: Text("TOKOTO", style: TextStyle(color:Theme.of(context).primaryColor, fontSize:9.sw(), fontWeight:FontWeight.bold),),
            ),
                       Text("We show the Easy way to shop.\n      Just stay at home with us.", style:TextStyle(fontSize: 2.sh(), fontWeight:FontWeight.w400)),
              
               SizedBox(width:70.sw(), height:66.sh(),child: Image.asset('assets/intro3.gif')),
                
              ],
            ),
        ),
      ),
    );
  }
}