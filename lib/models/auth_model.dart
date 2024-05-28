import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tokoto/models/category_model.dart';

class MyUser {
  final String fullnm;
  final String username;
  final String phone_num;
  final String address;
  final String profile_pic;
  final String gen;
  final String langPref;
  final String role;
  final Map order_his;
  final List cartList;
  final List wishlist;
  MyUser({
    this.fullnm = "",
    this.username = "",
    this.phone_num = "",
    this.address = "",
    this.profile_pic = "",
    this.gen = "",
    this.role = "",
    this.langPref = "",
    this.order_his = const{},
    this.cartList = const[],
    this.wishlist = const[],
  });

  static MyUser? fromSnap(DocumentSnapshot snap) {
  if (snap.exists) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return MyUser(
      username: snapshot["username"],      
      fullnm: snapshot["Full-Name"],
      gen: snapshot["Gender"],
      address: snapshot["Primary-Address"],
      phone_num: snapshot["Phone-Number"],
      order_his: snapshot["Order-History"],
      wishlist: snapshot["Wishlist"],
      cartList: snapshot["Shopping-Cart"],
      role: snapshot["Role"],
      profile_pic: snapshot["Profile-Picture"],
      langPref: snapshot["Language-Preference"],
    );
  }
  return null;
}

}