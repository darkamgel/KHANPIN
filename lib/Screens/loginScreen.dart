import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:khan_pin/Screens/OTP/otpscreen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String dialCodeDigits = "+977";
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: EdgeInsets.only(left: 28.0, right: 20),
              child: Image.asset("images/logo.png"),
            ),
            // Container(
            //   margin: EdgeInsets.only(top: 10),
            //   child: Center(
            //     child: Text(
            //       "Phone (OTP) Authentication",
            //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            //     ),
            //   ),
            // ),
            Text("Phone (OTP) Authentication", style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20),),
            SizedBox(
              height: 50,
            ),
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
              margin: EdgeInsets.only(top: 10.0, left:10.0 , right: 10.0,),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Phone Number",
                  prefix: Padding(padding: EdgeInsets.all(4),
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
              child: ElevatedButton(
                onPressed: (){

                  Navigator.of(context).push(MaterialPageRoute(builder: (c) =>OTPControllerScreen(
                    phone: _controller.text,
                    codeDigits: dialCodeDigits,
                  )));
                },



                child: Text("Next" , style:TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),),
            )

          ],
        ),
      ),
    );
  }
}
