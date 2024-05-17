import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tokoto/components/custom_button.dart';
import 'package:tokoto/pages/intro_page.dart';
import 'package:tokoto/pages/auth_page.dart';
import 'package:tokoto/responsive/responsive_extension.dart';
import 'package:tokoto/responsive/size_config.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // controller to keep track of which is current page 
  final PageController _controller = PageController();

  void goToLogin() async {
    final pres = await SharedPreferences.getInstance();
    pres.setBool("onboarding", true);

    if(!mounted)return;
    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return  AuthPage();
                    })
                  );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.safeBlockHorizontal,
      height: SizeConfig.safeBlockVertical,
      child: Scaffold(
        body: Stack(
          children: [
            
      
            // to switch pages
            PageView(
            controller: _controller,
            children: const [
              // pages
              IntroPage(text:"Welcome to Tokoto, Let's shop!", imagePath:'assets/intro1.gif'),
              IntroPage(text:"We help people connect with store\n around United States of America", imagePath:'assets/intro2.gif'),
              IntroPage(text:"We show the Easy way to shop.\n      Just stay at home with us.", imagePath:'assets/intro3.gif'),
            ],
          ),
      
          // dot indicator
          
                Padding(
                  padding: EdgeInsets.symmetric(vertical:80.sh(), horizontal: 44.sw()),
                  child: SmoothPageIndicator(
                    controller: _controller,
                     count:3,
                     effect: WormEffect(activeDotColor: Theme.of(context).primaryColor),   
                        ),
                ),
                   
            
      
            // button
              Padding(
                padding: EdgeInsets.only(top:84.sh(), left:5.sw()),
                child: CustomButtton(text: 'Continue',onTap:goToLogin),
              ),
       
          ]
        ),
      ),
    );
  }
}