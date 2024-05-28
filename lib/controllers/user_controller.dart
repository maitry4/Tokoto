import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tokoto/models/auth_model.dart';
import 'package:tokoto/models/category_model.dart';
import 'package:tokoto/services/database_services.dart';

class UserController extends GetxController {
  var emailId = FirebaseAuth.instance.currentUser!.email!.obs;
  var wishList = RxList<dynamic>();
  var cartList = RxList<dynamic>();
  var userData = Rxn<MyUser>();

  UserController() {
    initializeData();
  }

  Future<void> initializeData() async {
    String emailId = FirebaseAuth.instance.currentUser!.email!;
    // get user data
    userData.value = await MyUser.fromSnap(await DataBaseService().getUserData(
        collection: "Users", documentID: emailId));
    await getCartList();
    await getWishList();
  }

  Future<void> getWishList() async {
    wishList.value = userData.value!.wishlist;
  }

  Future<void> getCartList() async {
    cartList.value = userData.value!.cartList;
  }

  Future<String> addToWishList(MyProduct prod) async {
    bool exists = wishList.any((item) => item["name"] == prod.name && item["price"] == prod.price && item["image_path"] == prod.image_path);
    if(!exists){
      try {
        wishList.add({"name":prod.name, "price":prod.price, "image_path":prod.image_path});
        update();
        try {
          await DataBaseService().updateDocument(collection: "Users", documentID: emailId.value, setOfValues: {"Wishlist":FieldValue.arrayUnion([{"name":prod.name, "price":prod.price, "image_path":prod.image_path}])});
        } catch(e){
          return "database";
        }
        return "Success";
      } catch (e) {
        return "wrong";
      }
    } else {
      return "exists";
    }
  }

  Future<String> removeFromWishList(MyProduct prod) async {
    try {
      wishList.removeWhere((item) => item["name"] == prod.name && item["price"] == prod.price && item["image_path"] == prod.image_path);
      update();
      try {
        await DataBaseService().updateDocument(
          collection: "Users",
          documentID: emailId.value,
          setOfValues: {
            "Wishlist": FieldValue.arrayRemove([{"name": prod.name, "price": prod.price, "image_path": prod.image_path}])
          }
        );
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
      var existingItem = cartList.firstWhere(
        (item) => item["name"] == prod.name && item["price"] == prod.price && item["image_path"] == prod.image_path,
        orElse: () => null,
      );
      var existingItemIndex = cartList.indexWhere(
      (item) =>
          item["name"] == prod.name &&
          item["price"] == prod.price &&
          item["image_path"] == prod.image_path,
    );
      if (existingItem != null) {
        existingItem["quantity"] += 1;
        cartList[existingItemIndex] = existingItem;
      } else {
        cartList.add({"name": prod.name, "price": prod.price, "image_path": prod.image_path, "quantity": 1});
      }
      update();
      try {
        await DataBaseService().updateDocument(
          collection: "Users",
          documentID: emailId.value,
          setOfValues: {"Shopping-Cart": cartList}
        );
      } catch (e) {
        return "database";
      }

      return "Success";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> removeFromCart(MyProduct prod) async {
    try {
      var existingItem = cartList.firstWhere(
        (item) => item["name"] == prod.name && item["price"] == prod.price && item["image_path"] == prod.image_path,
        orElse: () => null,
      );
      var existingItemIndex = cartList.indexWhere(
      (item) =>
          item["name"] == prod.name &&
          item["price"] == prod.price &&
          item["image_path"] == prod.image_path,
    );

      if (existingItem != null) {
        existingItem["quantity"] -= 1;
        cartList[existingItemIndex] = existingItem;
        if (existingItem["quantity"] <= 0) {
          cartList.remove(existingItem);
        }
        update();
        try {
          await DataBaseService().updateDocument(
            collection: "Users",
            documentID: emailId.value,
            setOfValues: {"Shopping-Cart": cartList}
          );
        } catch (e) {
          return "database";
        }

        return "Success";
      } else {
        return "not_found";
      }
    } catch (e) {
      return e.toString();
    }
  }

  int getProductQuantity(String productName) {
    var product = cartList.firstWhere(
      (item) => item["name"] == productName,
      orElse: () => null,
    );
    return product != null ? product["quantity"] : 0;
  }

  void clearUserData() {
    emailId.value = "";
    wishList.clear();
    cartList.clear();
    userData.value = null;
  }
}
