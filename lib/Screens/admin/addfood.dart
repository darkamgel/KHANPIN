import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khan_pin/Refactorcodes/buttons.dart';
import 'package:khan_pin/constants.dart';

class AddFoodForm extends StatefulWidget {
  AddFoodForm({Key? key}) : super(key: key);

  @override
  State<AddFoodForm> createState() => _AddFoodFormState();
}

class _AddFoodFormState extends State<AddFoodForm> {
  TextEditingController food_category_controller = TextEditingController();
  TextEditingController food_name_controller = TextEditingController();
  TextEditingController food_price_controller = TextEditingController();
  TextEditingController food_dicount_controller = TextEditingController();
  TextEditingController location_controller = TextEditingController();

  late double discount;

  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> formvalidation() async {
    if (imageXFile == null) {
      displayToastMessage("Please select an food image", context);

    } else if (food_category_controller.text.isNotEmpty &&
        food_name_controller.text.isNotEmpty &&
        food_price_controller.text.isNotEmpty &&
        food_dicount_controller.text.isNotEmpty &&
        location_controller.text.isNotEmpty) {

        }

        else{
          displayToastMessage("Fill The All Required Field", context);
        }
  }
  

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageXFile;
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
                  enabled: false,
                  onChanged: (value) {
                    location_controller.text = value;
                  },
                  textAlign: TextAlign.center,
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: "Resturant Location", hintStyle: kHintStyle),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 400,
                height: 40,
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                  onPressed: () {
                    debugPrint("Button test");
                  },
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Get My Current Location",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Button1(
                      color: Colors.red, button_name: "Back", onPress: () {}),
                  Button1(
                      color: Colors.red,
                      button_name: "Submit",
                      onPress: () {
                        formvalidation();
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
