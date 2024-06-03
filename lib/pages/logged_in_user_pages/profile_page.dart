import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tokoto/components/custom_icon.dart';
import 'package:tokoto/controllers/user_controller.dart';
import 'package:tokoto/pages/logged_in_user_pages/account_page.dart';
import 'package:tokoto/pages/logged_in_user_pages/faq_page.dart';
import 'package:tokoto/pages/logged_in_user_pages/settings_page.dart';
import 'package:tokoto/pages/login_page.dart';
import 'package:tokoto/responsive/responsive_extension.dart';
import 'package:tokoto/services/auth_service.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  Future<void> _pickAndCropImage(
      ImageSource source, BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9,
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            minimumAspectRatio: 1.0,
          ),
        ],
      );

      if (croppedFile != null) {
        File file = File(croppedFile.path);
        String result = await userController.uploadFileToStorage(file);
        if (result == "Success") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Image uploaded successfully')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to upload image')),
          );
        }
      } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No image selected')),
          );
      }
    } else {
       ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No image selected')),
          );
    }
  }

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
                child: Text("Profile".tr)),
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
                        showModalBottomSheet(
                          backgroundColor: Colors.orange[50],
                          context: context,
                          builder: (builder) {
                            return Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height / 4.5,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () async {
                                          Navigator.of(context).pop();
                                          await _pickAndCropImage(
                                              ImageSource.gallery, context);
                                        },
                                        child: const SizedBox(
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.image,
                                                size: 70,
                                              ),
                                              Text("Gallery")
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () async {
                                          Navigator.of(context).pop();
                                          await _pickAndCropImage(
                                              ImageSource.camera, context);
                                        },
                                        child: const SizedBox(
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.camera_alt,
                                                size: 70,
                                              ),
                                              Text("Camera")
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
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
                  title: 'My Account'.tr, iconData: Icons.person_outline),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AccountPage();
                }));
              },
            ),
            SizedBox(height: 2.sh()),
            ItemProfile(
                title: 'Notifications'.tr,
                iconData: Icons.notifications_outlined),
            SizedBox(height: 2.sh()),
            GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SettingsPage();
                  }));
                },
                child: ItemProfile(
                    title: 'Settings'.tr, iconData: Icons.settings)),
            SizedBox(height: 2.sh()),
            GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FAQPage();
                  }));
                },
                child: ItemProfile(
                    title: 'Help Center'.tr, iconData: Icons.question_mark)),
            SizedBox(
              height: 2.sh(),
            ),
            GestureDetector(
                child: ItemProfile(title: 'Log Out'.tr, iconData: Icons.logout),
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
