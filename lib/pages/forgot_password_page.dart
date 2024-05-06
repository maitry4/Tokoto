import 'package:flutter/material.dart';
import 'package:tokoto/components/custom_button.dart';
import 'package:tokoto/components/custom_textfield.dart';
import 'package:tokoto/pages/register_page.dart';
import 'package:tokoto/services/auth_service.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String email = "";
  TextEditingController emailController =TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Padding(
                padding: EdgeInsets.only(left: 95),
                child: Text("Forgot Password", style: TextStyle(fontSize: 16))
                )
              ),
        body: ListView(children: [
          SizedBox(height:50),
          Column(
            children: [
              
              const Center(
                  child: Text("Forgot Password",
                      style: TextStyle(
                          fontSize: 26, fontWeight: FontWeight.w500))),
              const Text(
                  "Please enter your email and we will send\n      you a link to return to your account"),
              CustomTextField(
                text: "Enter your email", 
                label_text: "Email",
                my_controller: emailController,
                onChanged: (value){
                  setState(() {
                    email = value;
                  });
                },
                obscureText: false,
                ),

              SizedBox(
                height: 10,
              ),
              CustomButtton(onTap: () async {
                final message = await AuthService().resetPassword(email);
                if (message == 'Success') {
                    ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Password reset link has been successfully sent!\nIf you are a verified user"),
                    ));
                    return;
                   }
                  //  show error whatever it might be
                    ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message!),
                    ));
              }, text: "Continue"),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  GestureDetector(
                    onTap:() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                      return RegisterPage();
                    })
                        );
                    },
                    child:const Text(" Sign Up", 
                    style:TextStyle(
                      color:Colors.orange,
                       fontWeight:FontWeight.w500
                    ))),
                ],
              ),
              ],
          ),
        ])
      );
  
  }
}