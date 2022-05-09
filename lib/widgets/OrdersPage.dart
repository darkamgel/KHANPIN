import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class OrderCart extends StatefulWidget {
  const OrderCart({Key? key}) : super(key: key);

  @override
  State<OrderCart> createState() => _OrderCartState();
}

class _OrderCartState extends State<OrderCart> {
  bool isLoading = false;
  bool doesOrderExist = false;

  void initState() {
    checkOrder();
    super.initState();
  }

  checkOrder() async {
    try {
      setState(() {
        isLoading = true;
      });
      QuerySnapshot query =
          await FirebaseFirestore.instance.collection("orders").get();

      query.docs.forEach((q) => {
            setState(() {
              if (q['cartId'] == FirebaseAuth.instance.currentUser?.uid) {
                print("INVOKED");
                doesOrderExist = true;
              }
            })
          });
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  FutureBuilder buildData() {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('cart')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection('items')
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.teal
                    ),
                    height: MediaQuery.of(context).size.height / 6,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image(
                                image: NetworkImage(
                                  snapshot.data.docs[index]['ProductPhoto'],
                                ),
                                height: 100),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Food Name : ${snapshot.data.docs[index]['ProductName']}".toUpperCase(),
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15)),
                                    Text(" Quantity : ${snapshot.data.docs[index]['Quantity']}".toUpperCase(),
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15)),
                                    Text("TotalPrice ${snapshot.data.docs[index]['TotalPrice']}",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15)),
                                    Text(
                                        " Status : ${snapshot.data.docs[index]['Delivered']
                                            ? "Delivered"
                                            : "Pending"}", 
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15)),
                                  ]),
                            )
                          ]),
                    )),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.teal,
              title: Text("Your Orders")),
              body: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SafeArea(
                      child: doesOrderExist
                          ? buildData()
                          : Center(
                              child: Text("No Orders",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 20))))),
    );
  }
}
