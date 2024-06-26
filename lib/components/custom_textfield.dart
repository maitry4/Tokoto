import 'package:flutter/material.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final String label_text;
  void Function(String)? onChanged;
  final TextEditingController my_controller;
  final bool obscureText;
  final Widget? icon;
  
  CustomTextField({
    super.key,
    required this.text, 
    required this.label_text, 
    required this.my_controller,
    required this.obscureText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: EdgeInsets.only(top:1.sh(), bottom: 1.sh(), right: 4.sw(), left: 4.sw()),
              child: TextField(
                controller: my_controller,
                obscureText: obscureText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.sh()),
                  ),
                  hintText: text,
                  labelText: label_text,
                  suffixIcon: icon),
                ),
              
            );
  }
}