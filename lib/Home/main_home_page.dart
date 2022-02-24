import 'package:flutter/material.dart';
import '../Screens/favorite_page.dart';
import '../Screens/home_page.dart';
import '../Screens/order_page.dart';
import '../Screens/profile_page.dart';

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

  @override
  void initState() {
    homePage = HomePage();
    orderPage = Order();
    profilePage = ProfilePage();
    favPage = FavoritePage();
    pages = [homePage, orderPage, favPage, profilePage];

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
              icon: Icon(Icons.shopping_cart), label: "Order"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Logout"),
        ],
      ),
      body: currentPage,
    );
  }
}
