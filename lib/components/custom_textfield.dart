import 'package:flutter/material.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class CustomTextField extends StatefulWidget {
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
    required this.onChanged,
    required this.obscureText,
    required this.icon,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: EdgeInsets.only(top:1.sh(), bottom: 1.sh(), right: 4.sw(), left: 4.sw()),
              child: TextField(
                onChanged: widget.onChanged,
                obscureText: widget.obscureText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.sh()),
                  ),
                  hintText: widget.text,
                  labelText: widget.label_text,
                  suffixIcon: widget.icon),
                ),
              
            );
  }
}