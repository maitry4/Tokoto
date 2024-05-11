import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tokoto/responsive/responsive_extension.dart';
import 'package:tokoto/services/database_services.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String userID = FirebaseAuth.instance.currentUser!.email!;
  Map<String, dynamic> data ={"username":""};
  void getUserData() async {
    final temp_data = await DataBaseService().fetchData(collection: "Users", documentID: userID);
    setState(() {
    data = temp_data; 
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:SizedBox(
      child: ListView(
        children: [
          Row(
            children: [
              Text("Username: "),
              Text(data["username"]),
              IconButton(onPressed: () {}, icon: Icon(Icons.edit, size: 4.sw(),))
            ],
          ),
          
        ]
      ),
    )
    );
  }
}