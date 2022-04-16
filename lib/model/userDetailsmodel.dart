

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  
  final String phNumber;

  UserModel({ required this.phNumber});

  factory UserModel.deserialize(DocumentSnapshot doc) {
    return UserModel(phNumber: doc['phone']);
  }
}

