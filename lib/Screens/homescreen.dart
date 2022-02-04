

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khan_pin/Screens/Google/gLoginScreen.dart';


// import 'package:khan_pin/Screens/OTP/loginScreen.dart';
import 'package:khan_pin/Screens/firstScreen.dart';
import 'package:provider/provider.dart';






class HomeScreen extends StatefulWidget {
  static const String idscreen = "home";
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home Screen" , style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [




          // Image.asset("images/logo.png"),
          Container(
            margin: EdgeInsets.all(65),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),

              onPressed: (){
                FirebaseAuth.instance.signOut();
                Provider.of<ControllerLogin>(context , listen: false).allowUserToLogOut();
                Navigator.of(context).push(MaterialPageRoute(builder: (c)=> FirstScreen()));
              },
              child: Text('LogOut', style:TextStyle(color: Colors.white , fontSize: 16 , fontWeight: FontWeight.bold)),
            ),
          )


        ],
      ),
    );
  }
}

