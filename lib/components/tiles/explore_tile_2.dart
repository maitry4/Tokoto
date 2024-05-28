import 'package:flutter/material.dart';
import 'package:tokoto/components/sub_components/sub_tile.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class ExploreTile2 extends StatelessWidget {
  const ExploreTile2({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child:Padding(
        padding: EdgeInsets.only(left:1.sw()),
        child: Row(
          children: [
            SubTile(icon:Icon(Icons.bolt_outlined, color:Theme.of(context).primaryColor), text:"Flash Deal"),
            SubTile(icon:Icon(Icons.book, color:Theme.of(context).primaryColor), text:"Bill"),
            SubTile(icon:Icon(Icons.gas_meter_outlined, color:Theme.of(context).primaryColor), text:"Game"),
            SubTile(icon:Icon(Icons.card_giftcard, color:Theme.of(context).primaryColor), text:"Daily Gift"),
            SubTile(icon:Icon(Icons.more, color:Theme.of(context).primaryColor), text:"More"),
          ],
        ),
      ),
    );
  }
}