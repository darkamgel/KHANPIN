import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseServiceOTP{

  final String uid;
  DataBaseServiceOTP({required this.uid});


  final CollectionReference userCollection = FirebaseFirestore.instance.collection("Users");

  Future updateUserData(String name , String phonenumber ) async {
    return await userCollection.doc(uid).set({
      'name':name,
      'phonenumber':phonenumber

    });
  }
  Stream<QuerySnapshot> get users{
  return userCollection .snapshots();

}
}



