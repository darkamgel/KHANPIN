import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khan_pin/main.dart';

class OrderCard extends StatefulWidget {
  final String? productId;
  final String? productPhotoUrl;
  final String? quantity;
  final String? finalPrice;
  final String? productName;
  const OrderCard(
      {@required this.productId,
      @required this.productPhotoUrl,
      @required this.productName,
      @required this.quantity,
      @required this.finalPrice});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  //String? uid = FirebaseAuth.instance.currentUser?.uid;
  Future<void> removeFromCart(String pId) async {
    try {
      await FirebaseFirestore.instance
          .collection('cart')
          .doc(
            FirebaseAuth.instance.currentUser?.uid,
          )
          .collection('items')
          .doc(pId)
          .delete();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.white,
      elevation: 2.0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20.0,
            ),
            Container(
              height: 70.0,
              width: 70.0,
              child: Image(
                image: NetworkImage(widget.productPhotoUrl!),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.productName!,
                  style: TextStyle(
                      color: Color(0xff303841),
                      fontWeight: FontWeight.bold,
                      fontSize: 23.0),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  widget.quantity.toString(),
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xffe23e57),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  height: 25.0,
                  width: 120.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 3.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Egg',
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            ),
                            SizedBox(
                              width: 2.0,
                            ),
                            Text(
                              'x',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xffe23e57),
                              ),
                            ),
                            SizedBox(
                              width: 7.0,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 3.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Tomm',
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            ),
                            SizedBox(
                              width: 2.0,
                            ),
                            Text(
                              'x',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xffe23e57),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 3.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'chessy',
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            ),
                            SizedBox(
                              width: 2.0,
                            ),
                            Text(
                              'x',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xffe23e57),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () => removeFromCart(widget.productId!),
              child: Icon(
                Icons.cancel,
                color: Color(0xff303841),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
