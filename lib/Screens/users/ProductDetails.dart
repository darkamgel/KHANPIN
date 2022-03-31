import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khan_pin/Screens/users/OTP/order_page.dart';
import 'package:khan_pin/main.dart';
import 'package:khan_pin/widgets/food_card_item.dart';

class ProductDetails extends StatefulWidget {
  final String? productName;
  final double? price;
  final double? rating;
  final String? id;
  final String? category;
  final String? imageUrl;
  final double? discount;
  final int? initCounter;

  ProductDetails(
      {@required this.productName,
      @required this.price,
      @required this.rating,
      @required this.id,
      @required this.initCounter,
      @required this.category,
      @required this.imageUrl,
      @required this.discount});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int counter = 1;
  bool isLoading = false;

  @override
  void initState() {
    getQuantity();
    super.initState();
  }

  getQuantity() {
    widget.initCounter != 0 ? counter = widget.initCounter! : counter = 1;
  }

  //String? uid = FirebaseAuth.instance.currentUser?.uid;

  Future<void> _makeCart() async {
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseFirestore.instance
          .collection('cart')
          .doc(uid)
          .collection('items')
          .doc(widget.id)
          .set({
        "ProductName": widget.productName,
        'ProductId': widget.id,
        "Quantity": counter.toString(),
        "Discount": widget.discount.toString(),
        "TotalPrice": getFinalPrice().toString(),
        "Delivered": false,
        "ProductPhoto": widget.imageUrl,
        "Timestamp": DateTime.now(),
        "category": widget.category
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Item Added To Cart'),
        duration: const Duration(seconds: 1),
      ));
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  String getFinalPrice() {
    double tempPrice = 0;
    tempPrice = (widget.price! * counter) - widget.discount!;
    return tempPrice.toString();
  }

  getCounterAdd() {
    setState(() {
      counter++;
    });
  }

  getCounterDec() {
    if (counter <= 1) {
      counter = 1;
    } else {
      setState(() {
        counter--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffeeeeee),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Color(0xffeeeeee),
          title: Text(
            widget.productName.toString().toUpperCase(),
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SafeArea(
            child: Column(
          children: [
            FoodCardItem(
                widget.imageUrl!,
                widget.id!,
                widget.category!,
                widget.discount!,
                widget.productName!,
                widget.price!,
                widget.rating!),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     child: Text(
            //       "dThis is a product Description Yayyyyy.",
            //       style: TextStyle(fontSize: 22,),
            //     ),
            //   ),
            // )
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: getCounterDec,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.pink),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.remove),
                          ),
                          height: 40,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                "QTY",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              counter <= 0 ? "0" : counter.toString(),
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: getCounterAdd,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.add),
                          ),
                          height: 40,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Color.fromARGB(170, 218, 216, 216),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Price: "),
                        Text(widget.price.toString())
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Quantity: "), Text(counter.toString())],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Discount: "),
                        Text(widget.discount.toString())
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Net Amount: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          getFinalPrice(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(25)),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.pink),
                    onPressed: () {
                      isLoading ? null : _makeCart();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Order()));
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.add_shopping_cart),
                          ),
                          Text(isLoading ? "Adding to Cart..." : "Add To Cart"),
                        ],
                      ),
                    )),
              ),
            )
          ],
        )));
  }
}
