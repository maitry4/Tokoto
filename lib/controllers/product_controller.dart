import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tokoto/models/category_model.dart';
import 'package:tokoto/services/database_services.dart';

class ProductController extends GetxController with GetTickerProviderStateMixin{
  late TabController tabController;
  var categories = <Map<String, dynamic>>[].obs;
  var keys = <String>[].obs;
  var images = <String>[].obs;
  var prices = <String>[].obs;
  var allProducts = <String, List<MyProduct>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    getCategories();
    getAllProducts();
  }

  Future<void> initializeData() async {
    await getCategories();
    await getAllProducts();
  }

  Future<void> getCategories() async {
    categories.value = await DataBaseService().fetchDocumentsWithBanner(collection: "Categories");
    tabController = TabController(vsync: this, length: categories.length);
  }

  Future<void> getProducts(String category) async {
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

      update();  // Equivalent to notifyListeners
    } catch (error) {
      print("Error fetching map: $error");
    }
  }

  Future<bool> getAllProducts() async {
    List all_categories = await DataBaseService().fetchDocumentsWithBanner(collection: "Categories");

    for (int i = 0; i < all_categories.length; i++) {
      final l = <MyProduct>[];

      final data = await DataBaseService().fetchData(
        collection: "Categories",
        documentID: all_categories[i]["name"],
      );

      data.forEach((k, v) {
        if (k != "Banner_Image") {
          l.add(MyProduct.fromMap(v)!);
        }
      });

      allProducts[all_categories[i]["name"]] = l;
    }
    update();  // Equivalent to notifyListeners
    return true;
  }
}
