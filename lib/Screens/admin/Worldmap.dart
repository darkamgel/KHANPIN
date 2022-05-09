import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WorldMap extends StatefulWidget {
  final String cart_id;

  const WorldMap({required this.cart_id});

  @override
  State<WorldMap> createState() => _WorldMapState();
}

class _WorldMapState extends State<WorldMap> {



  @override
  void initState(){
    super.initState();
  }

  getData()async{
    await getLocations();
  }

  getLocations()async{
    List lat=[];
    QuerySnapshot query = await FirebaseFirestore.instance.collection('orders').get();

    query.docs.forEach((element) { 
      if(element['cartId']==widget.cart_id){
        lat.add(element['lat']);
        lat.add(element['lng']);

      }
    });

    return lat;


  }
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  LatLng _center = LatLng(27.619405543572952, 85.53861670196056);


  void _onMapCreated(GoogleMapController controller) async{
    GoogleMapController mapController = controller;

    List val = await getLocations();
    print("value Here");

    final marker = Marker(
      markerId: MarkerId('place_name'),
      position: LatLng(val[0], val[1]),
      // icon: BitmapDescriptor.,
      infoWindow: InfoWindow(
        title: 'title',
        snippet: 'address',
      ),
    );

    setState(() {
      markers[MarkerId('place_name')] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 5.0,
                ),
                markers: markers.values.toSet(),
              ),
    );
  }
}
