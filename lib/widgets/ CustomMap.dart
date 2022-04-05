import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khan_pin/Screens/users/OTP/home_page.dart';
import 'dart:ui' as ui;

import '../Screens/users/OTP/main_home_page.dart';
import '../firstScreen.dart';
import '../main.dart';

class CustomMap extends StatefulWidget {
  // CustomMap({this.lat, this.lng});
  // final double? lat;
  // final double? lng;

  @override
  State<CustomMap> createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  BitmapDescriptor? customIcon;
  Set<Marker> markers = {};
  LatLng? place;
  double? lng;
  double? lat;

  doDatabasestuff() async {
    await FirebaseFirestore.instance.collection('orders').doc().set({
      "cartId": FirebaseAuth.instance.currentUser?.uid,
      "lat": lat,
      "lng": lng,
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Order Placed")));
  }

  @override
  void initState() {
    super.initState();
    markers = Set.from([]);
  }

  createMarker(context) {
    if (customIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, 'images/marker.png')
          .then((icon) {
        setState(() {
          customIcon = icon;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    createMarker(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 1.1,
            child: GoogleMap(
              mapType: MapType.normal,
              markers: markers,
              onTap: (pos) {
                place = pos;
                Marker m = Marker(
                    markerId: MarkerId('1'), icon: customIcon!, position: pos);
                setState(() {
                  markers.add(m);
                });
              },
              onMapCreated: (GoogleMapController controller) {},
              myLocationEnabled: true,
              initialCameraPosition:
                  CameraPosition(target: LatLng(27.6195, 85.5386), zoom: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  markers.forEach((mark) {
                    lng = mark.position.longitude;
                    lat = mark.position.latitude;
                  });
                  if (lat == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("No Location Selected")));
                  } else {
                    doDatabasestuff();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainHomePage()));
                  }
                },
                child: Text("Place My Order")),
          )
        ],
      ),
    );
  }
}
