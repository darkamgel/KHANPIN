import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khan_pin/Screens/users/ProductDetails.dart';
import 'package:khan_pin/main.dart';
import 'package:khan_pin/widgets/price_info_order.dart';
import '../../../widgets/order_card.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  //String? uid = FirebaseAuth.instance.currentUser?.uid;

  double cart = 0;
  double discount = 0;
  double tax = 5.0;

  @override
  void initState() {
    getData();
    super.initState();
  }

  processCart(QuerySnapshot snapshot) {
    discount = 0;
    cart = 0;
    int length = snapshot.docs.length;

    for (int i = 0; i < length; i++) {
      discount = discount + double.parse(snapshot.docs[i]['Discount']);
      cart = cart +
          double.parse(snapshot.docs[i]['TotalPrice']) *
              double.parse(snapshot.docs[i]['Quantity']);
    }
  }

  getData() async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('cart')
        .doc(
          FirebaseAuth.instance.currentUser?.uid,
        )
        .collection('items')
        .orderBy('Timestamp', descending: true)
        .get();
    query.docs.forEach((element) {
      print(element.data());
    });
  }

  StreamBuilder displayOrders() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('cart')
            .doc(
              FirebaseAuth.instance.currentUser?.uid,
            )
            .collection('items')
            .orderBy('Timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          processCart(snapshot.data);

          return Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductDetails(
                                          initCounter: int.parse(snapshot
                                              .data.docs[index]['Quantity']),
                                          productName: snapshot.data.docs[index]
                                              ['ProductName'],
                                          price: double.parse(snapshot
                                              .data.docs[index]['TotalPrice']),
                                          rating: 5.0,
                                          id: snapshot.data.docs[index]
                                              ['ProductId'],
                                          category: snapshot.data.docs[index]
                                              ['category'],
                                          imageUrl: snapshot.data.docs[index]
                                              ['ProductPhoto'],
                                          discount: double.parse(snapshot.data.docs[index]['Discount']))));
                            },
                            child: !snapshot.data.docs[index]['Delivered']
                                ? OrderCard(
                                    productId: snapshot.data.docs[index]
                                        ['ProductId'],
                                    productPhotoUrl: snapshot.data.docs[index]
                                        ['ProductPhoto'],
                                    productName: snapshot.data.docs[index]
                                        ['ProductName'],
                                    quantity: snapshot.data.docs[index]
                                        ['Quantity'],
                                    finalPrice: snapshot.data.docs[index]
                                        ['TotalPrice'])
                                : SizedBox(
                                    height: 1,
                                  ));
                      }),
                ),
                buildContainer(
                    context: context,
                    sub: cart - discount,
                    tax: tax,
                    discount: discount,
                    cartTotal: cart)
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeeeeee),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: Color(0xffeeeeee),
        elevation: 0.0,
        title: Text(
          "Your Food Cart",
          style: TextStyle(
            color: Color(0xff303841),
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
      ),
      body: displayOrders(),
    );
  }
}
