import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:khan_pin/Screens/OTP/otpscreen.dart';
import 'package:khan_pin/Screens/firstScreen.dart';
import 'package:khan_pin/Screens/OTP/loginScreen.dart';
import 'package:khan_pin/Screens/homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KhanPin ',
      theme: ThemeData(
        primaryColor: Colors.blue
      ),
      home: FirstScreen(),
      // home: OTPScreen(),

      // initialRoute: FirebaseAuth.instance.currentUser == null ? HomeScreen.idscreen : FirstScreen.idscreen,
      // routes: {
      //   FirstScreen.idscreen:(context) => FirstScreen(),
      //   LoginScreen.idscreen:(context) => LoginScreen(),
      //   HomeScreen.idscreen :(context) => HomeScreen(),

      // }

    );
  }
}