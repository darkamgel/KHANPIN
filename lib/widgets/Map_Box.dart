import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsDraw extends StatefulWidget {
  const GoogleMapsDraw({Key? key}) : super(key: key);

  @override
  State<GoogleMapsDraw> createState() => _GoogleMapsDrawState();
}

class _GoogleMapsDrawState extends State<GoogleMapsDraw> {
  Set<Marker> markers = {};

  Future<void> fetchAndLocate(GoogleMapController controller) async {
    QuerySnapshot query =
        await FirebaseFirestore.instance.collection('admin').get();

    query.docs.forEach((data) {
      setState(() {
        markers.add(Marker(
            markerId: MarkerId(data.reference.id),
            position: LatLng(data['lat'], data['lng'])));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: GoogleMap(
          onMapCreated: fetchAndLocate,
          markers: markers,
          initialCameraPosition:
              CameraPosition(target: LatLng(27.6253, 85.5561), zoom: 15.0)),
    ));
  }
}
