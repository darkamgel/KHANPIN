import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

import '../../../data/food_card_data.dart';
import '../../../widgets/food_category.dart';
import '../../../widgets/food_card_item.dart';

User? loggedInuser = FirebaseAuth.instance.currentUser;
// CollectionReference users = FirebaseFirestore.instance.collection('users');

//Data

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;

  List<FoodData> _foods = foodsData;

  final textStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 40,
  );

  @override
  Widget build(BuildContext context) {
    // final users =Provider.of<QuerySnapshot>(context);
    return Scaffold(
      backgroundColor: Color(0xffeeeeee),
      body: ListView(
        padding: EdgeInsets.only(top: 50.0, left: 4.0, right: 4.0),
        children: <Widget>[
          //top bar info
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 2, left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        ' k khane ho ta?',
                        style: textStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 5, bottom: 45.0),
                  child: Icon(
                    Icons.notifications_none,
                    color: Color(0xffe23e57),
                    size: 35,
                  ),
                ),
              ],
            ),
          ),

          //food card
          FoodCategory(),

          //search info
          Searchbar(
            onPress: (){
            print("hello");
            },
            margin: 15,
            
            ),

          //bought info
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Frequently Bought Foods',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Color(0xff303841),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'View All',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Color(0xffe23e57),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: _foods.map(_buildFoodItem).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodItem(FoodData foodData) {
    return Container(
        margin: EdgeInsets.only(bottom: 20.0),
        child: FoodCardItem(
            foodData.imagePath,
            foodData.id,
            foodData.category,
            foodData.discount,
            foodData.name,
            foodData.price,
            foodData.ratings));
  }
}

class Searchbar extends StatelessWidget {

  final VoidCallback onPress;
  final double margin;

  Searchbar({required this.onPress , required this.margin});
 

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: margin),
      child: Material(
        color: Colors.white,
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        child: TextField(
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
            hintText: 'Search Foods',
            hintStyle: TextStyle(
              fontSize: 18.0,
              color: Color(0xff303841),
              letterSpacing: 2.0,
            ),
            suffixIcon: Material(
              color: Colors.white,
              elevation: 3.0,
              borderRadius: BorderRadius.circular(30.0),
              child: 
              // ElevatedButton.icon(
              //   onPressed: (){print("hello");}, 
              //   icon: Icon(Icons.search , color: Color(0xffe23e57),), 
              //   label: Text('')),
              TextButton.icon(

                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(42.0)),
                  elevation: 0,
                ),
                
                onPressed: onPress,
               icon: Icon(Icons.search,color: Color(0xffe23e57),),
               label: Text(''))
              
              // Icon(
              //   Icons.search,
              //   color: Color(0xffe23e57),
              //   size: 30.0,
              // ),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
