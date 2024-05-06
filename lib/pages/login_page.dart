import 'package:flutter/material.dart';
import 'package:tokoto/components/custom_button.dart';
import 'package:tokoto/components/custom_textfield.dart';
import 'package:tokoto/pages/forgot_password_page.dart';
import 'package:tokoto/pages/home_page.dart';
import 'package:tokoto/pages/register_page.dart';
import 'package:tokoto/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String password = "";
  bool isChecked = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Padding(
                padding: EdgeInsets.only(left: 95),
                child: Text("Sign In", style: TextStyle(fontSize: 16)))),
        body: ListView(children: [
          SizedBox(height: 50),
          Column(
            children: [
              const Center(
                  child: Text("Welcome Back",
                      style: TextStyle(
                          fontSize: 26, fontWeight: FontWeight.w500))),
              const Text(
                  "Sign in with your email and password\n      or continue with social media"),
              CustomTextField(
                text: "Enter your email",
                label_text: "Email",
                my_controller: emailController,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                obscureText: false,
              ),
              CustomTextField(
                text: "Enter your password",
                label_text: "Password",
                my_controller: passwordController,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                obscureText: true,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        Text("Remember me"),
                      ],
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ForgotPasswordPage();
                          }));
                        },
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ForgotPasswordPage();
                            }));
                          },
                          child: Text("Forgot Password",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              )),
                        )),
                  ],
                ),
              ),
              CustomButtton(
                  onTap: () async {
                    final message = await AuthService()
                        .login(email: email, password: password);

                    // redirect to home page on successful registration
                    if (message == 'Success') {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return HomePage();
                      }));
                    }

                    //  show error whatever it might be
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message!),
                      ),
                    );
                  },
                  text: "Sign In"),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return RegisterPage();
                        }));
                      },
                      child: const Text(" Sign Up",
                          style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.w500))),
                ],
              ),
            ],
          ),
        ]));
  }
}
