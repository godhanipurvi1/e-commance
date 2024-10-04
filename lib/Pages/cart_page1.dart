import 'package:flutter/material.dart';

import 'allproducts.dart';
import 'detail_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // void addToCart(Map<String, dynamic> product) {
  //   setState(() {
  //     bool found = false;
  //     for (var item in cart_items) {
  //       if (item['id'] == product['id']) {
  //         item['quantity']++;
  //         found = true;
  //         // ScaffoldMessenger.of(context).showSnackBar(
  //         //   SnackBar(
  //         //     content: Text('Product is already in the cart'),
  //         //     duration: Duration(seconds: 2),
  //         //   ),
  //         //);
  //         break;
  //       }
  //     }
  //     if (!found) {
  //       cart_items.add({
  //         'title': product['title'],
  //         'price': product['price'],
  //         'quantity': 1,
  //         'thumbnail': product['thumbnail'],
  //       });
  //     }
  //   });
  // }
  //
  // double calculateTotal(List<Map<String, dynamic>> items) {
  //   double total = 0.0;
  //   for (var item in items) {
  //     total += item['price']* item['quantity'];
  //   }
  //   return total;
  // }
  //

  double totalPrice() {
    double totalPriceBeforeDiscounts = allTotalPrice();
    double totalDiscount = discount();
    double finalTotalPrice = totalPriceBeforeDiscounts - totalDiscount;
    return finalTotalPrice;
  }

  double allTotalPrice() {
    double totalPrice = 0.0;

    cart_items.forEach((item) {
      double itemTotalPrice =
          item['quantity'].toDouble() * item['price'].toDouble();
      totalPrice += itemTotalPrice;
    });

    return totalPrice;
  }

  double discount() {
    double discount = 0.0;

    cart_items.forEach((item) {
      discount += (item['quantity']) *
          (item['price'] * (item['discountPercentage'] ?? 0.0)) /
          100;
    });

    return discount;
  }

  void incrementQuantity(int index) {
    setState(() {
      if (cart_items[index]['quantity'] < cart_items[index]['stock'])
        cart_items[index]['quantity']++;
      else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'product is out of stock',
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
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )));
      }
    });
  }

  void decrementQuantity(int index) {
    setState(() {
      if (cart_items[index]['quantity'] > 1) {
        cart_items[index]['quantity']--;
      } else {
        cart_items.removeAt(index);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'product remove from cart',
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
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double finalprice = totalPrice();
    double totalPriceBeforeDiscounts = allTotalPrice();
    double totalDiscount = discount();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(child: Text('My Cart')),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () {
              Route route = MaterialPageRoute(
                builder: (context) => details(),
              );
              Navigator.of(context).pop();
            }),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.popUntil((context), ModalRoute.withName('/'));
            },
          ),
        ],
      ),
      body: cart_items.isEmpty
          //Text('cart is empty');
          ? Center(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Image.asset('lib/assets/Empty.png', width: 350),
                  SizedBox(height: 10),
                  Text(
                    'Cart is empty',
                    style: TextStyle(
                        color: Color.fromARGB(
                          255,
                          4,
                          12,
                          106,
                        ),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '      please add your \n product to cart',
                    style: TextStyle(
                      color: Color.fromARGB(
                        255,
                        103,
                        103,
                        103,
                      ),
                    ),
                  )
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: cart_items.length,
                      itemBuilder: (context, i) {
                        return Card(
                            elevation: 4.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 14.0, horizontal: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  25.0), // Rounded corners for the card
                            ),
                            color: Colors.white,
                            child: ListTile(
                              leading: Image.network(
                                cart_items[i]["thumbnail"],
                                fit: BoxFit.fill,
                              ),
                              title: Text(
                                '${cart_items[i]['title']}',
                                style: TextStyle(
                                    color: Color.fromARGB(
                                      255,
                                      4,
                                      12,
                                      106,
                                    ),
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    cart_items.removeAt(i);
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.delete)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "\$ ${cart_items[i]['price']}",
                                    style: TextStyle(
                                        color: Color.fromARGB(
                                          255,
                                          4,
                                          12,
                                          106,
                                        ),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: () => decrementQuantity(i),
                                      ),
                                      Text('${cart_items[i]['quantity']}'),
                                      IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: () => incrementQuantity(i),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ));
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color of the container
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey, // Shadow color
                          offset: Offset(0,
                              4), // Horizontal and vertical offset of the shadow
                          blurRadius: 8, // Blur radius of the shadow
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                        topLeft:
                            Radius.circular(25), // Round the top-left corner
                        topRight:
                            Radius.circular(25), // Round the top-right corner
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '     price :\$ ${totalPriceBeforeDiscounts.toStringAsFixed(2)}\n'
                            '- discount :\$ ${totalDiscount.toStringAsFixed(2)}\n'
                            '    Total :\$ ${finalprice.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(
                                255,
                                4,
                                12,
                                106,
                              ),
                              foregroundColor: Colors.white),
                          child: Text('Checkout'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
