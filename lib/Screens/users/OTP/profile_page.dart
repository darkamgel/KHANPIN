import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khan_pin/firstScreen.dart';

// our data
const url = "sandeep.me";
const email = "sandeepkshetri3@gmail.com";
const phone = "9860587826"; 
const location = "Nepal";

class ProfilePageUser extends StatefulWidget {

  @override
  State<ProfilePageUser> createState() => _ProfilePageUserState();
}

class _ProfilePageUserState extends State<ProfilePageUser> {
  String? username="";
  String? phnumber="";
  String? location = '';

  @override
  void initState(){
    getuserdata();
    super.initState();

  }

  getuserdata()async{

    try{
      String uid = FirebaseAuth.instance.currentUser!.uid;

    QuerySnapshot query = await FirebaseFirestore.instance.collection('users').get();

    query.docs.forEach((element) { 

      if(element['uid']==uid){
        print("Found");
        setState(() {
            
            username=element['username'];
            phnumber=element['phone_number'];
            location=element['address'];

            
          
        });
        
      }
    });

    }catch(e){
      print(e.toString());

    }

    




  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffFFFDD0),
        body: SafeArea(
          minimum: const EdgeInsets.only(top: 100),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 100,
                backgroundImage: AssetImage('images/avatar.jpg'),
              ),
              Text(
                username!,
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Pacifico",
                ),
              ),
              
              SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Colors.black,
                ),
              ),

              // we will be creating a new widget name info carrd

              InfoCard(text: phone, icon: Icons.phone, onPressed: () async {}),
              // InfoCard(text: url, icon: Icons.web, onPressed: () async {}),
              InfoCard(
                  text: location!,
                  icon: Icons.location_city,
                  onPressed: () async {}),
              InfoCard(text: "logout", icon: Icons.logout_outlined, onPressed: (){
                FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (c) => FirstScreen()));

              })


              // InfoCard(text: email, icon: Icons.email, onPressed: () async {}),
            ],
          ),
        ));
  }
}





class ProfilePageAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffFFFDD0),
        body: SafeArea(
          minimum: const EdgeInsets.only(top: 100),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 100,
                backgroundImage: AssetImage('images/avatar.jpg'),
              ),
              Text(
                "Sandeep khatri",
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Pacifico",
                ),
              ),
              
              SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Colors.black,
                ),
              ),

              // we will be creating a new widget name info carrd

              InfoCard(text: phone, icon: Icons.phone, onPressed: () async {}),
              // InfoCard(text: url, icon: Icons.web, onPressed: () async {}),
              InfoCard(
                  text: location,
                  icon: Icons.location_city,
                  onPressed: () async {}),
              InfoCard(text: "logout", icon: Icons.logout_outlined, onPressed: (){
                FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (c) => FirstScreen()));

              })


              // InfoCard(text: email, icon: Icons.email, onPressed: () async {}),
            ],
          ),
        ));
  }
}




class InfoCard extends StatelessWidget {
  // the values we need
  final String text;
  final IconData icon;
  VoidCallback onPressed;

  InfoCard(
      {required this.text, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.teal,
          ),
          title: Text(
            text.toUpperCase(),

            style: TextStyle(
                color: Colors.teal,
                fontSize: 20,
                fontFamily: "Source Sans Pro"),
          ),
        ),
      ),
    );
  }
}
