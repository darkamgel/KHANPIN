import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khan_pin/Screens/admin/addfood.dart';
import 'package:khan_pin/Screens/users/OTP/home_page.dart';

import 'package:khan_pin/constants.dart';
import 'package:khan_pin/firstScreen.dart';
import 'package:khan_pin/widgets/food_card_item.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class Homepageadmin extends StatefulWidget {
  static const String idscreen = "home_admin";
  Homepageadmin({Key? key}) : super(key: key);

  @override
  State<Homepageadmin> createState() => _HomepageadminState();
}

class _HomepageadminState extends State<Homepageadmin> {
  @override
  void initState() {
    // _fetchName();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> downloadURLExample() async {
    // Within your widgets:
    // Image.network(downloadURL);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffFFFDD0),
        // backgroundColor: ,
        // appBar: AppBar(
        //   title: Text("Food List" , style: kStyle,),
        //   // centerTitle: true,
        //   automaticallyImplyLeading: false,
        //   elevation: 2,
        //   leading: GestureDetector(onTap: (){
        //     FirebaseAuth.instance.signOut();
        //     Navigator.of(context)
        //             .push(MaterialPageRoute(builder: (c) => FirstScreen()));
        //   } , child: Icon(Icons.close),),

        // ),

        body: Column(
          children: [
            Container(
              height: 75,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.blue[500],
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(0),
                      bottomLeft: Radius.circular(50))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Text(
                      " Welcome ${resturantName} ".toUpperCase(),
                      style: kStyle.copyWith(
                          fontSize: 18.0,
                          color: Colors.white,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  Image.asset(
                    "images/logo.png",
                    fit: BoxFit.cover,
                    color: Colors.white,
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                children: [
                  SingleChildScrollView(
                    child: Center(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('food')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final services = snapshot.data!.docs;
                            List<Widget> servicesWidget = [];
                            for (var st in services) {
                              final foodurl = st.get('foodurl');
                              final foodname = st.get('foodname');
                              final foodcategory = st.get('foodcategory');

                              final price = st.get('price');
                              final discount = st.get('discount');
                              final total_price = st.get('price_with_discount');
                              final food_id = st.get('foodUID');

                              // final datas = FoodCardItemAdmin(category,url,name );
                              final datas = FoodCardItemAdminedit(foodUID: food_id, imagePath: foodurl, name: foodname, category: foodcategory, price: price, discount: discount, price_with_discount: total_price);

                              // final datas = buildTile(category, name, url, context);
                              servicesWidget.add(datas);
                              print(foodurl);
                            }

                            return ListView(
                              children: servicesWidget,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                            );
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Route newRoute = MaterialPageRoute(builder: (c) => AddFoodForm());
            // Navigator.push(context, newRoute);
            Navigator.pushNamed(context, AddFoodForm.idscreen);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

