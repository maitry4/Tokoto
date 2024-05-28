import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokoto/components/custom_button.dart';
import 'package:tokoto/models/category_model.dart';
import 'package:tokoto/providers/category_provider.dart';
import 'package:tokoto/providers/user_provider.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class ProductDetailPage extends StatefulWidget {
  final String productName;
  const ProductDetailPage({super.key, required this.productName});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(builder: (context, value, child) {
      // Flattening all products from different categories into a single list
      List<MyProduct> allProductsList = [];
      value.allProducts.forEach((categoryName, products) {
        allProductsList.addAll(
            products.where((product) => product != null).cast<MyProduct>());
      });
      MyProduct? product =
          MyProduct.findProductByName(allProductsList, widget.productName);

      return Scaffold(
          appBar: AppBar(title: Text("Product Details")),
          body: Center(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(
                        vertical: 2.sh(), horizontal: 4.sw()),
                    children: [
                      Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  20) // Adjust the radius as needed
                              ),
                          child: Image.network(product!.image_path,
                              fit: BoxFit.cover)),
                      SizedBox(
                        height: 4.sh(),
                      ),
                      Text(
                        widget.productName,
                        style: TextStyle(fontSize: 25),
                      ),
                      SizedBox(
                        height: 1.sh(),
                      ),
                      Text("Description",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[900],
                              fontWeight: FontWeight.bold)),
                      Text(
                        product.description,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 3.sw(), vertical: 2.sh()),
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                  // price
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(product.price,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      Consumer<UserProvider>(
                          builder: (context, cartVal, child) {
                             int quantity = cartVal.getProductQuantity(product.name);
                        return Row(
                          children: [
                            // - button
                            Container(
                                child: IconButton(
                                    onPressed: () async {
                                      final res = await cartVal.removeFromCart(MyProduct(
                                          name: product.name,
                                          price: product.price,
                                          image_path: product.image_path));
                                      if(res == "Success"){
                                         ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text("Removed from cart"),
                                          ),
                                        );
                                      }
                                       else if(res=="database"){
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text("Database not modified"),
                                          ),
                                        );
                                      }
                                       else{
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text("Something went wrong"),
                                          ),
                                        );
                                      }
                                    },
                                    icon: Icon(Icons.remove_circle,
                                        color: Colors.white))),
                            // qty
                            Text(quantity.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            // Text(cartVal.cartList.toString()),
                            // + button
                            Container(
                                child: IconButton(
                                    onPressed: () async {
                                      final message = await cartVal.addToCart(
                                          MyProduct(
                                              name: product.name,
                                              price: product.price,
                                              image_path: product.image_path));
                                      print(message);
                                      if (message == "Success") {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text("Added to cart"),
                                          ),
                                        );
                                      }
                                      else if (message == "database") {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text("Database not modified"),
                                          ),
                                        );
                                      }
                                      else{
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text("Something went wrong"),
                                          ),
                                        );
                                      }
                                      print(cartVal.cartList);
                                    },
                                    icon: Icon(Icons.add_circle,
                                        color: Colors.white))),
                          ],
                        );
                      }),
                    ],
                  ),
                  // add to cart
                ),
              ],
            ),
          ));
    });
  }
}
