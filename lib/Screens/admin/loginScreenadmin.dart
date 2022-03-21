import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:khan_pin/Refactorcodes/buttons.dart';
import 'package:khan_pin/Screens/admin/homescreenadmin.dart';
import 'package:khan_pin/Screens/admin/otpscreenadmin.dart';


import 'package:khan_pin/constants.dart';
import 'package:khan_pin/database/database.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreenadmin extends StatefulWidget {
  static const String idscreen = "loginScreenadmin";
  LoginScreenadmin({Key? key}) : super(key: key);

  @override
  State<LoginScreenadmin> createState() => _LoginScreenadminState();
}

class _LoginScreenadminState extends State<LoginScreenadmin> {
  String? phonenumber;
  String? username;
  String? email;
  String? resturantname;

  bool showSpinner = false;
  String dialCodeDigits = "+977";
  TextEditingController number_controller = TextEditingController();
  TextEditingController username_controller = TextEditingController();
  TextEditingController resturantname_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: ModalProgressHUD(
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
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.lightBlueAccent, width: 1.0),
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

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                    onChanged: (value) {
                      username = value;
                    },
                    textAlign: TextAlign.center,
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: "Enter Your Full Name",
                        hintStyle: kHintStyle)),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  onChanged: (value) {
                    resturantname = value;
                  },
                  textAlign: TextAlign.center,
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: "Enter your Resturant Name",
                      hintStyle: kHintStyle),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                   keyboardType: TextInputType.emailAddress,
                   
                  onChanged: (value) {
                    email = value;
                  },
                  textAlign: TextAlign.center,
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: "Enter your Business Email",
                      hintStyle: kHintStyle ,
                      ),
                ),
              ),

              

              Container(
                margin: EdgeInsets.all(30),
                width: double.infinity,
                child: Button1(
                  color: Colors.blue,
                  button_name: "Get OTP",
                  onPress: () async {
                    
                    if (number_controller.text.length < 10 ) {
                      displayToastMessage("Enter 10 Digits Number", context);
                    }
                    else if(username!.isEmpty){
                      displayToastMessage("Your name must be at least 5 characters.", context);
                    }
                    else if(resturantname!.isEmpty){
                      displayToastMessage("Enter your Resturant Name.", context);
                    }
                    else if(!email!.contains("@")){
                      displayToastMessage("Enter valid Email.", context);
                    }else{
                    
                    
                    // added later 
                    // else {
                    //   setState(() {
                    //     showSpinner = true;
                    //   });

                    

                      await DatabBaseServiceOTPAdmin(uid: FirebaseAuth.instance.currentUser!.uid)
                      .updateAdminData(username!, phonenumber!, email!, resturantname!);

  //for easiness i am removing  this verification method and will be added back later
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (c) => OTPScreenadmin(
                            phone: number_controller.text,
                            codeDigits: dialCodeDigits,
                          ),
                        ),

                        // Create a new document for the user with the uid
                      );

                      // await Navigator.of(context).push(
                      //   MaterialPageRoute(builder: (c) => Homepageadmin())
                      // );
                    }

                      // setState(() {
                      //   showSpinner = false;
                      // });
                  // }
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
      )),
    );
  }
}
