class Category {
  Category(this.categoryName, this.imagePath, this.numberItem);

  final String categoryName;
  final String imagePath;
  final int numberItem;
}

final categoryData = [
  Category(
    'Pizza',
    "images/one.jpg",
    54,
  ),
  Category(
    'Burger',
    "images/two.jpg",
    36,
  ),
  Category(
    'Mo:Mo',
    "images/five.jpg",
    23,
  ),
  Category(
    'Breakfast',
    "images/four.jpg",
    23,
  ),
  Category(
    'Lunch',
    "images/three.jpg",
    33,
  ),
  Category(
    'Desserts',
    "images/six.jpg",
    14,
  ),
];
