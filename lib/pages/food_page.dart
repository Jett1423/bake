import 'package:bake/components/my_buttons.dart';
import 'package:bake/models/baker.dart';
import 'package:bake/models/food.dart';
import 'package:bake/pages/3d.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodPage extends StatefulWidget {
  final Food food;
  final Map<Addon, bool> selectedAddons = {};

  FoodPage({super.key, required this.food}) {
    // Initialize selected addons
    for (Addon addon in food.availableAddons) {
      selectedAddons[addon] = false;
    }
  }

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  //add to cart
  void addToCart(Food food, Map<Addon, bool> selectedAddons) {
    //close current cake page to go back to menu
    Navigator.pop(context);

    //format selected addons
    List<Addon> currentlySelectedAddons = [];
    for (Addon addon in widget.food.availableAddons) {
      if (widget.selectedAddons[addon] == true) {
        currentlySelectedAddons.add(addon);
      }
    }

    //add to cart
    context.read<Baker>().addToCart(food, currentlySelectedAddons);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.food.name,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  // Cake image
                  Image.asset(
                    widget.food.imagepath,
                    height: 350,
                    width: 350,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Cake name
                        Text(
                          widget.food.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        // Cake price
                        Text(
                          "P" + widget.food.price.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Description
                        Text(widget.food.description),
                        Divider(
                          color: Colors.blue,
                        ),
                        Text(
                          "Add-ons",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Add-ons
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(8)),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: widget.food.availableAddons.length,
                              itemBuilder: (context, index) {
                                // Getting addons
                                Addon addon =
                                    widget.food.availableAddons[index];
                                return CheckboxListTile(
                                  title: Text(addon.name),
                                  subtitle: Text("P " + addon.price.toString()),
                                  value: widget.selectedAddons[addon],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      widget.selectedAddons[addon] = value!;
                                    });
                                  },
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                  // Button -> add to cart
                  MyButtons(
                      text: "Add to cart",
                      onTap: () =>
                          addToCart(widget.food, widget.selectedAddons)),
                  // Button -> edit this cake
                ],
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: FloatingActionButton(
                onPressed: () {
                  // Add your AR functionality here
                },
                child: Text(
                  'AR',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                backgroundColor: Colors.blue,
              ),
            ),
            Positioned(
              top: 90,
              right: 20,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          My3d(modelpath: widget.food.modelpath),
                    ),
                  );
                },
                child: Text(
                  '3D',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
