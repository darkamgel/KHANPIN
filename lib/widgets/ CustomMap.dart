import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMap extends StatefulWidget {
  const CustomMap({Key? key}) : super(key: key);

  @override
  State<CustomMap> createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  BitmapDescriptor? customIcon;
  Set<Marker> markers = {};
  LatLng? place;
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
            height: 700,
            child: GoogleMap(
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
              initialCameraPosition:
                  CameraPosition(target: LatLng(36.98, -121.99), zoom: 18),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                // database ma halne
              },
              child: Text("Place My Order"))
        ],
      ),
    );
  }
}
