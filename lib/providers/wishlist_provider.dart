import 'package:flutter/material.dart';
import 'package:tokoto/models/auth_model.dart';

class WishListProvider extends ChangeNotifier {
  MyUser? userData;

  WishListProvider(this.userData);

  void updateUser(MyUser? newUserData) {
    userData = newUserData;
    notifyListeners(); // Notify listeners about the change
  }

  // Add methods to fetch wishlist, add to wishlist, delete from wishlist, etc.
}
