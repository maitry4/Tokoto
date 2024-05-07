import 'package:flutter/material.dart';
import 'package:tokoto/responsive/size_config.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                  
                        Text("Welcome to Tokoto, Let's shop!", style:TextStyle(fontSize: 2.sh(), fontWeight:FontWeight.w400)),
                        
                  
                  SizedBox(width:75.sw(), height:65.sh(),child: Image.asset('assets/intro1.gif'),),
                ],
              ),
        ),
      ),
    );
  }
}