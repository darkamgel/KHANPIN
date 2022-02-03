import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khan_pin/Refactorcodes/buttons.dart';
import 'package:khan_pin/Screens/OTP/loginScreen.dart';

class FirstScreen extends StatefulWidget {
  static const String idscreen = "mainscreen";
  FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {


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
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(250.0))),
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
                    padding: const EdgeInsets.only(left:20.0,right: 20.0),
                    child: RoundedButton(
                        color: Colors.blueAccent,
                        button_name: "SignIn with PhoneNumber",
                        onPress: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (c) => LoginScreen()));
                        },
                        icon: FontAwesomeIcons.keyboard),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: RoundedButton(
                        color: Colors.red,
                        button_name: "SignIn with Google",
                        onPress: () {},
                        icon: FontAwesomeIcons.google),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
