import 'package:flutter/material.dart';
import 'package:tokoto/components/custom_button.dart';
import 'package:tokoto/pages/home_page.dart';
import 'package:tokoto/responsive/responsive_extension.dart';


class LoginSuccessPage extends StatelessWidget {
  const LoginSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          children: [
            Padding(
              padding:  EdgeInsets.only(top: 3.sh()),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
              const Text("Login Success"),

              Padding(
                padding:  EdgeInsets.only(top: 5.sh()),
                child: Image.asset('assets/login_success.png'),
              ),

              Padding(
                padding:  EdgeInsets.only(top: 3.sh()),
                child: Text("Login Success",
                      style:
                          TextStyle(fontSize: 3.sh(), fontWeight: FontWeight.w500)),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.sw(), vertical: 18.sh()),
                child: CustomButtton(onTap: () {
                  Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return const HomePage();
                            }));
                }, text: "Back to home"),
              ),
                        ]
              ),
            ),
          ]
      ),
    );
  }
}