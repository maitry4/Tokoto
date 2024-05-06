import 'package:flutter/material.dart';
import 'package:tokoto/components/custom_button.dart';
import 'package:tokoto/components/custom_textfield.dart';
import 'package:tokoto/pages/home_page.dart';
import 'package:tokoto/services/auth_service.dart';

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
            title: const Padding(
                padding: EdgeInsets.only(left: 95),
                child: Text("Sign Up", style: TextStyle(fontSize: 16)))),
        body: ListView(children: [
          SizedBox(height: 50),
          Column(
            children: [
              const Center(
                  child: Text("Register Account",
                      style: TextStyle(
                          fontSize: 26, fontWeight: FontWeight.w500))),
              const Text(
                  "Complete your details or continue\n              with social media"),
              CustomTextField(
                text: "Enter your email",
                label_text: "Email",
                my_controller: emailController,
                obscureText: false,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });}
              ),
              CustomTextField(
                text: "Enter your password",
                label_text: "Password",
                my_controller: passwordController,
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });}
              ),
              CustomTextField(
                text: "Re-enter your password",
                label_text: "Confirm Password",
                my_controller: confirmPasswordController,
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    confirm_password = value;
                  });}
              ),
              SizedBox(
                height: 10,
              ),
              CustomButtton(
                onTap: () async {
                  if (passwordController.text != confirmPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Passwords do not match"),
                      ),
                    );
                    return;
                  }
                  final message = await AuthService().registration(email: email, password: password);

                  // redirect to home page on successful registration
                  if (message == 'Success') {
                  Navigator.pushReplacement(
                        context,
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
                text: "Continue"
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                  "By continuing your confirm that you agree\n            with our Term and condition")
            ],
          ),
        ]));
  }
}
