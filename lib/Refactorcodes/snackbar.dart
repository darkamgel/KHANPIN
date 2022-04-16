import 'package:flutter/material.dart';

displaySnackBar(text, key) {
  final snackBar =
  SnackBar(content: Text(text, style: TextStyle(fontFamily: 'Coda')));
  key.currentState.showSnackBar(snackBar);
}