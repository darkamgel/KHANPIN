import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khan_pin/model/admindetails.dart';

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your email',
  hintStyle: TextStyle(color: Colors.blueAccent),
  labelStyle: TextStyle(color: Colors.deepOrangeAccent),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.teal, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
);





                        
                        
                        

                        

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}

Widget buildLoading() => Center(
      child: CircularProgressIndicator(),
    );

const kHintStyle = TextStyle(color: Colors.black);
const kStyle = TextStyle(color: Colors.amber);
const kfoodTextStyle = TextStyle(fontSize: 17.0 , fontWeight: FontWeight.bold , color: Colors.white);
const kDiscountTextStyle =  TextStyle(fontSize: 14 , fontWeight: FontWeight.bold , color: Colors.white);

bool isresturantowner = true;

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final firebaseUser = firebaseAuth.currentUser;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

var verificationCode = '';





User ? currentfirebaseUser;

Admin ? admin;

String resturantName='';







