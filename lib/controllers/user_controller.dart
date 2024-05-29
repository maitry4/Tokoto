import 'dart:io';

import 'package:file_picker/file_picker.dart';
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
  var userData = Rxn<MyUser>();
  var profileImageURL = ''.obs;

  Future<void> initializeData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      emailId.value = user.email ?? '';
      // get user data
      userData.value = await MyUser.fromSnap(await DataBaseService().getUserData(
          collection: "Users", documentID: user.email!));
      await getCartList();
      await getWishList();
      await initializeProfileImage();
    }
  }

  Future<void> getWishList() async {
    wishList.value = userData.value!.wishlist;
  }

  Future<void> getCartList() async {
    cartList.value = userData.value!.cartList;
  }
  Future<void> initializeProfileImage() async {
    String email = FirebaseAuth.instance.currentUser!.email!;
    try {
      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection('Users')
          .doc(email)
          .get();
      String image = (snap.data()! as dynamic)['Profile-Picture'];
      profileImageURL.value = image;
    } catch (e) {
      Get.snackbar("Error", "Error loading profile picture");
    }
  }

  Future<String> uploadFileToStorage(FilePickerResult? resFile) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (resFile != null) {
      File file = File(resFile.files.single.path!);
      String fileName = user!.email!;
      fileName = "$fileName.jpg";

      try {
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('profile_pics/$fileName');
        firebase_storage.UploadTask uploadTask = ref.putFile(file);

        uploadTask.whenComplete(() async {
          try {
            String downloadURL = await ref.getDownloadURL();
            profileImageURL.value = downloadURL;
            await DataBaseService().updateDocument(
                collection: 'Users',
                documentID: user.email!,
                setOfValues: {"Profile-Picture": profileImageURL.value});
          } catch (error) {
            return "Failed to get download URL";
          }
        });
          return "Success";
      } catch (error) {
        return "Failed to upload file";
      }
    } else {
      return "No file selected";
    }
  }

  Future<String> selectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final res =await uploadFileToStorage(result);
      if(res =="Success") {
        return "Success";
      }
      else if(res == "Failed to get download URL") {
        return "Failed to get download URL";
      }
      else if(res == "Failed to upload file") {
        return "Failed to upload file";
      }
      else{
        return "No file selected";
      }

    } else {
      return "File selection cancelled";
    }
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
