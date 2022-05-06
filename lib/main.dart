import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:khan_pin/Screens/admin/addfood.dart';
import 'package:khan_pin/Screens/admin/home_tab_page.dart';
import 'package:khan_pin/Screens/admin/homescreenadmin.dart';
import 'package:khan_pin/Screens/users/OTP/home_page.dart';
import 'package:khan_pin/Screens/users/OTP/RegisterScreenuser.dart';
import 'package:khan_pin/Screens/users/OTP/main_home_page.dart';
import 'package:khan_pin/Screens/users/OTP/otpscreen.dart';
import 'package:khan_pin/Screens/users/OTP/profile_page.dart';
import 'package:khan_pin/constants.dart';

///  AIzaSyCMskATBBlrA_vC654vk3fVS1Ov0ibai2M
import 'package:khan_pin/firstScreen.dart';


// import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // currentfirebaseUser = FirebaseAuth.instance.currentUser;
  runApp(MyApp());
}

// CollectionReference admincollectionref = FirebaseFirestore.instance.collection("admin");
// CollectionReference usercollectionref = FirebaseFirestore.instance.collection('users');
CollectionReference foodcollectionref = FirebaseFirestore.instance.collection('food');



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KhanPin ',
      theme: ThemeData(primaryColor: Colors.blue),

      // home: AddFoodForm(),
      // home: HomePage(),
        home: FirstScreen(),
        // home: ProfilePage(),

      // initialRoute: FirebaseAuth.instance.currentUser == null ? HomeScreen.idscreen : FirstScreen.idscreen,
      initialRoute: FirebaseAuth.instance.currentUser==null ? FirstScreen.idscreen : MainHomePageAdmin.idscreen,
      routes: {
        FirstScreen.idscreen: (context) => FirstScreen(),
        // RegisterScreenUser.idscreen: (context) => RegisterScreenUser(),     
        Homepageadmin.idscreen: (context) => Homepageadmin(),
        AddFoodForm.idscreen: (context) => AddFoodForm(),
        MainHomePageAdmin.idscreen: (context) => MainHomePageAdmin(),
      }
    );
  }
}
