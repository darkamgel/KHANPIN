import 'package:flutter/material.dart';
import '../../../widgets/Map_Box.dart';
import '../../../widgets/OrdersPage.dart';
// import 'favorite_page.dart';
import 'home_page.dart';
import 'order_page.dart';
import 'profile_page.dart';

class MainHomePage extends StatefulWidget {
  static const String idscreen = "main_page";

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int currentIndex = 0;

  List<Widget> pages = [];
  late Widget currentPage;
  late HomePage homePage;
  late ProfilePageUser profilePage;
  late Order orderPage;
  late OrderCart orderCart;

  @override
  void initState() {
    homePage = HomePage();
    orderPage = Order();
    orderCart = OrderCart();
    profilePage = ProfilePageUser();

    pages = [homePage, orderPage, orderCart, profilePage];

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
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Logout"),
        ],
      ),
      body: currentPage,
    );
  }
}
