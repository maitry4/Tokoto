import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';
import 'package:tokoto/components/custom_button.dart';
import 'package:tokoto/controllers/user_controller.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Page'.tr),
        automaticallyImplyLeading: false,
      ),
      body:Text("Chat"),
    );
  }
}
