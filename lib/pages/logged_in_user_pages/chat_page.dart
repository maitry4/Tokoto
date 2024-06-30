import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:tokoto/components/custom_button.dart';
import 'package:tokoto/responsive/responsive_extension.dart';


class ChatPage extends StatefulWidget {

   ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ChatUser myself = ChatUser(id: "1", firstName: "Shivangi");
  ChatUser bot = ChatUser(id: "2", firstName: "bot");
  List<ChatMessage> allMessages = [];
  List<ChatUser> typing=[];
  final ourUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=YOUR_API_KEY";
  final header = {'Content-Type': 'application/json'};

  Future<void> fetchData(ChatMessage message) async {
    try {
      typing.add(bot);
      allMessages.insert(0, message);
      setState(() {});
      var data = {
        "contents": [
          {"parts": [{"text":message.text}]}
        ]
      };
      final response =
          await http.post(Uri.parse(ourUrl), headers: header, body: jsonEncode(data));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print("Response: ${result["candidates"][0]["content"]['parts'][0]["text"]}");
        ChatMessage m1 = ChatMessage(user: bot, createdAt:DateTime.now(),
        text: "${result ["candidates"][0]["content"]['parts'][0]["text"]}",
        );
        allMessages.insert(0, m1);
        
      } else {
        print("Failed to fetch data. Error code: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception occurred: $e");
    }
    typing.remove(bot);
    setState(() {
          
        });
  }
  String apiKey = "";

  @override
  Widget build(BuildContext context) {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
  );
  final prompt = 'Write a story about a magic backpack.';
  final content = [Content.text(prompt)];
  
  getResponse()async{
    print("getting response...");
    GenerateContentResponse response = await model.generateContent(content);
    return response.text;
  }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding:  EdgeInsets.symmetric(horizontal:37.sw()),
          child: Text("Chat"),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal:5.sw(), vertical:2.sh()),
        child: DashChat(
          typingUsers: typing,
          currentUser: myself,
          onSend: (ChatMessage m) {
            fetchData(m);
          },
          messages: allMessages,
        ),
      ),
    );
  }
}
