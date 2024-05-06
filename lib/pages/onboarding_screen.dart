import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tokoto/components/custom_button.dart';
import 'package:tokoto/intro_pages/intro_page1.dart';
import 'package:tokoto/intro_pages/intro_page2.dart';
import 'package:tokoto/intro_pages/intro_page3.dart';
import 'package:tokoto/pages/login_page.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // controller to keep track of which is current page 
  PageController _controller = PageController();

  void goToLogin() {
    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    })
                  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment(0,-0.55),
            child: Text("TOKOTO", style: TextStyle(color:Theme.of(context).primaryColor, fontSize:35, fontWeight:FontWeight.bold),)
          ),

          // to switch pages
          PageView(
          controller: _controller,
          children: [
            // pages
            IntroPage1(),
            IntroPage2(),
            IntroPage3(),
          ],
        ),

        // dot indicator
        Container(
          alignment: Alignment(0,0.55),
          child:
              SmoothPageIndicator(
                controller: _controller,
                 count:3,
                 effect: WormEffect(activeDotColor: Colors.orange),   
),
                 
          ),

          // button
          Container(
            alignment: Alignment(0,0.85),
            child: CustomButtton(text: 'Continue',onTap:goToLogin)),
 
        ]
      ),
    );
  }
}