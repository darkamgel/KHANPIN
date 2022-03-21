import 'package:flutter/material.dart';
import 'package:khan_pin/Screens/admin/addfood.dart';

class Homepageadmin extends StatefulWidget {
  Homepageadmin({Key? key}) : super(key: key);

  @override
  State<Homepageadmin> createState() => _HomepageadminState();
}

class _HomepageadminState extends State<Homepageadmin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (c) => AddFoodForm(),
                            ),
                          );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
