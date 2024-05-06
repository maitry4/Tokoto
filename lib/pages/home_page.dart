import "package:flutter/material.dart";
import "package:tokoto/pages/login_page.dart";
import "package:tokoto/services/auth_service.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              await AuthService().logout();
              // Redirect to login page or any other page after logout
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return LoginPage();
              }));
            } catch (e) {
              // Handle error
              print("Logout error: $e");
            }
          },
          child: Text("Logout"),
        ),
      ),
    );
  }
}
