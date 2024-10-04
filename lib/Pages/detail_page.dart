import 'dart:developer';

import 'package:flutter/material.dart';

import 'allproducts.dart';
import 'home_page.dart';

class details extends StatefulWidget {
  @override
  _detailsState createState() => _detailsState();
}

class _detailsState extends State<details> {
  //void addToCart(Map<String, dynamic> product) {
  // setState(() {
  //   bool found = false;
  //   for (var item in cart_items) {
  //     if (item['id'] == product['id']) {
  //       item['quantity']++;
  //       found = true;
  //       // ScaffoldMessenger.of(context).showSnackBar(
  //       //   SnackBar(
  //       //     content: Text('Product is already in the cart'),
  //       //     duration: Duration(seconds: 2),
  //       //   ),
  //       //);
  //       break;
  //     }
  //   }
  //   if (!found) {
  //     cart_items.add({
  //       'title': product['title'],
  //       'price': product['price'],
  //       'quantity': 1,
  //       'thumbnail': product['thumbnail'],
  //     });
  //   }
  // });
//  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    Map<String, dynamic> product =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          // title: const Text("Product Details",
          //     style: TextStyle(
          //       backgroundColor: Color.fromARGB(255, 243, 250, 255),
          //       color: Color.fromARGB(255, 4, 12, 106),
          //       fontWeight: FontWeight.bold,
          //
          //     )),
          title: Center(child: Text('Products Details')),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
              onPressed: () {
                Route route = MaterialPageRoute(
                  builder: (context) => HomePage(),
                );
                Navigator.of(context).pop();
              }),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  fav_items.contains(product)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: fav_items.contains(product)
                      ? Color.fromARGB(
                          255,
                          197,
                          0,
                          10,
                        )
                      : Color.fromARGB(
                          255,
                          197,
                          0,
                          10,
                        ),
                ),
              ),
            )
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      '${product['category']} product',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color.fromARGB(255, 122, 122, 122),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Expanded(
                        flex: 1,
                        child: Container(
                          child: Row(
                              children: List.generate(
                                  product["images"].length,
                                  (index) => SizedBox(
                                      height: size.height * .4,
                                      width: size.width * .91,
                                      child: Image.network(
                                        product["images"][index],
                                        fit: BoxFit.contain,
                                      )))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    color: Colors.white,
                    //border:Border.all(color:Colors.black),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: Offset(4, 4),
                        blurRadius: 20,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Text('${product["title"]}',style:TextStyle(fontSize:20,fontWeight: FontWeight.bold)),
                          Text('Description',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${product["description"]}',
                            style: TextStyle(
                              color: Color.fromARGB(255, 122, 122, 122),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('${product["shippingInformation"]}',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                          Text('discount : ${product["discountPercentage"]}%',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                          Container(height: 10),
                          Text('\$ ${product["price"]}',
                              style: TextStyle(
                                fontSize: 23,
                              )),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  bool producincart = cart_items.any(
                                      (item) => item['id'] == product['id']);
                                  if (!producincart) {
                                    cart_items.add(product);
                                    product['quantity'] == 1;
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                              'product already in Cart',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                255,
                                                4,
                                                12,
                                                106,
                                              )),
                                            ),
                                            backgroundColor: Colors.white,
                                            duration: Duration(seconds: 2),
                                            behavior: SnackBarBehavior
                                                .floating, // Make Snackbar floating
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            )));
                                  }
                                  log('${cart_items.length}');
                                  setState(() {});
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromARGB(
                                    255,
                                    4,
                                    12,
                                    106,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Add To Bag ',
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.shopping_bag,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
