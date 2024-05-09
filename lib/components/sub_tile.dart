import 'package:flutter/material.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class SubTile extends StatelessWidget {
  final Widget icon;
  final String text;
  const SubTile({
      super.key,
      required this.icon,
      required this.text
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: EdgeInsets.all(1.sh()),
            child: Column(
              children: [
                 Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(1.sh()),
                  ),
                    width: 14.sw(),
                    height: 14.sw(),
                    child: icon,
                  ),
                
                Text(text),
              ],
            ),
          );
  }
}