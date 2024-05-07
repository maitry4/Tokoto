import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tokoto/components/custom_button.dart';
import 'package:tokoto/intro_pages/intro_page1.dart';
import 'package:tokoto/intro_pages/intro_page2.dart';
import 'package:tokoto/intro_pages/intro_page3.dart';
import 'package:tokoto/pages/login_page.dart';
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

  void goToLogin() {
    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const LoginPage();
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
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
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