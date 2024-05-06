import "package:flutter/material.dart";

class CustomButtton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  const CustomButtton({
    super.key,
    required this.onTap,
    required this.text,
    });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 60,
      child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, // foreground (text) color
                  backgroundColor: Theme.of(context).primaryColor, // background color
                ),
                  child: Text(
                    text,
                  ),
                  onPressed: onTap,
                ),
    );
  }
}