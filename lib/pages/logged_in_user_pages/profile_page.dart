import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tokoto/components/custom_icon.dart';
import 'package:tokoto/pages/logged_in_user_pages/account_page.dart';
import 'package:tokoto/pages/login_page.dart';
import 'package:tokoto/responsive/responsive_extension.dart';
import 'package:tokoto/services/auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:async';
import 'dart:typed_data';

import 'package:tokoto/services/database_services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String imageURL = "";
  Uint8List? _file;
  
  void initialize_image() async {
    String? useremail = FirebaseAuth.instance.currentUser!.email;

    try {
      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection('Users')
          .doc(useremail)
          .get();
      String image = (snap.data()! as dynamic)['Profile-Picture'];
      print(image);
      print("hgkjbhhk");
      setState(() {
        imageURL = image;
      });
    } catch (e) {
      //  show error whatever it might be
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error loading profile"),
        ),
      );
    }
    
  }

  @override
  void initState() {
    super.initState();
    // Initialization code here
    initialize_image();
  }

  itemProfile(String title, IconData iconData) {
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

  void uploadFileToStorage(resFile) async {
    User? user = FirebaseAuth.instance.currentUser;
    // Show circular progress indicator
    if (resFile != null) {
      File file = File(resFile.files.single.path!);
      String fileName = user!.email!;
      fileName = "$fileName.jpg";
      print(fileName); // Get the file name

      // Show circular progress indicator
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent dialog dismissal
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20.0),
                  Text("Uploading file...\nIt may take a while"),
                ],
              ),
            ),
          );
        },
      );

      try {
        // Upload file to Firebase Storage
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('profile_pics/$fileName');
        firebase_storage.UploadTask uploadTask = ref.putFile(file);

        // Track the upload task and get the download URL after upload is complete
        uploadTask.whenComplete(() async {
          try {
            String downloadURL = await ref.getDownloadURL();
            // Update UI with download URL
            setState(() {
              imageURL = downloadURL;
            });
            // update path in database
            String message = await DataBaseService().updateDocument(
                collection: 'Users',
                documentID: user.email!,
                setOfValues: {"Profile-Picture": imageURL});

            if (message == 'Success') {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("File path updated"),
                duration: Duration(seconds: 2),
              ));
            } else {
 
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(message),
                duration: Duration(seconds: 2),
              ));
              return;
            }
            print(
                'File uploaded to Firebase Storage. Download URL: $downloadURL');

            // Dismiss circular progress indicator
            Navigator.of(context).pop();

            
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("File successfully uploaded"),
              duration: Duration(seconds: 2),
            ));
          } catch (error) {
            print("Error getting download URL: $error");
            // Dismiss circular progress indicator
            Navigator.of(context).pop();

            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Failed to get download URL"),
              duration: Duration(seconds: 2),
            ));
          }
        });
      } catch (error) {
        print("Error uploading file: $error");
        // Dismiss circular progress indicator
        Navigator.of(context).pop();

        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Failed to upload file"),
          duration: Duration(seconds: 2),
        ));
      }
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("No file selected"),
        duration: Duration(seconds: 2),
      ));
    }
  }

  void selectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    try {
      uploadFileToStorage(result);
    } catch (e) {
      print(e.toString());
    }
  }

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
                  imageURL.isNotEmpty
                      ? CircleAvatar(
                          radius: 17.sw(),
                          backgroundImage: NetworkImage(imageURL),
                        )
                      : CircleAvatar(
                          radius: 17.sw(),
                          backgroundImage: NetworkImage(
                            'https://cdn.pixabay.com/photo/2020/11/10/01/34/pet-5728249_640.jpg',
                          ),
                        ),
                  Positioned(
                    child: IconButton(
                      onPressed: selectImage,
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
              child: itemProfile('My Account', Icons.person_outline),
              onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const AccountPage();
                    }));
              },
            ),
            SizedBox(height: 2.sh()),
            itemProfile('Notifications', Icons.notifications_outlined),
            SizedBox(height: 2.sh()),
            itemProfile('Settings', Icons.settings),
            SizedBox(height: 2.sh()),
            itemProfile('Help Center', Icons.question_mark),
            SizedBox(
              height: 2.sh(),
            ),
            GestureDetector(
                child: itemProfile('Log Out', Icons.logout),
                onTap: () async {
                  try {
                    await AuthService().logout();
                    // Redirect to login page or any other page after logout
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return const LoginPage();
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
