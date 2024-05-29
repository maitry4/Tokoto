import 'package:flutter/material.dart';
import 'package:tokoto/components/custom_button.dart';
import 'package:tokoto/components/custom_icon.dart';
import 'package:tokoto/components/custom_textfield.dart';
import 'package:tokoto/controllers/user_controller.dart';
import 'package:tokoto/pages/forgot_password_page.dart';
import 'package:tokoto/pages/login_sucess_page.dart';
import 'package:tokoto/pages/register_page.dart';
import 'package:tokoto/responsive/responsive_extension.dart';
import 'package:tokoto/services/auth_service.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  bool isChecked = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // Hide the keyboard when tapped outside of text fields
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
              title: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 26.sw()),
                  child: Text("Sign In", style: TextStyle(fontSize: 2.sh())))),
          body: ListView(children: [
            Padding(
              padding: EdgeInsets.only(top: 3.sh()),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Welcome Back",
                      style: TextStyle(
                          fontSize: 3.sh(), fontWeight: FontWeight.w500)),
                  const Text(
                      "Sign in with your email and password\n      or continue with social media"),
                  CustomTextField(
                    icon: Icon(Icons.email_outlined),
                    text: "Enter your email",
                    label_text: "Email",
                    my_controller: emailController,
                    obscureText: false,
                  ),
                  CustomTextField(
                    icon: Icon(Icons.lock_outline),
                    text: "Enter your password",
                    label_text: "Password",
                    my_controller: passwordController,
                    obscureText: true,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 2.sh(), horizontal: 3.sw()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: isChecked,
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (bool? value) {
                              },
                            ),
                            const Text("Remember me"),
                          ],
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const ForgotPasswordPage();
                              }));
                            },
                            child:  const Text("Forgot Password",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                  )
                            )),
                      ],
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

                      final message = await AuthService()
                          .login(email: emailController.text, password: passwordController.text);

                      // Hide the progress indicator
                      Navigator.pop(context);

                      if (message == 'Success') {
                        // Initialize data after successful login
                        await userController.initializeData();
                        // Redirect to the home page
                        Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return LoginSuccessPage();
                            }));
                      } else {
                        // Show error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(message!),
                          ),
                        );
                      }
                    },
                    text: "Sign In",
                  ),

                  // social buttons
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.sh()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.sw()),
                          child: CustomIcon(
                            icon: SizedBox(
                                width: 8.sw(),
                                child: Image.asset("assets/google.png")),
                            padding: 2,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.sw()),
                          child: CustomIcon(
                            icon: SizedBox(
                                width: 8.sw(),
                                child: Image.asset("assets/facebook.png")),
                            padding: 2,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.sw()),
                          child: CustomIcon(
                            icon: SizedBox(
                                width: 8.sw(),
                                child: Image.asset("assets/twitter.png")),
                            padding: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return RegisterPage();
                            }));
                          },
                          child: Text(" Sign Up",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ))),
                    ],
                  ),
                ],
              ),
            ),
          ])),
    );
  }
}
