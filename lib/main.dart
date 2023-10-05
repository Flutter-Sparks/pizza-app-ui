import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app_ui/models/pizza_topping.dart';
import 'package:pizza_app_ui/widgets/default_spacing.dart';
import 'package:pizza_app_ui/widgets/pizza.dart';

// github.com/Hemsara

void main() {
  runApp(const PizzaApp());
}

class PizzaApp extends StatelessWidget {
  const PizzaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const PizzaCustomizeScreen(),
    );
  }
}

class PizzaCustomizeScreen extends StatefulWidget {
  const PizzaCustomizeScreen({super.key});

  @override
  State<PizzaCustomizeScreen> createState() => _PizzaCustomizeScreenState();
}

class _PizzaCustomizeScreenState extends State<PizzaCustomizeScreen> {
  PizzaSize selectedPizzaSize = PizzaSize.medium;
  double price = 1760;

  List<PizzaTopping> pizzaToppings = [
    PizzaTopping(
      themeColor: Colors.greenAccent.withOpacity(0.1),
      price: 230,
      name: 'Pepper',
      assetName: 'pepper.png',
      pizzaImage: 'pizza_pepper.png',
    ),
    PizzaTopping(
        price: 100,
        name: 'Mushroom',
        assetName: 'mushroom.png',
        themeColor: Colors.brown.withOpacity(0.1),
        pizzaImage: 'pizza_mushroom.png'),
    PizzaTopping(
        price: 50,
        name: 'Cheese',
        assetName: 'cheese.png',
        themeColor: Colors.yellow.withOpacity(0.1),
        pizzaImage: 'pizza_cheese.png'),
    PizzaTopping(
        price: 70,
        name: 'Tomato',
        assetName: 'tomato.png',
        themeColor: Colors.red.withOpacity(0.1),
        pizzaImage: 'pizza_mushroom.png'),
    PizzaTopping(
        price: 200,
        name: 'Broccoli',
        assetName: 'brocoli.png',
        themeColor: Colors.green.withOpacity(0.1),
        pizzaImage: 'pizza_mushroom.png'),
  ];
  List<PizzaTopping> selectedPizzaToppings = [];

  double getPrice() {
    var sum = selectedPizzaToppings.isEmpty
        ? 0
        : selectedPizzaToppings.map((x) => x.price).reduce((v, e) => v + e);

    return price + sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: const [
          Icon(
            CupertinoIcons.heart_fill,
            color: Colors.pinkAccent,
          ),
          SizedBox(
            width: 20,
          )
        ],
        leading: const Icon(CupertinoIcons.arrow_left),
        title: const Text('Peperoni Pizza'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            FadeInDown(
              duration: const Duration(milliseconds: 900),
              child: Pizza(
                pizzaToppings: selectedPizzaToppings,
                pizzaSize: selectedPizzaSize,
              ),
            ),
            const Spacer(),
            Column(
              children: [
                FadeInDown(
                  duration: const Duration(milliseconds: 800),
                  child: const Text(
                    'The Pepperoni Perfection',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                DefaultSpacing.kVerticalSmall,
                FadeInDown(
                  duration: const Duration(milliseconds: 700),
                  child: Text(
                    'Pepperoni Cheese Pizza: Savor the timeless delight of our pizza featuring savory pepperoni and gooey mozzarella cheese, all on a perfectly baked crust.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                ),
                DefaultSpacing.kVertical,
                // build size selection
                FadeInDown(
                  duration: const Duration(milliseconds: 800),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        PizzaSize.values.map((e) => sizeCircle(e)).toList(),
                  ),
                ),
                DefaultSpacing.kVertical,
                Divider(
                  color: Colors.grey.withOpacity(0.1),
                ),
                DefaultSpacing.kVertical,
                // build topping list
                FadeInDown(
                  duration: const Duration(milliseconds: 800),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        pizzaToppings.map((e) => toppingCircle(e)).toList(),
                  ),
                ),
              ],
            ),
            const Spacer(),
            FadeInDown(
              duration: const Duration(milliseconds: 1000),
              child: GestureDetector(
                onTap: () {},
                child: addToCartButton(context),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Container addToCartButton(BuildContext context) {
    return Container(
      height: 58,
      width: MediaQuery.of(context).size.width / 1.4,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(1000),
          border: Border.all(
            color: Colors.black,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            CupertinoIcons.bag,
            size: 20,
          ),
          const SizedBox(width: 10),
          Text(
            'Rs ${getPrice()} | ADD TO basket'.toUpperCase(),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget toppingCircle(PizzaTopping pizzaTopping) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (selectedPizzaToppings.contains(pizzaTopping)) {
                setState(() {
                  selectedPizzaToppings.remove(pizzaTopping);
                });

                return;
              }
              setState(() {
                selectedPizzaToppings.add(pizzaTopping);
              });
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: selectedPizzaToppings.contains(pizzaTopping)
                  ? pizzaTopping.themeColor
                  : Colors.grey.withOpacity(0.1),
              child: Center(
                child: Image(
                  image: AssetImage('assets/pizza/${pizzaTopping.assetName}'),
                  height: 15,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            pizzaTopping.name.toUpperCase(),
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          )
        ],
      ),
    );
  }

  Widget sizeCircle(PizzaSize size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedPizzaSize = size;
          });
        },
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey.withOpacity(0.1),
          child: Center(
            child: Text(
              size.name.substring(0, 1).toUpperCase(),
              style: TextStyle(
                  fontSize: 12,
                  color: selectedPizzaSize == size
                      ? const Color.fromARGB(255, 76, 76, 76)
                      : Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
