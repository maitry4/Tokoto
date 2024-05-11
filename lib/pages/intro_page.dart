import 'package:flutter/material.dart';
import 'package:tokoto/responsive/size_config.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class IntroPage extends StatelessWidget {
  final String text;
  final String imagePath;
  const IntroPage({super.key, required this.text, required this.imagePath});

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
                  
                        Text(text, style:TextStyle(fontSize: 2.sh(), fontWeight:FontWeight.w400)),
                        
                  
                  SizedBox(width:75.sw(), height:65.sh(),child: Image.asset(imagePath),),
                ],
              ),
        ),
      ),
    );
  }
}