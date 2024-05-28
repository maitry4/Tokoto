import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:tokoto/models/auth_model.dart";
import "package:tokoto/models/category_model.dart";
import "package:tokoto/services/database_services.dart";

class UserProvider extends ChangeNotifier {
  String emailId = FirebaseAuth.instance.currentUser!.email!;
  List? wishList;
  List? cartList;
  MyUser? userData;
  UserProvider() {
    initializeData();
    notifyListeners();
  }

  Future<void> initializeData() async {
    String emailId = FirebaseAuth.instance.currentUser!.email!;
    // get user data
    userData = await MyUser.fromSnap(await DataBaseService().getUserData(
        collection: "Users", documentID: emailId));
    await getCartList();
    await getWishList();
    notifyListeners(); // Notify listeners after data initialization
  }
  Future<void> getWishList() async {
    wishList = userData!.wishlist;
  }
  Future<void> getCartList() async {
    cartList = userData!.cartList;
  }
  Future<String> addToWishList(MyProduct prod) async {
    // Check if the product already exists in the wishList
    bool exists = wishList!.any((item) => item["name"] == prod.name && item["price"] == prod.price && item["image_path"] == prod.image_path);
    if(!exists){
      try {
        wishList!.add({"name":prod.name, "price":prod.price, "image_path":prod.image_path});
        
        try {
          await DataBaseService().updateDocument(collection: "Users", documentID: emailId, setOfValues: {"Wishlist":FieldValue.arrayUnion([{"name":prod.name, "price":prod.price, "image_path":prod.image_path}])});
          notifyListeners(); 
        } catch(e){
          return "database";
        }
        return "Success";
      }catch (e) {
        return "wrong";
      }
    }else{
      return "exists";
    }
    
  }
  Future<String> removeFromWishList(MyProduct prod) async {
    try {
    // Remove the product from the wishList
    wishList!.removeWhere((item) => item["name"] == prod.name && item["price"] == prod.price && item["image_path"] == prod.image_path);
    
    try {
      // Update the document in the database
      await DataBaseService().updateDocument(
        collection: "Users",
        documentID: emailId,
        setOfValues: {
          "Wishlist": FieldValue.arrayRemove([{"name": prod.name, "price": prod.price, "image_path": prod.image_path}])
        }
      );
      notifyListeners();
    } catch (e) {
      return e.toString();
    }
    
    return "Success";
  } catch (e) {
    return e.toString();
  }

  }
  
  Future<String> addToCart(MyProduct prod) async {
    try {
      var existingItem = cartList!.firstWhere(
        (item) => item["name"] == prod.name && item["price"] == prod.price && item["image_path"] == prod.image_path,
        orElse: () => null,
      );
      
      if (existingItem != null) {
        existingItem["quantity"] += 1;

      } else {
        cartList!.add({"name": prod.name, "price": prod.price, "image_path": prod.image_path, "quantity": 1});
      }

      try{
        await DataBaseService().updateDocument(
        collection: "Users",
        documentID: emailId,
        setOfValues: {"Shopping-Cart": cartList},
        );
      } catch(e) {
        return "database";
      }

      notifyListeners();
      return "Success";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> removeFromCart(MyProduct prod) async {
    try {
      var existingItem = cartList!.firstWhere(
        (item) => item["name"] == prod.name && item["price"] == prod.price && item["image_path"] == prod.image_path,
        orElse: () => null,
      );

      if (existingItem != null) {
        existingItem["quantity"] -= 1;
        if (existingItem["quantity"] <= 0) {
          cartList!.remove(existingItem);
        }

        try{await DataBaseService().updateDocument(
          collection: "Users",
          documentID: emailId,
          setOfValues: {"Shopping-Cart": cartList}
        );}catch(e) {
          return "database";
        }

        notifyListeners();
        return "Success";
      } else {
        return "not_found";
      }
    } catch (e) {
      return e.toString();
    }
  }
  int getProductQuantity(String productName) {
  var product = cartList?.firstWhere(
    (item) => item["name"] == productName,
    orElse: () => null,
  );
  return product != null ? product["quantity"] : 0;
}
void clearUserData() {
    emailId = "";
    wishList = [];
    cartList = [];
    userData = null;
    // notifyListeners();
  }

}