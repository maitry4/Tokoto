import 'dart:io';

import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tokoto/models/auth_model.dart';
import 'package:tokoto/models/category_model.dart';
import 'package:tokoto/services/database_services.dart';

class UserController extends GetxController {
  var emailId = "".obs;
  var wishList = RxList<dynamic>();
  var cartList = RxList<dynamic>();
  var orderList = RxList<dynamic>();
  var userData = Rxn<MyUser>();
  var profileImageURL = ''.obs;

  @override
  void onInit() {
    super.onInit();
    initializeData();
  }

  Future<void> initializeData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      emailId.value = user.email ?? '';
      // get user data
      userData.value = await MyUser.fromSnap(await DataBaseService()
          .getUserData(collection: "Users", documentID: user.email!));
      await getCartList();
      await getWishList();
      await getOrderList();
      await initializeProfileImage();
    }
  }

  void updatePoints(newPoints) async {
    String email = await FirebaseAuth.instance.currentUser!.email!;
    DataBaseService().updateDocument(
        collection: "Users",
        documentID: email,
        setOfValues: {"Points": newPoints});
    userData.value = await MyUser.fromSnap(await DataBaseService()
        .getUserData(collection: "Users", documentID: email));
    update();
  }

  Future<void> getWishList() async {
    wishList.value = userData.value!.wishlist;
  }

  Future<void> getCartList() async {
    cartList.value = userData.value!.cartList;
  }

  Future<void> getOrderList() async {
    orderList.value = userData.value!.order_his;
  }

  Future<void> initializeProfileImage() async {
    String email = FirebaseAuth.instance.currentUser!.email!;
    try {
      DocumentSnapshot snap =
          await FirebaseFirestore.instance.collection('Users').doc(email).get();
      String image = (snap.data()! as dynamic)['Profile-Picture'];
      profileImageURL.value = image;
    } catch (e) {
      Get.snackbar("Error", "Error loading profile picture");
    }
  }

  Future<void> updateData(String field, String value) async {
    String email = await FirebaseAuth.instance.currentUser!.email!;
    await DataBaseService().updateDocument(
        collection: "Users", documentID: email, setOfValues: {field: value});
    // get user data
    userData.value = await MyUser.fromSnap(await DataBaseService()
        .getUserData(collection: "Users", documentID: email));
    update();
  }

  Future<String> uploadFileToStorage(File file) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (file != null && user != null) {
      String fileName = "${user.email}.jpg";

      try {
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('profile_pics/$fileName');
        firebase_storage.UploadTask uploadTask = ref.putFile(file);

        await uploadTask;
        String downloadURL = await ref.getDownloadURL();
        profileImageURL.value = downloadURL;

        await DataBaseService().updateDocument(
            collection: 'Users',
            documentID: user.email!,
            setOfValues: {"Profile-Picture": profileImageURL.value});

        return "Success";
      } catch (error) {
        print(error);
        return "Failed to upload file";
      }
    } else {
      return "No file selected or user not logged in";
    }
  }

  Future<String> addToWishList(MyProduct prod) async {
    bool exists = wishList.any((item) =>
        item["name"] == prod.name &&
        item["price"] == prod.price &&
        item["image_path"] == prod.image_path);
    if (!exists) {
      try {
        wishList.add({
          "name": prod.name,
          "price": prod.price,
          "image_path": prod.image_path
        });
        update();
        try {
          await DataBaseService().updateDocument(
              collection: "Users",
              documentID: emailId.value,
              setOfValues: {
                "Wishlist": FieldValue.arrayUnion([
                  {
                    "name": prod.name,
                    "price": prod.price,
                    "image_path": prod.image_path
                  }
                ])
              });
        } catch (e) {
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
      wishList.removeWhere((item) =>
          item["name"] == prod.name &&
          item["price"] == prod.price &&
          item["image_path"] == prod.image_path);
      update();
      try {
        await DataBaseService().updateDocument(
            collection: "Users",
            documentID: emailId.value,
            setOfValues: {
              "Wishlist": FieldValue.arrayRemove([
                {
                  "name": prod.name,
                  "price": prod.price,
                  "image_path": prod.image_path
                }
              ])
            });
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
        (item) =>
            item["name"] == prod.name &&
            item["price"] == prod.price &&
            item["image_path"] == prod.image_path,
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
        cartList.add({
          "name": prod.name,
          "price": prod.price,
          "image_path": prod.image_path,
          "quantity": 1
        });
      }
      update();
      try {
        await DataBaseService().updateDocument(
            collection: "Users",
            documentID: emailId.value,
            setOfValues: {"Shopping-Cart": cartList});
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
        (item) =>
            item["name"] == prod.name &&
            item["price"] == prod.price &&
            item["image_path"] == prod.image_path,
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
              setOfValues: {"Shopping-Cart": cartList});
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

  Future<String> placeOrder() async {
    try {
      print(orderList);
      print(cartList);
      if (orderList.isEmpty) {
        orderList = cartList;
      } else {
        try {
          for (var cartItem in cartList) {
            var existingItemIndex = orderList.indexWhere(
                (orderItem) => orderItem['name'] == cartItem['name']);
            if (existingItemIndex != -1) {
              // If the item exists in the order list, update its quantity
              orderList[existingItemIndex]['quantity'] += cartItem['quantity'];
            } else {
              // If the item doesn't exist in the order list, add it
              orderList.add(cartItem);
            }
          }
        } catch (e) {
          print(e);
          return "error";
        }
      }
      cartList = [].obs;
      try {
        await DataBaseService().updateDocument(
            collection: "Users",
            documentID: emailId.value,
            setOfValues: {
              "Order-History": orderList.value,
              "Shopping-Cart": []
            });
      } catch (e) {
        return "database";
      }
      getCartList();
      getOrderList();
      update();
      return "Success";
    } catch (e) {
      return "Something went wrong.";
    }
  }
}
