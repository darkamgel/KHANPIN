import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khan_pin/Screens/homescreen.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OTPScreen extends StatefulWidget {
  static const String idscreen = "otp";
  final String phone;
  final String codeDigits;

  OTPScreen({required this.phone, required this.codeDigits});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {



  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinOTPCodeController = TextEditingController();
  final FocusNode _pinOTPCodeFocus = FocusNode();
  String? verificationCode = "";
  int? _resendToken;

  final BoxDecoration pinOTPCodeDecoration = BoxDecoration(
      color: Colors.deepPurpleAccent,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: Colors.grey,

      ));

  @override
  void initState() {
    super.initState();
    verifyPhoneNumber();
  }

  verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "${widget.codeDigits + widget.phone}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) {
          if (value.user != null) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (c) => HomeScreen()));
          }
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message.toString()),
            duration: Duration(seconds: 3),
          ),
        );
      },
      codeSent: (String vId, int? resendToken) {
        setState(() {
          verificationCode = vId;
          _resendToken = resendToken;
        });
      },

      codeAutoRetrievalTimeout: (String vId) {
        setState(() {
          verificationCode = vId;
        });

      },
      timeout: Duration(seconds: 60),
      forceResendingToken: _resendToken,


    );

    //  codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: Colors.green,

        title: Text("OTP Verification" , ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                        // color: Colors.yellow,
                        color: Color(0xffFFFDD0),
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(250.0))),
              child: Image.asset("images/logo.png"),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    verifyPhoneNumber();
                  },
                  child: Text(
                    "Verifying : ${widget.codeDigits} - ${widget.phone}",
                    // "Verfying",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(40.0),
              child: PinPut(
                fieldsCount: 6,
                textStyle: TextStyle(fontSize: 25.0, color: Colors.white),
                eachFieldHeight: 55.0,
                eachFieldWidth: 40.0,
                focusNode: _pinOTPCodeFocus,
                controller: _pinOTPCodeController,
                submittedFieldDecoration: pinOTPCodeDecoration,
                selectedFieldDecoration: pinOTPCodeDecoration,
                followingFieldDecoration: pinOTPCodeDecoration,
                pinAnimationType: PinAnimationType.rotation,
                onSubmit: (pin) async {
                  try {
                    await FirebaseAuth.instance
                        .signInWithCredential(PhoneAuthProvider.credential(
                            verificationId: verificationCode!, smsCode: pin))
                        .then((value) {
                      if (value.user != null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (c) => HomeScreen()),
                        );
                      }
                    });
                  } catch (e) {
                    FocusScope.of(context).unfocus();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Invalid OTP"),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                },
              ),
            ),
            // ElevatedButton(onPressed: (){


            // }, child: Container(
            //   height: 30,
            //   width: 50,
            // ))
          ],
        ),
      ),
    );
  }
}
