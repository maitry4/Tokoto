import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokoto/components/custom_button.dart';
import 'package:tokoto/components/custom_textfield.dart';
import 'package:tokoto/controllers/user_controller.dart';
import 'package:tokoto/pages/home_page.dart';
import 'package:tokoto/services/auth_service.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Padding(
                padding: EdgeInsets.symmetric(horizontal: 26.sw()),
                child: Text("Sign Up".tr, style: TextStyle(fontSize: 2.sh())))),
        body: ListView(children: [
          Padding(
            padding: EdgeInsets.only(top:3.sh()),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Register Account".tr,
                    style:
                        TextStyle(fontSize: 3.sh(), fontWeight: FontWeight.w500)),
                 Text(
                    "Complete your details or continue\n              with social media".tr),
                CustomTextField(
                  icon: Icon(Icons.email_outlined),
                    text: "Enter your email".tr,
                    label_text: "Email".tr,
                    my_controller: emailController,
                    obscureText: false,
                    ),
                CustomTextField(
                  icon: Icon(Icons.lock_outlined),
                    text: "Enter your password".tr,
                    label_text: "Password".tr,
                    my_controller: passwordController,
                    obscureText: true,
                    ),
                CustomTextField(
                    icon: Icon(Icons.lock_outlined),
                    text: "Re-enter your password".tr,
                    label_text: "Confirm Password".tr,
                    my_controller: confirmPasswordController,
                    obscureText: true,
                    ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.sh()),
                  child: CustomButtton(
                      onTap: () async {
                        if (passwordController.text!=
                            confirmPasswordController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Passwords do not match"),
                            ),
                          );
                          return;
                        }
                        // Start showing the circular progress indicator
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                        
                        final message = await AuthService()
                            .registration(email: emailController.text, password: passwordController.text);
            
                        // Hide the progress indicator
                        Navigator.pop(context);
            
                        // redirect to home page on successful registration
                        if (message == 'Success') {
                          await userController.initializeData();
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return const HomePage();
                          }));
                        }
            
                        //  show error whatever it might be
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(message!),
                          ),
                        );
                      },
                      text: "Continue".tr),
                ),
                Text(
                    "By continuing your confirm that you agree\n            with our Term and condition".tr),
              ],
            ),
          ),
        ]));
  }
}
