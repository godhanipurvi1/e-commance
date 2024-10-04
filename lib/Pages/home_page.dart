import 'dart:developer';

import 'package:flutter/material.dart';

import 'allproducts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color C = Color.fromARGB(
    255,
    4,
    12,
    106,
  );
  var _selectedCategory;
  bool isfilled = false;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredProducts =
        _selectedCategory == null || _selectedCategory == 'All'
            ? products
            : products
                .where((product) => product['category'] == _selectedCategory)
                .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'FavouritePage');
                    },
                    icon: Icon(Icons.favorite_outlined)),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'CartPage');
                    },
                    icon: Icon(Icons.shopping_cart)),
              ],
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  Padding(
              // padding: const EdgeInsets.only(left: 8.0,top:8.0),
              // child: Row(
              //mainAxisAlignment: MainAxisAlignment.start,
              // children: [

              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text('All Products\n',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(
                          255,
                          4,
                          12,
                          106,
                        ))),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Categories',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ),

              // Spacer(),
              //  DropdownButton<String>(
              //   value: _selectedCategory,
              //   hint: Text('Select a category'),
              //   onChanged: (String? newValue) {
              //     setState(() {
              //       _selectedCategory = newValue;
              //     });
              //   },
              //   items: [
              //     DropdownMenuItem<String>(
              //       value: 'All', // Special value for selecting all
              //       child: Text('All'), // Displayed text for 'All'
              //     ),
              //     ...categories.map<DropdownMenuItem<String>>(( category) {
              //     return DropdownMenuItem<String>(
              //       value: category,
              //       child: Text(category),
              //     );
              //   }).toList(),]
              // ),

              // ],
              // ),
              // ),
              Column(
                children: [
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: categories
                            .map((e) => Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Wrap(
                                    spacing: 8.0,
                                    runSpacing: 4.0,
                                    children: categories.map((category) {
                                      return
                                          //   Material(
                                          // elevation: 4.0, // add a permanent shadow
                                          // shape: RoundedRectangleBorder(
                                          // borderRadius: BorderRadius.circular(67),
                                          // ),
                                          //                             child:
                                          ActionChip(
                                        label: Text(
                                          category,
                                          style: TextStyle(
                                            color: _selectedCategory == category
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                        backgroundColor:
                                            _selectedCategory == category
                                                ? Color.fromARGB(
                                                    255,
                                                    4,
                                                    12,
                                                    106,
                                                  )
                                                : Colors.white,
                                        elevation: 5.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(67),
                                          side: BorderSide(
                                            color: _selectedCategory == category
                                                ? Color.fromARGB(
                                                    255,
                                                    4,
                                                    12,
                                                    106,
                                                  )
                                                : Colors.white,
                                          ),
                                          // side: BorderSide(
                                          //   color: _selectedCategory == category
                                          //       ? Color.fromARGB(255, 4, 12, 106)
                                          //       : Colors.transparent,
                                          //   width: 2, // Border width
                                          // ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            if (_selectedCategory == category) {
                                              _selectedCategory = 'All';
                                            } else {
                                              _selectedCategory =
                                                  category == 'All'
                                                      ? null
                                                      : category;
                                            }
                                          });
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ))
                            .toList(),
                      )),
                ],
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  padding: EdgeInsets.only(bottom: 20),
                  childAspectRatio: 0.6,
                  children: List.generate(filteredProducts.length, (e) {
                    final products = filteredProducts;
                    {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/details',
                              arguments: products[e]);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                offset: Offset(4, 4),
                                blurRadius: 2,
                                spreadRadius: 0,
                              ),
                            ],
                            // border: Border.all(color: Colors.black),
                          ),
                          child: Column(children: [
                            //Expanded(
                            //flex: 2,
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: C,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        " -${products[e]['discountPercentage']} % ",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.all(10.1),
                                  child: IconButton(
                                    onPressed: () {
                                      // fav_items.add(products[e]);
                                      setState(() {
                                        isfilled = !isfilled;
                                        if (fav_items.contains(products[e])) {
                                          fav_items.remove(products[e]);
                                        } else {
                                          fav_items.add(products[e]);
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      fav_items.contains(products[e])
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: fav_items.contains(products[e])
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
                                ),
                              ],
                            ),
                            Image.network(
                              products[e]['thumbnail'],
                              fit: BoxFit.cover,
                              height: 100,
                            ),
                            //),
                            Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(products[e]['title'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                  255,
                                                  4,
                                                  12,
                                                  106,
                                                ),
                                              )),
                                          Row(
                                            children: [
                                              Text(
                                                '\$ ${products[e]['price']}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17,
                                                  color: Color.fromARGB(
                                                    255,
                                                    4,
                                                    12,
                                                    106,
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              IconButton(
                                                  onPressed: () {
                                                    bool producincart =
                                                        cart_items.any((item) =>
                                                            item['id'] ==
                                                            products[e]['id']);
                                                    if (!producincart) {
                                                      cart_items
                                                          .add(products[e]);

                                                      products[e]['quantity'] =
                                                          1;
                                                    } else {
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                          SnackBar(
                                                              content: Text(
                                                                'product already in Cart',
                                                                style:
                                                                    TextStyle(
                                                                        color: Color
                                                                            .fromARGB(
                                                                  255,
                                                                  4,
                                                                  12,
                                                                  106,
                                                                )),
                                                              ),
                                                              backgroundColor:
                                                                  Colors.white,
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          2),
                                                              behavior:
                                                                  SnackBarBehavior
                                                                      .floating,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              )));
                                                    }
                                                    log('${cart_items.length}');
                                                    setState(() {});
                                                  },
                                                  icon: Icon(Icons
                                                      .add_shopping_cart_sharp))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ]),
                        ),
                      );
                    }
                  }),
                ),
              ),
              // Container(
              //   height:70,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.only(topRight: Radius.circular(28),topLeft: Radius.circular(28)),
              //         border: Border.all(color: Colors.black),
              //   ),
              // child: Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //        child:Row(
              //
              //          children: [
              //
              //            IconButton(icon:Icon(Icons.home,size: 26,),
              //                              onPressed: (){
              //             Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
              //                              },
              //                              ),
              //
              //
              //            IconButton(icon:Icon(Icons.shopping_cart,size: 26,),
              //              onPressed: (){
              //                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
              //              },
              //            ),
              //            IconButton(icon:Icon(Icons.favorite_sharp,size: 26,),
              //              onPressed: (){
              //                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
              //              },
              //            ),
              //            IconButton(icon:Icon(Icons.person,size: 26,),
              //              onPressed: (){
              //                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
              //              },
              //            ),
              //
              //          ],
              //        ),
              //     )
              //
              //   ],
              // ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
