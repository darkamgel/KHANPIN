import 'package:flutter/material.dart';
import '../../../widgets/Map_Box.dart';
import 'favorite_page.dart';
import 'home_page.dart';
import 'order_page.dart';
import 'profile_page.dart';

class MainHomePage extends StatefulWidget {
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int currentIndex = 0;

  List<Widget> pages = [];
  late Widget currentPage;
  late HomePage homePage;
  late ProfilePage profilePage;
  late Order orderPage;
  late FavoritePage favPage;
  late GoogleMapsDraw maps;

  @override
  void initState() {
    homePage = HomePage();
    orderPage = Order();
    profilePage = ProfilePage();
    favPage = FavoritePage();
    maps = GoogleMapsDraw();

    pages = [homePage, orderPage, favPage, maps, profilePage];

    currentPage = homePage;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.note_alt), label: "Orders"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Maps"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Logout"),
        ],
      ),
      body: currentPage,
    );
  }
}
