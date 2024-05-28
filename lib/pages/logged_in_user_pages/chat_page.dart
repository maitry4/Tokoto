import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
    TextEditingController _textEditingController = TextEditingController();
  String _textFieldValue = '';

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Field Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _textEditingController,
              onChanged: (value) {
                setState(() {
                  _textFieldValue = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Enter some text',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Text Field Value: $_textFieldValue',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}