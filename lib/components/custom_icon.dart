import 'package:flutter/material.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class CustomIcon extends StatelessWidget {
  final Widget? icon;
  final int padding;
  const CustomIcon({super.key, required this.icon, required this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
                        padding: EdgeInsets.only(top:2.sh()),
                        child: Container(
                          padding: EdgeInsets.all(padding.sw()),
                          child:icon,
                          decoration: BoxDecoration(
                          color: Theme.of(context).secondaryHeaderColor,
                            borderRadius: BorderRadius.circular(10.sh()),
                          ),
                        ),
                      );
  }
}