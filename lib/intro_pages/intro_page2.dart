import 'package:flutter/material.dart';
import 'package:tokoto/responsive/responsive_extension.dart';
import 'package:tokoto/responsive/size_config.dart';
class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

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
              
                    Text("We help people connect with store\n around United States of America", style:TextStyle(fontSize: 2.sh(), fontWeight:FontWeight.w400)),
            
              SizedBox(width:75.sw(), height:SizeConfig.safeBlockVertical*66,child: Image.asset('assets/intro2.gif')),
            ],
          ),
        ),
      ),
    );
  }
}