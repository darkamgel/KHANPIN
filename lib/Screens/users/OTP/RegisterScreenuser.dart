import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:khan_pin/Refactorcodes/buttons.dart';
import 'package:khan_pin/Screens/users/OTP/otpscreen.dart';

import 'package:khan_pin/constants.dart';
import 'package:khan_pin/database/database.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class RegisterScreenUser extends StatefulWidget {
  // static const String idscreen = "RegisterUserScreen";
  RegisterScreenUser({Key? key}) : super(key: key);

  @override
  State<RegisterScreenUser> createState() => _RegisterScreenUserState();
}

class _RegisterScreenUserState extends State<RegisterScreenUser> {
  

  String? phonenumber;
  String completeAddress = "";

  Position? position;
  List<Placemark>? placeMarks;

  getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    Position newPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    position = newPosition;

    placeMarks =
        await placemarkFromCoordinates(position!.latitude, position!.longitude);
    Placemark pMark = placeMarks![0];

    // String completeAddress = '${pMark.subThoroughfare} ${pMark.thoroughfare} , ${pMark.subLocality}  ${pMark.locality} , ${pMark.subAdministrativeArea} , ${pMark.administrativeArea} ${pMark.postalCode} , ${pMark.country}';
    completeAddress =
        '${pMark.subThoroughfare} ${pMark.thoroughfare} , ${pMark.subLocality}  ${pMark.locality} , ${pMark.subAdministrativeArea} , ${pMark.administrativeArea} ${pMark.postalCode} , ${pMark.country}';
    print(completeAddress);
    location_controller.text = completeAddress;
  }

  // Future saveuserDatatoFirestore()async{

  //   final User user = await firebaseAuth.currentUser!;
  //   final uid = user.uid;
  //   await  FirebaseFirestore.instance.collection('users').add({
  //     "uid":uid,
  //     "username": username_controller.text,
  //                       "phone_number": phonenumber,
  //                       // "address": completeAddress,
  //                       // "earnings": 0.0,
  //                       "lat": position!.latitude,
  //                       "lng": position!.longitude,

  //   },
  //   ).whenComplete((){
  //     Navigator.push(context, MaterialPageRoute(builder:(c) => OTPScreen(phone: phonenumber!, codeDigits:dialCodeDigits )));

  //   });
  // }

  bool showSpinner = false;
  String dialCodeDigits = "+977";
  // TextEditingController number_controller = TextEditingController();
  TextEditingController location_controller = TextEditingController();
  TextEditingController username_controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                    onChanged: (value) {
                      username_controller.text = value;
                    },
                    textAlign: TextAlign.center,
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: "Enter your Username",
                        hintStyle: kHintStyle)),
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
                  // controller: phonenumber,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  controller: location_controller,
                  enabled: false,
                  textAlign: TextAlign.center,
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: "Resturant Location", hintStyle: kHintStyle),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 400,
                height: 40,
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                  onPressed: () {
                    getCurrentLocation();
                    // debugPrint("Button test");
                  },
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Get My Current Location",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.all(30),
                width: double.infinity,
                child: Button1(
                  width: 150,
                  height: 42,
                  color: Colors.blue,
                  button_name: "Get OTP",
                  onPress: () async {
                    if (phonenumber!.length < 10 &&
                        username_controller.text.length < 7) {
                      displayToastMessage("Enter 10 Digits Number", context);
                    } else {
                      setState(() {
                        showSpinner = true;
                      });

                      
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => OTPScreen(
                              phone: phonenumber!,
                              codeDigits: dialCodeDigits,
                              username: username_controller.text.trim(),
                              latitude: position!.latitude.toString(),
                              longitude: position!.longitude.toString(),
                              completeAddress: completeAddress,
                            ),
                          ),
                        );
                     
                      // saveuserDatatoFirestore(firebaseAuth.currentUser!);
                      // saveuserDatatoFirestore();

                      setState(() {
                        showSpinner = false;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
