class MyProduct {
  final String name;
  final String price;
  final String image_path;
  final String description;
  final String reviews;
  final String cart_count;
  final String purchase_count;
  final String wish_list_count;
  MyProduct({
    this.name = "",
    this.price = "",
    this.image_path = "",
    this.description = "",
    this.reviews = "",
    this.cart_count = "",
    this.purchase_count = "",
    this.wish_list_count = "",
  });
  static MyProduct? fromMap(Map map) {
    return MyProduct(
      name: map["Name"],
      price: map["Price"],
      image_path: map["Product_Image"],
      description: map["Description"],
      reviews: map["Reviews"],
      cart_count: map["cart_count"],
      purchase_count: map["purchase_count"],
      wish_list_count: map["wish_list_count"]
    );
  }
}
