import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../Screens/Chekckout.dart';

Position? position;
List<Placemark>? placeMarks;
String completeAddress = "";
TextEditingController location_controller = TextEditingController();

getCurrentLocation() async {
  print("INVOKED");
  LocationPermission permission = await Geolocator.requestPermission();
  Position newPosition = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
  position = newPosition;
  return position;
}

Widget buildContainer(
    {@required double? sub,
    @required BuildContext? context,
    @required double? tax,
    @required num? discount,
    @required double? cartTotal}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 25.0),
    height: 240.0,
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Cart Total',
              style: TextStyle(
                fontSize: 18.0,
                color: Color(0xff303841),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              cartTotal.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff303841),
                  fontSize: 20.0),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Discount',
              style: TextStyle(
                fontSize: 18.0,
                color: Color(0xff303841),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              discount.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff303841),
                  fontSize: 20.0),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Tax',
              style: TextStyle(
                fontSize: 18.0,
                color: Color(0xff303841),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              tax.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff303841),
                  fontSize: 20.0),
            ),
          ],
        ),
        SizedBox(
          height: 40.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Subtotal',
              style: TextStyle(
                fontSize: 20.0,
                color: Color(0xff303841),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              sub.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff303841),
                  fontSize: 20.0),
            ),
          ],
        ),
        GestureDetector(
          // onTap: () => showDialog<String>(
          //   context: context!,
          //   builder: (BuildContext context) => AlertDialog(
          //     title: const Text('Location'),
          //     content: const Text(
          //         'If you wish to proceed with Checkout your location will be automatically taken !'),
          //     actions: <Widget>[
          //       TextButton(
          //         onPressed: () => Navigator.pop(context, 'Cancel'),
          //         child: const Text('Cancel'),
          //       ),
          //       TextButton(
          //         onPressed: () {
          //           position = getCurrentLocation();
          //           if (position != null) {
          //             Navigator.push(context,
          //                 MaterialPageRoute(builder: (context) => Checkout()));
          //           }
          //         },
          //         child: const Text('OK'),
          //       ),
          //     ],
          //   ),
          // ),
          onTap: () {
            Navigator.push(
                context!, MaterialPageRoute(builder: (context) => Checkout()));
          },
          child: Container(
            margin: EdgeInsets.only(top: 35.0),
            height: 50.0,
            width: 200.0,
            decoration: BoxDecoration(
              color: Color(0xffe23e57),
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Center(
                child: Text(
              'Proceed to Checkout',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xffeeeeee),
                  fontSize: 20.0),
            )),
          ),
        ),
      ],
    ),
  );
}
