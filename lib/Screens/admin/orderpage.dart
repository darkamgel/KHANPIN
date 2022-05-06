import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khan_pin/constants.dart';
import 'package:khan_pin/widgets/food_card_item.dart';
import 'package:khan_pin/widgets/notification_card.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List? docIds = [];

  @override
  void initState() {
    getDocId();

    super.initState();
  }

  getDocId() async {
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        print(element.id);

        docIds!.add(element.id);
      });
    });

    // QuerySnapshot query  = await FirebaseFirestore.instance.collection('admin').get();

    // query.docs.forEach((id) {
    //   if(id.exists){
    //     print(id.data());
    //   }

    // });

    // print(docIds!);
  }

  Widget returnWholeCart() {
    return Container(
        color: Colors.black,
        height: MediaQuery.of(context).size.height / 2,
        child: ListView.builder(
            itemCount: docIds!.length,
            itemBuilder: (context, index) {
              return returnCartSingleItem(docIds![index]);
            }));
  }

  FutureBuilder returnCartSingleItem(String docId) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('cart')
            .doc(docId)
            .collection('items')
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
                color: Colors.blue,
                height: MediaQuery.of(context).size.height / 8,
                child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 20,
                        color: Colors.grey,
                        child: Text(snapshot.data.docs[index]['ProductName']),
                      );
                    }));
          }

          return SizedBox(
            height: 1,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xffeeeeee),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 75,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue[500],
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 50),
                      child: Text(
                        "Order List".toUpperCase(),
                        style: kStyle.copyWith(
                            fontSize: 18.0,
                            color: Colors.white,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Image.asset(
                        "images/logo.png",
                        fit: BoxFit.cover,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              returnWholeCart(),
            ],
            // StreamBuilder(
            //   stream: FirebaseFirestore.instance.collection("cart").doc(FirebaseAuth.instance.currentUser!.uid).collection("items").snapshots(),
            //   builder: (context , orderSnapshot){
            //     return orderSnapshot.hasData ? List
            //   },

            // )
          )),
    );
  }
}

// -------------------------------------------------------------------------------------------------------------------------------------------- //

class OrderPage1 extends StatefulWidget {
  @override
  _OrderPage1State createState() => _OrderPage1State();
}

class _OrderPage1State extends State<OrderPage1> {

  List? docIds = [];
  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xffeeeeee),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 75,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue[500],
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 50),
                      child: Text(
                        "Order List1".toUpperCase(),
                        style: kStyle.copyWith(
                            fontSize: 18.0,
                            color: Colors.white,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Image.asset(
                        "images/logo.png",
                        fit: BoxFit.cover,
                        color: Colors.white,
                      ),
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
                          stream: FirebaseFirestore.instance.collection('cart')
                          .doc('4BcmD5C8KIOXfs2p4m9OpvzVA7k2').collection('items').snapshots(),
                          builder: (context , snapshot){
                            final services = snapshot.data!.docs;
                            List<Widget> servicesWidget = [];
                            for (var st in services){
                              final foodurl = st.get('ProductPhoto');
                              final foodname = st.get('ProductName');
                              final foodcategory = st.get('category');
                              final price =st.get('TotalPrice');
                              final discount =st.get('Discount');
                              final quantity=st.get('Quantity');

                              final datas = FoodCardItemAdminedit(
                                foodurl, 
                                foodname, foodcategory, price, discount, quantity);

                              servicesWidget.add(datas);
                            }
                            return ListView(
                              children: servicesWidget,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                            );
                          },
                        )
                        ),
                    ),
                  ],
                )
              )
              
            ],
          )),
    );
  }
}
