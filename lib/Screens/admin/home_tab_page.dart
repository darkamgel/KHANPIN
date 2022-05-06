
import 'package:flutter/material.dart';
import 'package:khan_pin/Screens/admin/homescreenadmin.dart';
import 'package:khan_pin/Screens/admin/orderpage.dart';


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
  late ProfilePageAdmin profilePage;
  late OrderPage1 favPage;
  late GoogleMapsDraw maps;


  

  @override
  void initState() {
    

    homePage = Homepageadmin();
    
    profilePage = ProfilePageAdmin();
    favPage = OrderPage1();
    maps = GoogleMapsDraw();

    pages = [homePage,  favPage, maps , profilePage];

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
              activeIcon: Icon(Icons.home,color: Colors.red,),
              label: 'Home',
            ),
            
            BottomNavigationBarItem(icon: Icon(Icons.note_alt), label: "Orders" , activeIcon: Icon(Icons.note_alt,color: Colors.red,),),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: "Maps",activeIcon: Icon(Icons.map,color: Colors.red,),),
            BottomNavigationBarItem(

              
                icon: Icon(Icons.person_outline), label: "Profile", 
                activeIcon: Icon(Icons.person_outline , color: Colors.red,)

                 ),
          ],
        ),
        body: currentPage,
      ),
    );
  }
}



