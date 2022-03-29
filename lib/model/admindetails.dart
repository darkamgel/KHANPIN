


import 'package:cloud_firestore/cloud_firestore.dart';

class Admin{
  String ? address;
  String ? adminEmail;
  String ? adminName;
  int ? earnings;
  int ? lat;
  int ? lng;
  String ? resturantName;

  Admin({
    required this.address , required this.adminEmail , 
  required this.adminName, required this.earnings ,
   required this.lat, required this.lng,
   required this.resturantName});

   factory Admin.deserializeAndShow(DocumentSnapshot data){
     print(data.data());
     return Admin(
       address: data['address'], 
       adminEmail: data['adminEmail'], 
       adminName: data['adminName'], 
       earnings: data['earnings'], 
       lat: data['lat'], 
       lng: data['lng'], 
       resturantName: data['resturantName']);
   }
}

