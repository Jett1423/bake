import 'package:bake/components/my_quantity_selector.dart';
import 'package:bake/models/baker.dart';
import 'package:bake/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCartTile extends StatelessWidget {
  final CartItem cartItem;
  const MyCartTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<Baker>(
      builder: (context, baker, child) => Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // food image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      cartItem.food.imagepath,
                      height: 100,
                      width: 100,
                    ),
                  ),

                  const SizedBox(width: 10),

                  // name and price
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // cake name
                        Text(
                          cartItem.food.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // cake price
                        Text(
                          "P${cartItem.food.price}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // increment and decrement of quantity
                  QuantitySelector(
                    food: cartItem.food,
                    quantity: cartItem.quantity,
                    onIncrement: () {
                      baker.addToCart(cartItem.food, cartItem.selectedAddons);
                    },
                    onDecrement: () {
                      baker.removeFromCart(cartItem);
                    },
                  )
                ],
              ),
            ),

            // addons
            if (cartItem.selectedAddons.isNotEmpty)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding:
                        const EdgeInsets.only(left: 5, bottom: 5, right: 5),
                    children: cartItem.selectedAddons
                        .map((addon) => Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: FilterChip(
                                label: Row(
                                  children: [
                                    //addon name
                                    Text(addon.name),

                                    //addon price
                                    Text(' (P${addon.price})')
                                  ],
                                ),
                                onSelected: (value) {},
                              ),
                            ))
                        .toList(),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
