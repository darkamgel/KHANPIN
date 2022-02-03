import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khan_pin/Refactorcodes/buttons.dart';
import 'package:khan_pin/Screens/OTP/otpscreen.dart';
import 'package:khan_pin/constants.dart';

class LoginScreen extends StatefulWidget {
  static const String idscreen = "loginScreen";
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {



  String dialCodeDigits = "+977";
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(250.0))),
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
                width: 200,
                height: 200,
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
              Container(
                margin: EdgeInsets.only(
                  top: 10.0,
                  left: 10.0,
                  right: 10.0,
                ),
                child: TextField(
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
                      borderSide: BorderSide(color:Colors.teal, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    prefix: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(dialCodeDigits),
                    ),
                  ),
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  controller: _controller,
                ),
              ),

              Container(
                  margin: EdgeInsets.all(15),
                  width: double.infinity,
                  child: RoundedButton(
                      color: Colors.blue,
                      button_name: "Get OTP",
                      onPress: () {

                        if (_controller.text.length<10){
                          displayToastMessage("Enter 10 Digits Number", context);


                        }else{
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (c) => OTPScreen(
                                  phone: _controller.text,
                                  codeDigits: dialCodeDigits,
                                )));
                        }







                      },
                      icon: FontAwesomeIcons.forward)),
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
      ),
    );
  }
}
