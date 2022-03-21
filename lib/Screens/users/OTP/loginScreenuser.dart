import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:khan_pin/Refactorcodes/buttons.dart';
import 'package:khan_pin/Screens/users/OTP/otpscreen.dart';

import 'package:khan_pin/constants.dart';
import 'package:khan_pin/database/database.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';



class LoginScreen extends StatefulWidget {
  static const String idscreen = "loginScreen";
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? phonenumber;
  String? username;

  bool showSpinner = false;
  String dialCodeDigits = "+977";
  TextEditingController number_controller = TextEditingController();
  TextEditingController username_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child: Scaffold(
        
        body: 
         
        ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SingleChildScrollView(
            child: Column(
              
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                SizedBox(
                  height: 10,
                ),
                Hero(
                  tag: 'logo',
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffFFFDD0),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(250.0))),
                    child: Padding(
                      padding: EdgeInsets.only(left: 28.0, right: 20),
                      child: Image.asset("images/logo.png"),
                    ),
                  ),
                ),

                // Text("Phone (OTP) Authentication", style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20),),
                // SizedBox(
                //   height: 50,
                // ),
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CountryCodePicker(
                    onChanged: (country) {
                      setState(() {
                        dialCodeDigits = country.dialCode!;
                      });
                    },
                    initialSelection: "NP",
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    favorite: ["+1", "US", "+92", "PAK", "+977", "NP"],
                  ),
                ),


                // separation
                

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    onChanged: (value) {
                      username = value;
                    },
                    textAlign: TextAlign.center,
                    decoration: kTextFieldDecoration.copyWith(hintText: "Enter your Username" , hintStyle: kHintStyle)
                  ),
                ),
                
                Container(
                  margin: EdgeInsets.only(
                    top: 10.0,
                    left: 10.0,
                    right: 10.0,
                  ),
                  child: TextField(
                    onChanged: (value) {
                      phonenumber = value;
                    },
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(color: Colors.deepOrange),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 1.0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      prefix: Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(dialCodeDigits),
                      ),
                    ),
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    controller: number_controller,
                  ),
                ),
                
                
                Container(
                  margin: EdgeInsets.all(30),
                  width: double.infinity,
                  child: Button1(
                    color: Colors.blue,
                    button_name: "Get OTP",
                    onPress: () async {
                      print(phonenumber);
                      print(username);
                      if (number_controller.text.length < 10 && username_controller.text.length < 7) {
                        displayToastMessage("Enter 10 Digits Number", context);
                      } else {
                        setState(() {
                          showSpinner = true;
                        });

                        await DataBaseServiceOTP(
                                uid: FirebaseAuth.instance.currentUser!.uid)
                            .updateUserData(username!, phonenumber!);

                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (c) => OTPScreen(
                              phone: number_controller.text,
                              codeDigits: dialCodeDigits,
                            ),
                          ),

                          // Create a new document for the user with the uid
                        );

                        setState(() {
                          showSpinner = false;
                        });
                      }
                    },
                  ),
                ),
                //   ElevatedButton(
                //     onPressed: (){

                //       Navigator.of(context).push(MaterialPageRoute(builder: (c) =>OTPControllerScreen(
                //         phone: _controller.text,
                //         codeDigits: dialCodeDigits,
                //       )));
                //     },

                //     child: Text("Next" , style:TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),),
                // )
              ],
            ),
          ),
        )
        
      ),
    );
  }
}
