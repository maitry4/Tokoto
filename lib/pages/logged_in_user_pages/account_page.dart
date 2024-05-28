import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:tokoto/controllers/user_controller.dart";
import "package:tokoto/responsive/responsive_extension.dart";

class AccountPage extends StatelessWidget {
  final UserController userController = Get.put(UserController());
   AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=>
       Scaffold(
         body: SizedBox(
           child: ListView(
             children: [
              
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text("Username: "),
                      Text(userController.userData!.toString()),
                      IconButton(onPressed: () {}, icon: Icon(Icons.edit, size: 4.sw(),))
                    ],
                  ),
                )
               
             ],
           ),
         ),
       )
       );
  }
}