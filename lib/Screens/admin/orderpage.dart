import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khan_pin/Screens/admin/Worldmap.dart';
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
  List? cartId = [];
  List? cartItems = [];

  bool isLoading = false;

  @override
  void initState() {
    call_necessary();
    super.initState();
  }



  call_necessary() async {
    await getCartId();
    await getcartItems();
  }

  getCartId() async {
    try {
      setState(() {
        isLoading = true;
      });

      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('orders').get();
      querySnapshot.docs.forEach((x) {
        cartId!.add(x['cartId']);
      });

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  getcartItems() async {
    print(cartId);
    try {
      setState(() {
        isLoading = true;
      });

      cartId = cartId!.toSet().toList();

      print(cartId);

      for (int i = 0; i <= cartId!.length; ++i) {
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('cart')
            .doc(cartId![i])
            .collection('items')
            .doc('random')
            .get();

        cartItems!.add(doc.data());
        print(cartItems);
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
    }
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
                    ),
                  ],
                ),
              ),

              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: ListView.builder(
                          itemCount: cartId!.length,
                          itemBuilder: (context, index) {
                            bool isDelivered = cartItems![index]['Delivered'];

                          
                            
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WorldMap(
                                               cart_id: cartId![index],
                                            )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.teal),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  'Product Id ${cartItems![index]["ProductName"].toString()}'),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  'Total Price ${cartItems![index]["TotalPrice"].toString()}'),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  "Category ${cartItems![index]["category"].toString()}"),
                                            )
                                          ],
                                        ),
                                        Checkbox(
                                            value: isDelivered,
                                            onChanged: (value) async {
                                              QuerySnapshot query =
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('cart')
                                                      .doc(cartId![index])
                                                      .collection('items')
                                                      .get();

                                              query.docs.forEach((element) {
                                                if (element['Timestamp'] ==
                                                    cartItems![index]
                                                        ['Timestamp']) {
                                                  FirebaseFirestore.instance
                                                      .collection('cart')
                                                      .doc(cartId![index])
                                                      .collection('items')
                                                      .doc(element.id)
                                                      .update(
                                                          {"Delivered": value});
                                                }
                                              });

                                              setState(() async {
                                                cartItems![index]['Delivered'] =
                                                    value;
                                              });
                                            })
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })),

              // Expanded(
              //   child: ListView(
              //     children: [
              //       SingleChildScrollView(
              //         child: Center(
              //           child: StreamBuilder<QuerySnapshot>(
              //             stream: FirebaseFirestore.instance.collection('cart').snapshots(),
              //             builder: (context , snapshot){
              //               final services = snapshot.data!.docs;
              //               print("HERE");
              //               services.forEach((element) {
              //                 print('hereeee');
              //                 print(element.data());
              //                });
              //               List<Widget> servicesWidget = [];
              //               for (var st in services){
              //                 final foodurl = st.get('ProductPhoto');
              //                 final foodname = st.get('ProductName');
              //                 final foodcategory = st.get('category');
              //                 final price =st.get('TotalPrice');
              //                 final discount =st.get('Discount');
              //                 final quantity=st.get('Quantity');
              //                 final food_id=st.get('FoodUID');

              //                 final datas = FoodCardItemAdminedit(foodUID: food_id, imagePath: foodurl, name: foodname, category: foodcategory, price: price, discount: discount, price_with_discount: "10");

              //                 servicesWidget.add(datas);
              //               }
              //               return ListView(
              //                 children: servicesWidget,
              //                 shrinkWrap: true,
              //                 physics: NeverScrollableScrollPhysics(),
              //               );
              //             },
              //           )
              //           ),
              //       ),
              //     ],
              //   )
              // )
            ],
          )),
    );
  }
}
