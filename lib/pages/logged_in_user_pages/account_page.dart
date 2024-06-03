import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokoto/controllers/user_controller.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class AccountPage extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text('Account Details'.tr),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _buildProfilePictureRow('Profile Picture'.tr, userController.profileImageURL.value),
              _buildInfoRow('Email'.tr, userController.emailId.toString(),Icon(Icons.person)),
              _buildEditableInfoRow('username'.tr, userController.userData.value?.username, context),
              _buildEditableInfoRow('Full-Name'.tr, userController.userData.value?.fullnm,context),
              _buildEditableInfoRow('Phone-Number'.tr, userController.userData.value?.phone_num, context),
              _buildEditableInfoRow('Primary-Address'.tr, userController.userData.value?.address, context),
              _buildInfoRow('Points'.tr, userController.userData.value!.points,Icon(Icons.star,)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, Icon icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
          IconButton(onPressed:(){}, icon: icon, ),
        ],
      ),
    );
  }

  Widget _buildEditableInfoRow(String label, String? value, context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value ?? ''),
          ),
          IconButton(
            onPressed: () {
              _showDialog(label,context);
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
    );
  }

  void _showDialog(String field, context) {
    String newValue = ''; // This will hold the new value entered by the user
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text('Edit'.tr+' $field'.tr),
        content: TextField(
          onChanged: (value) {
            newValue = value; // Update newValue as the user types
          },
          decoration: InputDecoration(hintText: 'Enter new $field'),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'.tr),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: Text('Save'.tr),
            onPressed: () async {
              await userController.updateData(field, newValue);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Successfully modified"),
                ),
              ); // Close the dialog
            },
          ),
        ],
      );
    });
  }

  Widget _buildProfilePictureRow(String label, String? imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 12.sw()),
          imageUrl != null
              ? CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    imageUrl,
                  ),
              )
              : Icon(Icons.account_circle, size: 50),
        ],
      ),
    );
  }
}
