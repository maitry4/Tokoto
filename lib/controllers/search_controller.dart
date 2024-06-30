import 'package:get/get.dart';

class MySearchController extends GetxController {
  // Define an observable variable to hold search results
  List<String> searchResults = <String>[].obs;

  // Method to perform search
  void search(String query, List<String> allProducts) {
  searchResults.clear();  // This is okay to keep
  if (query.isEmpty) {
    searchResults.assignAll(allProducts);  // Use assignAll for full list
  } else {
    searchResults.addAll(allProducts.where((item) => item.toLowerCase().contains(query.toLowerCase())));  // Use addAll with filter
  }

  }
}
