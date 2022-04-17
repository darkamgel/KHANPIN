import 'package:flutter/material.dart';
import 'package:khan_pin/widgets/notification_card.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeeeeee),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Color(0xffeeeeee),
        elevation: 0.0,
        title: Text(
          'Deals',
          style: TextStyle(
            color: Color(0xff303841),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          
        ],
      ),
    );
  }
}
