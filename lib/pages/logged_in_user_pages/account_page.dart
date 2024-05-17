import "package:flutter/material.dart";
import "package:provider/provider.dart";
import 'package:tokoto/providers/user_provider.dart';
import "package:tokoto/responsive/responsive_extension.dart";
import "package:tokoto/services/database_services.dart";

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // final res = DataBaseService().getUserData(collection: "Users", documentID: "maitryparikh23@gmail.com");
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder:(context, value, child)=>
       Scaffold(
         body: SizedBox(
           child: ListView(
             children: [
              
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text("Username: "),
                      Text(value.userData!.username),
                      IconButton(onPressed: () {}, icon: Icon(Icons.edit, size: 4.sw(),))
                    ],
                  ),
                )
               
             ],
           ),
         ),
       )
       );
  }
}