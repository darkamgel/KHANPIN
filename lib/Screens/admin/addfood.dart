import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khan_pin/Refactorcodes/buttons.dart';
import 'package:khan_pin/Screens/admin/homescreenadmin.dart';
import 'package:khan_pin/constants.dart';
import 'package:khan_pin/widgets/loading_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart' as fstorage;

class AddFoodForm extends StatefulWidget {
  
  static const String idscreen = "foodform";
  AddFoodForm({Key? key}) : super(key: key);

  @override
  State<AddFoodForm> createState() => _AddFoodFormState();
}

class _AddFoodFormState extends State<AddFoodForm> {
  bool ? update;
  TextEditingController food_category_controller = TextEditingController();
  TextEditingController food_name_controller = TextEditingController();
  TextEditingController food_price_controller = TextEditingController();
  TextEditingController food_dicount_controller = TextEditingController();

  TextEditingController totalprice_controller = TextEditingController();

  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  String foodImageUrl = "";

  Future<void> formvalidation() async {
    if (imageXFile == null) {
      displayToastMessage("Please select an food image", context);
    }
    if (food_category_controller.text.isNotEmpty &&
        food_name_controller.text.isNotEmpty &&
        food_price_controller.text.isNotEmpty &&
        food_dicount_controller.text.isNotEmpty) {
      showDialog(
          context: context,
          builder: (c) {
            return LoadingDialog(
              message: "Saving Data...",
            );
          });

      String fileName = DateTime.now().microsecondsSinceEpoch.toString();
      fstorage.Reference reference = fstorage.FirebaseStorage.instance
          .ref()
          .child("foodimage")
          .child(fileName);
      fstorage.UploadTask uploadTask =
          reference.putFile(File(imageXFile!.path));
      fstorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      await taskSnapshot.ref.getDownloadURL().then((url) {
        foodImageUrl = url;

        //  save info to firestore database
      });
    } else {
      displayToastMessage("Fill The All Required Field", context);
    }
  }

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageXFile;
    });
  }

  Future saveDatatoFirestore(User currentUser) async {
    FirebaseFirestore.instance.collection("food").add({
      "foodUID": currentUser.uid,
      "foodurl": foodImageUrl,
      "foodcategory": food_category_controller.text.trim(),
      "foodname": food_name_controller.text.trim(),
      "price": food_price_controller.text.trim(),
      "discount": food_dicount_controller.text.trim(),
      "price_with_discount": totalprice_controller.text.trim(),
    }).whenComplete(() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (c) => Homepageadmin()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Admin Panel"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  _getImage();
                },
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.20,
                  backgroundColor: Colors.blueAccent.shade200,
                  backgroundImage: imageXFile == null
                      ? null
                      : FileImage(File(imageXFile!.path)),
                  child: imageXFile == null
                      ? Icon(
                          Icons.add_photo_alternate,
                          size: MediaQuery.of(context).size.width * 0.20,
                          color: Colors.grey,
                        )
                      : null,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  onChanged: (value) {
                    food_category_controller.text = value;
                  },
                  textAlign: TextAlign.center,
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: "Enter food Category (Drinks,fastfood)",
                      hintStyle: kHintStyle),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  onChanged: (value) {
                    food_name_controller.text = value;
                  },
                  textAlign: TextAlign.center,
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: "Food Name", hintStyle: kHintStyle),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    food_price_controller.text = value;
                  },
                  textAlign: TextAlign.center,
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: "Price(Rs)", hintStyle: kHintStyle),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    food_dicount_controller.text = value;
                  },
                  textAlign: TextAlign.center,
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: "Discount(%)", hintStyle: kHintStyle),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  controller: totalprice_controller,
                  enabled: false,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: "Total Price With Discount",
                      hintStyle: kHintStyle),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25),
                child: Button1(
                    color: Colors.yellow,
                    button_name: "Generate Total Amount",
                    onPress: () {
                      double dis_rate =
                          double.parse(food_dicount_controller.text) / 100;

                      double dis_amount =
                          double.parse(food_price_controller.text) * dis_rate;

                      double total_price =
                          double.parse(food_price_controller.text) - dis_amount;

                      totalprice_controller.text = total_price.toString();

                      // totalprice_controller = food_price_controller - (food_price_controller * (food_dicount_controller / 100));
                    },
                    height: 42,
                    width: 150),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Button1(
                      color: Colors.red,
                      button_name: "Back",
                      width: 150,
                      height: 42,
                      onPress: () {
                        Navigator.pop(context);
                      }),
                  Button1(
                      color: Colors.red,
                      button_name: "Submit",
                      width: 150,
                      height: 42,
                      onPress: () async {
                        await formvalidation();

                        if (FirebaseAuth.instance.currentUser != null) {
                          await saveDatatoFirestore(firebaseAuth.currentUser!);
                        }
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
