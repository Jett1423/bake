import 'package:flutter/material.dart';

import '../models/food.dart';

class FoodTile extends StatelessWidget {
  final Food food;
  final void Function()? onTap;

  const FoodTile({super.key, required this.food, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                //text food details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('P' + food.price.toString()),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        food.description,
                        style: TextStyle(
                            color: Color.fromARGB(255, 132, 131, 131)),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                //food image
                ClipRRect(
                  child: Image.asset(
                    food.imagepath,
                    height: 120,
                    width: 100,
                  ),
                ),
              ],
            ),
          ),
        ),

        //divider
        Divider(
          color: Colors.black,
        )
      ],
    );
  }
}
