import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  Future<String?> registration({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = await FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      return 'Success';
    }
    // authentication errors
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('weak password');
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        print("******");
        print('email-already-in-use');
        return 'The account already exists for that email.';
      } else {
        print("******");
        print(e);
        return e.message;
      }
    }
    // any other errors
    catch (e) {
      print("******");
      print(e.toString());
      return e.toString();
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return 'Success';

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print("Error logging out: $e");
      throw e; // You can handle the error as per your requirement
    }
  }

  Future<String> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return "Success";
    } catch (e) {
      return e.toString();
    }
  }
}
