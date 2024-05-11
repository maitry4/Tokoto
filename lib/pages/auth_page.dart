import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tokoto/pages/home_page.dart';
import 'package:tokoto/pages/login_page.dart';
import 'package:tokoto/pages/onboarding_screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // logged in
            if(snapshot.hasData) {
              final email = snapshot.data!.email!;
                return const HomePage();
                }
            else {
              return const LoginPage();
            }
            }
              
          ));
  }
}