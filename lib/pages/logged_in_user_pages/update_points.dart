import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokoto/components/custom_button.dart';
import 'package:tokoto/controllers/user_controller.dart';
import 'package:tokoto/pages/home_page.dart';

class UpdatePoints extends StatelessWidget {
  final spin_res;
  final UserController userController = Get.put(UserController());
   UpdatePoints({super.key, required this.spin_res});

  @override
  Widget build(BuildContext context) {
        String newPoints = spin_res[0]+spin_res[1]+spin_res[2];
        int numNewPoints = int.parse(newPoints);

        final currentStringPoints = userController.userData.value!.points;
        int currentNumPoints = int.parse(currentStringPoints);
        
        int finalPoints = numNewPoints + currentNumPoints;
        userController.updatePoints(finalPoints.toString());
    return Scaffold(
      body:  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Your Total Points are: $finalPoints"),
              CustomButtton(onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return HomePage();
                  }));
              }, text: "Go To Home")
            ],
          ),
        )
    );
  }
}