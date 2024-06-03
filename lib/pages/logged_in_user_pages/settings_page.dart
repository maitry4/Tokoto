import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokoto/components/custom_button.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  final List<Map<String, dynamic>> locale = [
    {'name': 'ENGLISH', 'locale': Locale('en', 'US')},
    {'name': 'हिन्दी', 'locale': Locale('hi')},
    {'name': 'ગુજરાતી', 'locale': Locale('gu')}
  ];

  updateLanguage(Locale locale, BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale.languageCode);
    
    Get.updateLocale(locale);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Language Changed successfully".tr),
      ),
    );
  }

  buildDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Choose a Language".tr),
          content: Container(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    updateLanguage(locale[index]['locale'], context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(5.sw()),
                    child: Text(locale[index]['name']),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: locale.length,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomButtton(
        onTap: () {
          buildDialog(context);
        },
        text: "Change Language".tr,
      ),
    );
  }
}
