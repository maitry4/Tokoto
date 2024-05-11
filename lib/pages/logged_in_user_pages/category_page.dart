import 'package:flutter/material.dart';
import 'package:tokoto/responsive/responsive_extension.dart';
import 'package:tokoto/services/database_services.dart';

class CategoryPage extends StatefulWidget {
  final String category;
  const CategoryPage({super.key, required this.category});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List keys = [];
  List images = [];
  void getProducts() {
    Future<Map<String, dynamic>> data = DataBaseService()
        .fetchData(collection: "Categories", documentID: widget.category);

    data.then((map) {
      setState(() {
        keys = map.keys.toList();
        keys.remove("Banner_Image");
      });
      print(keys); // This will print the list of keys

      // Create a list of futures to populate the images list
      List<Future> futures = [];
      keys.forEach((key) {
        futures.add(data.then((map) {
          setState(() {
            images.add(map[key]["Product_Image"]);
          });
        }));
      });

      // Wait for all futures to complete before printing images
      Future.wait(futures).then((_) {
        print(images);
      });
    }).catchError((error) {
      print("Error fetching map: $error");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.sw()),
            child: Text(widget.category),
          ),
        ),
        body: GridView.builder(
          padding: EdgeInsets.symmetric(vertical: 4.sh(), horizontal: 2.sw()),
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.91,),
          itemCount: keys.length, // Use keys.length here
          itemBuilder: (context, index) {
            if (keys.isEmpty) {
              // Display a loading indicator or an empty container
              return CircularProgressIndicator(); // Example of a loading indicator
            } else {
              // Access keys only if it's not empty
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.sh()),
                    image: DecorationImage(
                      image: NetworkImage(images[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(child: Text(keys[index])),
                ),
              );
            }
          },
        ));
  }
}
