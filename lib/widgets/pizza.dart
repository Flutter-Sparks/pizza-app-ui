import 'package:flutter/cupertino.dart';
import 'package:pizza_app_ui/models/pizza_topping.dart';

class Pizza extends StatefulWidget {
  final PizzaSize pizzaSize;
  final List<PizzaTopping> pizzaToppings;
  const Pizza({
    Key? key,
    required this.pizzaSize,
    required this.pizzaToppings,
  }) : super(key: key);

  @override
  State<Pizza> createState() => _PizzaState();
}

class _PizzaState extends State<Pizza> {
  double maxWidth = 550;
  double getSize() {
    switch (widget.pizzaSize) {
      case PizzaSize.small:
        return 0.9;
      case PizzaSize.medium:
        return 1;
      case PizzaSize.large:
        return 1.1;
      default:
        return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints(minWidth: 100, maxWidth: maxWidth),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image(
              width: size.width * (82 / 100),
              image: const AssetImage('assets/pizza/artwork.png'),
            ),
            TweenAnimationBuilder(
                duration: const Duration(milliseconds: 300),
                tween: Tween<double>(begin: 1, end: getSize()),
                builder: (context, value, _) {
                  return Transform.scale(
                    scale: value,
                    child: Image(
                      width: size.width,
                      image: const AssetImage('assets/pizza/pizza.png'),
                    ),
                  );
                }),
            ...widget.pizzaToppings.map(
              (e) => TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 300),
                  tween: Tween<double>(begin: 0, end: getSize() - .1),
                  builder: (context, x, _) {
                    return Transform.scale(
                      scale: x,
                      child: Container(
                        constraints: BoxConstraints(
                            minWidth: 100, maxWidth: maxWidth / 1.7),
                        child: Image(
                          image: AssetImage(
                              'assets/pizza/topping/${e.pizzaImage}'),
                          width: size.width * (50 / 100),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
