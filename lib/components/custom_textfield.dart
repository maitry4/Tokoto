import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
  final String text;
  final String label_text;
  void Function(String)? onChanged;
  final TextEditingController my_controller;
  final bool obscureText;
  
  CustomTextField({
    super.key,
    required this.text, 
    required this.label_text, 
    required this.my_controller,
    required this.onChanged,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.only(top:10.0, bottom: 10.0, right: 18.0, left: 18.0),
              child: TextField(
                onChanged: onChanged,
                obscureText: obscureText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  hintText: text,
                  labelText: label_text,
                ),
              ),
            );
  }
}