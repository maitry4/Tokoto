import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokoto/components/custom_icon.dart';
import 'package:tokoto/controllers/user_controller.dart';
import 'package:tokoto/pages/logged_in_user_pages/account_page.dart';
import 'package:tokoto/pages/login_page.dart';
import 'package:tokoto/responsive/responsive_extension.dart';
import 'package:tokoto/services/auth_service.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.sw()),
        child: ListView(
          children: [
            Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 40.sw(), vertical: 4.sh()),
                child: Text("Profile")),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(children: [
                  userController.profileImageURL.isNotEmpty
                      ? CircleAvatar(
                          radius: 17.sw(),
                          backgroundImage: NetworkImage(
                              userController.profileImageURL.value),
                        )
                      : CircleAvatar(
                          radius: 17.sw(),
                          backgroundImage: NetworkImage(
                            'https://cdn.pixabay.com/photo/2020/11/10/01/34/pet-5728249_640.jpg',
                          ),
                        ),
                  Positioned(
                    child: IconButton(
                      onPressed: () async {
                        // Start showing the circular progress indicator
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );

                        final message = await userController.selectImage();
                        // Hide the progress indicator
                      Navigator.pop(context);
                        if(message=="Success") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Image selected Successfully"),
                            ),
                          );
                        } else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message!),
                            ),
                          );
                        }
                      },
                      icon: CustomIcon(
                          icon: Icon(Icons.camera_alt_outlined), padding: 2),
                    ),
                    bottom: 0,
                    left: 85,
                  )
                ]),
              ],
            ),
            SizedBox(height: 2.sh()),
            GestureDetector(
              child: ItemProfile(
                  title: 'My Account', iconData: Icons.person_outline),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AccountPage();
                }));
              },
            ),
            SizedBox(height: 2.sh()),
            ItemProfile(
                title: 'Notifications', iconData: Icons.notifications_outlined),
            SizedBox(height: 2.sh()),
            ItemProfile(title: 'Settings', iconData: Icons.settings),
            SizedBox(height: 2.sh()),
            ItemProfile(title: 'Help Center', iconData: Icons.question_mark),
            SizedBox(
              height: 2.sh(),
            ),
            GestureDetector(
                child: ItemProfile(title: 'Log Out', iconData: Icons.logout),
                onTap: () async {
                  try {
                    userController.clearUserData();
                    await AuthService().logout();
                    // Redirect to login page or any other page after logout
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    }));
                  } catch (e) {
                    // Handle error
                    print("Logout error: $e");
                  }
                }),
          ],
        ),
      ),
    );
  }
}

class ItemProfile extends StatelessWidget {
  String title;
  IconData iconData;
  ItemProfile({super.key, required this.title, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(197, 244, 243, 249),
        borderRadius: BorderRadius.circular(3.sh()),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.sw(), vertical: 1.sh()),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          leading: Icon(
            iconData,
            color: Theme.of(context).primaryColor,
            size: 4.sh(),
          ),
          trailing: Icon(Icons.arrow_forward_ios_rounded,
              color: Theme.of(context).primaryColor),
          hoverColor: Theme.of(context).primaryColor,
          // tileColor: Colors.white,
        ),
      ),
    );
  }
}
