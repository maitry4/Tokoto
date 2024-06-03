class MyProduct {
  final String name;
  final String price;
  final String image_path;
  final String description;
  final String reviews;
  final String cart_count;
  final String purchase_count;
  final String wish_list_count;
  final String discount_percent;

  MyProduct({
    this.name = "",
    this.price = "",
    this.image_path = "",
    this.description = "",
    this.reviews = "",
    this.cart_count = "",
    this.purchase_count = "",
    this.wish_list_count = "",
    this.discount_percent = "",
  });

  // Method to convert MyProduct instance to a Map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'image_path': image_path,
    };
  }

  static MyProduct? fromMap(Map map) {
    return MyProduct(
      name: map["Name"],
      price: map["Price"],
      image_path: map["Product_Image"],
      description: map["Description"],
      reviews: map["Reviews"],
      cart_count: map["cart_count"],
      purchase_count: map["purchase_count"],
      wish_list_count: map["wish_list_count"],
      discount_percent: map["discount_percent"]
    );
  }

  // Find a product by its name
  static MyProduct? findProductByName(List<MyProduct> products, String name) {
    return products.firstWhere(
      (product) => product.name == name,
      orElse: () => MyProduct(),
    );
  }
}
