import 'dart:ui';

enum PizzaSize { small, medium, large }

class PizzaTopping {
  final double price;
  final String name;
  final String pizzaImage;
  final Color themeColor;
  final String assetName;
  PizzaTopping({
    required this.price,
    required this.name,
    required this.pizzaImage,
    required this.themeColor,
    required this.assetName,
  });
}
