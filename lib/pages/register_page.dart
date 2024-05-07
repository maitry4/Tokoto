import 'package:flutter/material.dart';
import 'package:tokoto/components/custom_button.dart';
import 'package:tokoto/components/custom_textfield.dart';
import 'package:tokoto/pages/home_page.dart';
import 'package:tokoto/services/auth_service.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String email = "";
  String password = "";
  String confirm_password = "";

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Padding(
                padding: EdgeInsets.symmetric(horizontal: 26.sw()),
                child: Text("Sign Up", style: TextStyle(fontSize: 2.sh())))),
        body: ListView(children: [
          Padding(
            padding: EdgeInsets.only(top:3.sh()),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Register Account",
                    style:
                        TextStyle(fontSize: 3.sh(), fontWeight: FontWeight.w500)),
                const Text(
                    "Complete your details or continue\n              with social media"),
                CustomTextField(
                  icon: Icon(Icons.email_outlined),
                    text: "Enter your email",
                    label_text: "Email",
                    my_controller: emailController,
                    obscureText: false,
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    }),
                CustomTextField(
                  icon: Icon(Icons.lock_outlined),
                    text: "Enter your password",
                    label_text: "Password",
                    my_controller: passwordController,
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    }),
                CustomTextField(
                    icon: Icon(Icons.lock_outlined),
                    text: "Re-enter your password",
                    label_text: "Confirm Password",
                    my_controller: confirmPasswordController,
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        confirm_password = value;
                      });
                    }),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.sh()),
                  child: CustomButtton(
                      onTap: () async {
                        if (passwordController.text !=
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
                            .registration(email: email, password: password);
            
                        // Hide the progress indicator
                        Navigator.pop(context);
            
                        // redirect to home page on successful registration
                        if (message == 'Success') {
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
                      text: "Continue"),
                ),
                const Text(
                    "By continuing your confirm that you agree\n            with our Term and condition"),
              ],
            ),
          ),
        ]));
  }
}
