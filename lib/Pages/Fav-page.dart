import 'package:flutter/material.dart';

import 'allproducts.dart';

class Favourite_Page extends StatefulWidget {
  const Favourite_Page({super.key});

  @override
  State<Favourite_Page> createState() => _Favourite_PageState();
}

class _Favourite_PageState extends State<Favourite_Page> {
  void refreshAndNavigate() {
    // Call setState to refresh the current page
    setState(() {});

    // Navigate to the home page
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(child: Text('My Wishlist')),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
              onPressed: () {
                refreshAndNavigate();
              }),
          actions: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                refreshAndNavigate();
              },
            ),
          ],
        ),
        body: fav_items.isEmpty
            ? Center(
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Image.asset('lib/assets/Empty.png', width: 350),
                    SizedBox(height: 10),
                    Text(
                      'No favorites yet',
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
                      'Please Save Your \n Favourite Product',
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
            : ListView.builder(
                itemCount: fav_items.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          25.0), // Rounded corners for the card
                    ),
                    color: Colors.white,
                    child: ListTile(
                      leading: Image.network(
                        fav_items[index]["thumbnail"],
                        fit: BoxFit.fill,
                      ),
                      title: Text(
                        '${fav_items[index]['title']}',
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
                            fav_items.removeAt(index);
                            setState(() {});
                          },
                          icon: Icon(Icons.delete)),
                    ),
                  );
                },
              ));
  }
}
