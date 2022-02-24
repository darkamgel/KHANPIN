import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:khan_pin/widgets/food_category_method.dart';

import '../data/food_category_data.dart';

class FoodCategory extends StatefulWidget {
  @override
  _FoodCategoryState createState() => _FoodCategoryState();
}

class _FoodCategoryState extends State<FoodCategory> {
  final _categories = categoryData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(55.0),
      ),
      height: 80.0,
      margin: EdgeInsets.only(top: 8.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryData.length,
        itemBuilder: (BuildContext context, int index) {
          return FoodCategoryMethod(_categories[index].numberItem,
              _categories[index].imagePath, _categories[index].categoryName);
        },
      ),
    );
  }
}
