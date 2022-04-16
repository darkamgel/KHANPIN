import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:khan_pin/Screens/admin/addfood.dart';
import 'package:khan_pin/Screens/admin/homescreenadmin.dart';
import 'package:khan_pin/Screens/users/OTP/home_page.dart';
import 'package:khan_pin/Screens/users/OTP/loginScreenuser.dart';
import 'package:khan_pin/Screens/users/OTP/main_home_page.dart';
import 'package:khan_pin/Screens/users/OTP/otpscreen.dart';
import 'package:khan_pin/constants.dart';

///  AIzaSyCMskATBBlrA_vC654vk3fVS1Ov0ibai2M
import 'package:khan_pin/firstScreen.dart';
import 'package:khan_pin/widgets/%20CustomMap.dart';
import 'package:khan_pin/widgets/Map_Box.dart';

// import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // currentfirebaseUser = FirebaseAuth.instance.currentUser;
  runApp(MyApp());
}

// CollectionReference admincollectionref = FirebaseFirestore.instance.collection("admin");

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'KhanPin ',
        theme: ThemeData(primaryColor: Colors.blue),

        // home: AddFoodForm(),
        home: FirstScreen(),
        initialRoute: FirebaseAuth.instance.currentUser != null
            ? FirstScreen.idscreen
            : MainHomePage.idscreen,
        routes: {
          FirstScreen.idscreen: (context) => FirstScreen(),
          LoginScreen.idscreen: (context) => LoginScreen(),
          Homepageadmin.idscreen: (context) => Homepageadmin(),
          AddFoodForm.idscreen: (context) => AddFoodForm(),
          MainHomePage.idscreen: ((context) => MainHomePage())
        });
  }
}
