import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your email',
  hintStyle: TextStyle(color: Colors.blueAccent),
  labelStyle: TextStyle(color: Colors.deepOrangeAccent),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}

Widget buildLoading() => Center(
      child: CircularProgressIndicator(),
    );
