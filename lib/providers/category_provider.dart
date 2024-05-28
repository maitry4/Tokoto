import "package:flutter/material.dart";
import "package:tokoto/models/category_model.dart";
import "package:tokoto/services/database_services.dart";

class CategoryProvider extends ChangeNotifier {
  List<Map<String, dynamic>> categories = [];
  List<String> keys = [];
  List<String> images = [];
  List<String> prices = [];
  Map<String, List> allProducts = {};

  CategoryProvider() {
    getCategories();
    getAllProducts();
    notifyListeners();
  }
  Future<void>  initializeData() async {
    await getCategories();
    await getAllProducts();
    notifyListeners();
  }
  Future<void>  getCategories() async {
    // all categories
    categories = await DataBaseService().fetchDocumentsWithBanner(collection:"Categories");
  }

  void getProducts(String category) async {
    // Category Specific products.
  try {
    keys.clear();
    images.clear();
    prices.clear();
    Map<String, dynamic> data = await DataBaseService().fetchData(
      collection: "Categories",
      documentID: category,
    );

    keys.addAll(data.keys.where((key) => key != "Banner_Image"));
    for (String key in keys) {
      images.add(data[key]["Product_Image"]);
      prices.add(data[key]["Price"]);
    }

    notifyListeners();
  } catch (error) {
    print("Error fetching map: $error");
  }
}
  Future<bool> getAllProducts() async {
  // all products list.
    List all_categories = await DataBaseService().fetchDocumentsWithBanner(collection:"Categories");

    for(int i = 0; i < all_categories.length; i++) {

      final l = [];

      final data = await DataBaseService().fetchData(
      collection: "Categories",
      documentID: all_categories[i]["name"],
    );

    data.forEach((k,v){
      if(k!="Banner_Image"){
       l.add(MyProduct.fromMap(v));
      }
    });

      allProducts[all_categories[i]["name"]] = l;
    }
    notifyListeners();
    return true;
  }
}
