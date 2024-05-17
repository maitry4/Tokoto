import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:tokoto/models/auth_model.dart";
import "package:tokoto/services/database_services.dart";

class UserProvider extends ChangeNotifier {
  String emailId = FirebaseAuth.instance.currentUser!.email!;
  MyUser? userData;
  UserProvider() {
    initializeData();
  }

  Future<void> initializeData() async {
    // get user data
    userData = await MyUser.fromSnap(await DataBaseService().getUserData(
        collection: "Users", documentID: emailId));
    notifyListeners(); // Notify listeners after data initialization
  }
  // updating image on profile page should also be done from here.
  // wishlist and cart would need data from here.
}