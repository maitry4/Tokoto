import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'.tr, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset("assets/faq_img.jpg"),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  buildQuestionTile("How can I provide feedback or suggest...".tr, "You can provide feedback or suggestions by contacting our support team through the contact form on our website.".tr),
                  buildQuestionTile("Is there a free trial available?".tr, "Yes, we offer a 7-day free trial for all new users. You can sign up on our website to start your free trial.".tr),
                  buildQuestionTile("How can I contact customer support?".tr, "You can contact customer support through our support email at support@example.com or call us at 1-800-123-4567.".tr),
                  buildQuestionTile("What payment methods do you accept?".tr, "We accept various payment methods including credit cards, PayPal, and bank transfers.".tr),
                  buildQuestionTile("Can I upgrade or downgrade my plan?".tr, "Yes, you can upgrade or downgrade your plan at any time through your account settings.".tr),
                  buildQuestionTile("Is my personal information secure?".tr, "Yes, we take your privacy and security very seriously. All personal information is encrypted and securely stored.".tr),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildQuestionTile(String question, String answer) {
    return Padding(
      padding: EdgeInsets.all(2.sw()),
      child: ExpansionTile(
        title: Text(question),
        children: [
          Padding(
            padding:  EdgeInsets.all(5.sw()),
            child: Text(answer),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Color.fromARGB(255, 255, 117, 67)),
        ),
        tilePadding: EdgeInsets.symmetric(vertical: 2.sh(), horizontal: 10.sw()),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.black),
        ),
        collapsedBackgroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 255, 251, 246),
      ),
    );
  }
}