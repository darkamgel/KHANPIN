import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseServiceOTP {
  final String uid;
  DataBaseServiceOTP({required this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("Users");

  Future updateUserData(String name, String phonenumber) async {
    return await userCollection
        .doc(uid)
        .set({'name': name, 'phonenumber': phonenumber});
  }

  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }
}

class DatabBaseServiceOTPAdmin {
  final String uid;
  DatabBaseServiceOTPAdmin({required this.uid});

  final CollectionReference adminCollection =
      FirebaseFirestore.instance.collection("admins");

  Future updateAdminData(String name, String phonenumber, String email,
      String resturantname, String location) async {
    return await adminCollection.doc(uid).set({
      'name': name,
      'phonenumber': phonenumber,
      'email': email,
      'resturantname': resturantname,
      "loaction": location
    });
  }

  Stream<QuerySnapshot> get users {
    return adminCollection.snapshots();
  }

  //  String? phonenumber;
  // String? username;
  // String? email;
  // String? resturantname;

}

