import 'package:get/get.dart';

class MySearchController extends GetxController {
  // Define an observable variable to hold search results
  List<String> searchResults = [];

  // Method to perform search
  void search(String query, List<String> allProducts) {
    // Clear previous search results
    searchResults.clear();
    // Filter products based on the search query
    if (query.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      searchResults = allProducts;
    } else {
      for (String item in allProducts) {
        if (item.toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(item);
        }
      }
    }
  }
}
