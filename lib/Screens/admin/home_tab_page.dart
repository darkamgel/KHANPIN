import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khan_pin/Screens/admin/homescreenadmin.dart';
import 'package:khan_pin/Screens/admin/orderpage.dart';
// import 'package:khan_pin/Screens/users/OTP/favorite_page.dart';
import 'package:khan_pin/Screens/users/OTP/order_page.dart';
import 'package:khan_pin/Screens/users/OTP/profile_page.dart';
import '../../../widgets/Map_Box.dart';


class MainHomePageAdmin extends StatefulWidget {

  static const String idscreen = "admin_tab";
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePageAdmin> {
  int currentIndex = 0;

  List<Widget> pages = [];
  late Widget currentPage;
  late Homepageadmin homePage;
  late ProfilePage profilePage;
  late OrderPage favPage;
  late GoogleMapsDraw maps;

  @override
  void initState() {
    homePage = Homepageadmin();
    
    profilePage = ProfilePage();
    favPage = OrderPage();
    maps = GoogleMapsDraw();

    pages = [homePage,  favPage, maps, profilePage];

    currentPage = homePage;

    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            setState(() {
              currentIndex = index;
              currentPage = pages[index];
            });
          },
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            
            BottomNavigationBarItem(icon: Icon(Icons.note_alt), label: "Orders"),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: "Maps"),
            BottomNavigationBarItem(

              
                icon: Icon(Icons.person_outline), label: "Logout" , 

                 ),
          ],
        ),
        body: currentPage,
      ),
    );
  }
}



