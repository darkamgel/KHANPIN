import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:khan_pin/Screens/admin/addfood.dart';
import 'package:khan_pin/Screens/admin/updatefoodform.dart';

import 'package:khan_pin/constants.dart';
import 'package:khan_pin/main.dart';

class FoodCardItem extends StatefulWidget {
  final String id;
  final String name;
  final String imagePath;
  final String category;
  final double price;
  final double discount;
  final double ratings;
  FoodCardItem(this.imagePath, this.id, this.category, this.discount, this.name,
      this.price, this.ratings);
  @override
  _FoodCardItemState createState() => _FoodCardItemState();
}

class _FoodCardItemState extends State<FoodCardItem> {
  Future<void> downloadURLExample() async {
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref(widget.imagePath)
        .getDownloadURL();

    // Within your widgets:
    // Image.network(downloadURL);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: <Widget>[
          Container(
            height: 300.0,
            width: 400.0,
            child: Image(image: NetworkImage(widget.imagePath)),
            // child: Image.asset(
            //   widget.imagePath,
            //   fit: BoxFit.cover,
            // ),
          ),
          Positioned(
            left: 0.0,
            bottom: 0.0,
            child: Container(
              height: 70.0,
              width: 400.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff303841),
                    Colors.black38,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Positioned(
            left: 10.0,
            bottom: 10.0,
            right: 10.0,
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 7.0,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: Theme.of(context).primaryColor,
                          size: 18,
                        ),
                        Icon(
                          Icons.star,
                          color: Theme.of(context).primaryColor,
                          size: 18,
                        ),
                        Icon(
                          Icons.star,
                          color: Theme.of(context).primaryColor,
                          size: 18,
                        ),
                        Icon(
                          Icons.star,
                          color: Theme.of(context).primaryColor,
                          size: 18,
                        ),
                        Icon(
                          Icons.star_half,
                          color: Theme.of(context).primaryColor,
                          size: 18,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "(" + widget.ratings.toString() + "Reviews)",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 80.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        widget.price.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xffe23e57),
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Min Order',
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FoodCardItemAdminedit extends StatefulWidget {
  // final String id;
  final String imagePath;
  final String name;
  final String category;

  final String price;
  final String discount;
  final String price_with_discount;
  final String foodUID;
  // final double ratings;
  FoodCardItemAdminedit({required this.foodUID, required this.imagePath, required this.name,required this.category,required this.price,
      required this.discount, required this.price_with_discount});
  @override
  _FoodCardItemAdmineditState createState() => _FoodCardItemAdmineditState();
}

class _FoodCardItemAdmineditState extends State<FoodCardItemAdminedit> {
  Future<void> downloadURLExample() async {
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref(widget.imagePath)
        .getDownloadURL();

    // Within your widgets:
    // Image.network(downloadURL);
    Image.network(downloadURL);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: <Widget>[
            Container(
              // margin: EdgeInsets.only(top: 20),
              height: 200.0,
              width: 400.0,
              // child: Image.network(widget.imagePath),
              child: TextButton(
                onPressed: () {},
                onLongPress: () {
                  showDialog(context: context, builder: (BuildContext context){
                    return AlertDialog(
                      title: Text('Do You Want To Update/Delete ?'),
                      actions: [TextButton(
                        onPressed: ()async{

                          String food_uid = widget.foodUID;

                          QuerySnapshot query = await FirebaseFirestore.instance.collection('food').get();

                          query.docs.forEach((element) async{ 

                            if(element['foodUID']==widget.foodUID){
                              await FirebaseFirestore.instance.collection('food').doc(element.id).delete().whenComplete((){
                            Navigator.pop(context);
                          });


                            }
                          });
                          
                        }, 
                        child: Text("Delete"),
                        
                        ),
                        TextButton(
                          onPressed: (){
                            // Navigator.push(context, MaterialPageRoute(builder: (context){
                            //   return UpdateFoodForm();

                            // }));
                            Navigator.push(context,MaterialPageRoute(builder:(context)=>UpdateFoodForm()));

                          }, 
                          child: Text("Update"))
                        
                        ],
                    );

                  });
                  
                  
                },
                child: Image(
                  image: NetworkImage(widget.imagePath, scale: 1),
                ),
              ),
            ),
            Positioned(
              left: 0.0,
              bottom: 0.0,
              child: Container(
                height: 70.0,
                width: 400.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff303841),
                      Colors.black38,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 10.0,
              bottom: 10.0,
              right: 10.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.name.toUpperCase(),
                          style: kfoodTextStyle.copyWith(color: Colors.green)),
                      Text(
                        "Category: ${widget.category}",
                        style: kDiscountTextStyle.copyWith(color: Colors.green),
                      ),
                      SizedBox(
                        height: 7.0,
                      ),
                    ],
                  ),
                  // SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Rs.${widget.price}",
                          style: kfoodTextStyle.copyWith(
                              color: Colors.amberAccent)),
                      Text(
                        "Rs.${widget.price_with_discount}(${widget.discount}%)",
                        style: kDiscountTextStyle.copyWith(
                            color: Colors.amberAccent),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
