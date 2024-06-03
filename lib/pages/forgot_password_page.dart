import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokoto/components/custom_button.dart';
import 'package:tokoto/components/custom_textfield.dart';
import 'package:tokoto/pages/register_page.dart';
import 'package:tokoto/services/auth_service.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Padding(
                padding: EdgeInsets.symmetric(horizontal: 17.sw()),
                child: Text("Forgot Password".tr,
                    style: TextStyle(fontSize: 2.sh())))),
        body: ListView(children: [
          Padding(
            padding: EdgeInsets.only(top:3.sh()),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Forgot Password".tr,
                    style:
                        TextStyle(fontSize: 3.sh(), fontWeight: FontWeight.w500)),
                 Text(
                    "Please enter your email and we will send\n      you a link to return to your account".tr),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.sh()),
                  child: CustomTextField(
                    icon:Icon(Icons.email_outlined),
                    text: "Enter your email".tr,
                    label_text: "Email".tr,
                    my_controller: emailController,
                    obscureText: false,
                  ),
                ),
                CustomButtton(
                    onTap: () async {
                      // Start showing the circular progress indicator
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                      
                      final message = await AuthService().resetPassword(emailController.text);
            
                      // Hide the progress indicator
                      Navigator.pop(context);
                      if (message == 'Success') {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "Password reset link has been successfully sent!\nIf you are a verified user"),
                        ));
                        return;
                      }
                      //  show error whatever it might be
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(message),
                      ));
                    },
                    text: "Continue".tr),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.sh()),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text("I do not have an account".tr),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return RegisterPage();
                            }));
                          },
                          child: Text(" "+"Sign Up".tr,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}
