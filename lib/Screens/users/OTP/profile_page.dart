import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:khan_pin/firstScreen.dart';
// import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image.asset("images/logo.png"),
          Container(
            margin: EdgeInsets.all(65),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.blueAccent),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                // Provider.of<ControllerLogin>(context, listen: false)
                //     .allowUserToLogOut();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (c) => FirstScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('LogOut',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
