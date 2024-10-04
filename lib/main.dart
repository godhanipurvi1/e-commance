import 'package:flutter/material.dart';

import 'Pages/Fav-page.dart';
import 'Pages/cart_page1.dart';
import 'Pages/detail_page.dart';
import 'Pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomePage(),
        '/details': (context) => details(),
        'CartPage': (context) => CartPage(),
        'FavouritePage': (context) => Favourite_Page(),
      },
    );
  }
}
