
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:khan_pin/model/userDetailsmodel.dart';
import 'package:provider/provider.dart';

class GoogleSign extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> ControllerLogin()),
      ],
      child: MaterialApp(
        home: gogleLogin(),
      ),
    );
  }
}


class ControllerLogin with ChangeNotifier{
  var googleSignInNow = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;

  UserDetailsModel? userDetailsModel;

  allowUserToLogin()async
  {
    this.googleSignInAccount = await googleSignInNow.signIn();

    this.userDetailsModel = new UserDetailsModel(
      displayName: this.googleSignInAccount!.displayName,
      email: this.googleSignInAccount!.email,
      photoURL: this.googleSignInAccount!.photoUrl,

    );

    notifyListeners();

  }

  allowUserToLogOut() async {
    this.googleSignInAccount = await googleSignInNow.signOut();

    userDetailsModel = null;

    notifyListeners();

  }

}

final GoogleSignIn gSignIn = GoogleSignIn();

class gogleLogin extends StatefulWidget {
  gogleLogin({Key? key}) : super(key: key);

  @override
  State<gogleLogin> createState() => _gogleLoginState();
}

class _gogleLoginState extends State<gogleLogin> {


  loginUIController()
  {
    return Consumer<ControllerLogin>(
      builder: (context , model , child ){
        // if user already logged in
        if(model.userDetailsModel != null)
        {
          return Center(
            // show User details
            child:alreadyLoggedInScreen(model),
          );
        }else{
          // show SignIn Screen
          return notLoggedInScreen();
        }

      },

      );
  }

  notLoggedInScreen(){
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Image.asset("images/logo.png"),


            ),
            GestureDetector(
              onTap:(){
                Provider.of<ControllerLogin>(context,listen: false).allowUserToLogin();

              } ,
              child: Image.asset("images/otp.jpg"),
            ),
        ],
      ),

    );
  }

  alreadyLoggedInScreen(ControllerLogin model){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage: Image.network(model.userDetailsModel!.photoURL ?? "").image,

        ),

        ActionChip(
          avatar: Padding(
            padding: EdgeInsets.only(left: 15.0 , right: 15.0),
            child: Icon(Icons.logout,color: Colors.white,),
          ),
          label: Text("LogOut"),
           onPressed: (){
             Provider.of<ControllerLogin>(context , listen: false).allowUserToLogOut();
           })
      ],
    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: loginUIController(),
    );
  }
}



