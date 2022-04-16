import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:khan_pin/Screens/admin/homescreenadmin.dart';
import 'package:khan_pin/Screens/users/OTP/main_home_page.dart';

import 'package:khan_pin/Refactorcodes/buttons.dart';
import 'package:khan_pin/Screens/admin/loginScreenadmin.dart';
import 'package:khan_pin/Screens/users/OTP/RegisterScreenuser.dart';

import 'package:khan_pin/constants.dart';

// final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class FirstScreen extends StatefulWidget {
  static const String idscreen = "mainscreen";
  FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  // startTimer() {
  //   if (firebaseAuth.currentUser != null) {
  //     Navigator.push(context,MaterialPageRoute(builder:(c)=> Homepageadmin()));
  //   } else {
  //     Route newRoute = MaterialPageRoute(builder: (c) => LoginScreen());
  //     Navigator.pushReplacement(context, newRoute);
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // startTimer();
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   startTimer();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: 'logo',
                child: Container(
                  child: Image.asset("images/logo.png"),
                  decoration: BoxDecoration(
                      // color: Colors.yellow,
                      color: Color(0xffFFFDD0),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(250.0))),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: RoundedButton(
                        color: Colors.blueAccent,
                        button_name: "SignIn with PhoneNumber",
                        onPress: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (c) => RegisterScreenUser()));
                        },
                        icon: FontAwesomeIcons.keyboard),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  //   child: RoundedButton(
                  //       color: Colors.red,
                  //       button_name: "SignIn with Google",
                  //       onPress: () async {
                  //         await _gSignin();

                  //         await buildLoading();

                  //         Navigator.of(context).push(
                  //           MaterialPageRoute(
                  //             builder: (c) => MainHomePage(),
                  //           ),
                  //         );
                  //       },
                  //       icon: FontAwesomeIcons.google),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: TextButton(
                        child: Text(
                          "Resturant Owner ? ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1),
                        ),
                        onPressed: () {
                          // if (isresturantowner = true){
                          // Navigator.of(context).push(MaterialPageRoute(builder: (c) => LoginScreen()));

                          // }

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (c) => LoginScreenadmin()));
                        }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<User> _gSignin() async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );

    final User user =
        (await firebaseAuth.signInWithCredential(credential)).user!;
    // print("User is : ${user.photoURL}");
    print("User is : ${user.displayName}");

    return user;
  }
}
