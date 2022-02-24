class FoodData {
  FoodData(this.id, this.name, this.imagePath, this.category, this.price,
      this.discount, this.ratings);

  final String id;
  final String name;
  final String imagePath;
  final String category;
  final double price;
  final double discount;
  final double ratings;
}

final foodsData = [
  FoodData(
    '6',
    'Coffe',
    'images/six.jpg',
    '6',
    6.0,
    10.5,
    99.4,
  ),
  FoodData(
    '5',
    'spaghetti',
    'images/five.jpg',
    '5',
    17.0,
    20.0,
    99.1,
  ),
  FoodData(
    '4',
    'Breakfast',
    'images/four.jpg',
    '4',
    11.0,
    25.0,
    99.0,
  ),
  FoodData(
    '3',
    'Lunch',
    'images/three.jpg',
    '3',
    21.0,
    20.0,
    98.4,
  ),
  FoodData(
    '2',
    'Burger',
    'images/two.jpg',
    '2',
    10.5,
    15.0,
    98.4,
  ),
  FoodData(
    '1',
    'Pizza',
    'images/one.jpg',
    '1',
    25.4,
    10.0,
    98.2,
  ),
];
