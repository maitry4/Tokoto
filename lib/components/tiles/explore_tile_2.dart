import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokoto/components/sub_components/sub_tile.dart';
import 'package:tokoto/pages/logged_in_user_pages/daily_reward.dart';
import 'package:tokoto/pages/logged_in_user_pages/flash_deal_page.dart';
import 'package:tokoto/pages/logged_in_user_pages/order_page.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class ExploreTile2 extends StatelessWidget {
  const ExploreTile2({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.only(left: 1.sw()),
        child: Row(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FlashDealPage();
                  }));
                },
                child: SubTile(
                    icon: Icon(Icons.bolt_outlined,
                        color: Theme.of(context).primaryColor),
                    text: "Flash Deal".tr)),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return OrderPage();
                  }));
              },
              child: SubTile(
                  icon: Icon(Icons.book, color: Theme.of(context).primaryColor),
                  text: "Orders".tr),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SpinTheWheel();
                  }));
              },
              child: SubTile(
                  icon: Icon(Icons.card_giftcard,
                      color: Theme.of(context).primaryColor),
                  text: "Daily Gift".tr),
            ),
          ],
        ),
      ),
    );
  }
}
