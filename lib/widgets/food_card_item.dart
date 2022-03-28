import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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
            child: Image.asset(
              widget.imagePath,
              fit: BoxFit.cover,
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

class FoodCardItemAdmin extends StatefulWidget {
  
  // final String id;
  final String name;
  final String imagePath;
  final String category;
  // final double price;
  // final double discount;
  // final double ratings;
  FoodCardItemAdmin(this.imagePath, this.category, this.name,
      );
  @override
  _FoodCardItemAdminState createState() => _FoodCardItemAdminState();
}

class _FoodCardItemAdminState extends State<FoodCardItemAdmin> {
  // String ? downloadURL;


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
   
    return ClipRRect(
      
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20),
            height: 200.0,
            width: 400.0,
            // child: Image.network(widget.imagePath),
            child: Image(image: NetworkImage(widget.imagePath),)
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
                    // Row(
                    //   children: <Widget>[
                    //     Icon(
                    //       Icons.star,
                    //       color: Theme.of(context).primaryColor,
                    //       size: 18,
                    //     ),
                    //     Icon(
                    //       Icons.star,
                    //       color: Theme.of(context).primaryColor,
                    //       size: 18,
                    //     ),
                    //     Icon(
                    //       Icons.star,
                    //       color: Theme.of(context).primaryColor,
                    //       size: 18,
                    //     ),
                    //     Icon(
                    //       Icons.star,
                    //       color: Theme.of(context).primaryColor,
                    //       size: 18,
                    //     ),
                    //     Icon(
                    //       Icons.star_half,
                    //       color: Theme.of(context).primaryColor,
                    //       size: 18,
                    //     ),
                    //     SizedBox(
                    //       height: 5.0,
                    //     ),
                    //     // Text(
                    //     //   "(" + widget.ratings.toString() + "Reviews)",
                    //     //   style: TextStyle(
                    //     //     color: Colors.white,
                    //     //   ),
                    //     // ),
                    //   ],
                    // ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 80.0),
                  child: Column(
                    children: <Widget>[
                      // Text(
                      //   widget.price.toString(),
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     color: Color(0xffe23e57),
                      //     fontSize: 20.0,
                      //   ),
                      // ),
                      SizedBox(
                        height: 5.0,
                      ),
                      // Text(
                      //   'Min Order',
                      //   style: TextStyle(color: Colors.white, fontSize: 15.0),
                      // ),
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
