import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/baker.dart'; // Import Baker model to access canceled orders
import '../pages/cart_page.dart'; // Import Baker model to access canceled order
import '../models/cart_item.dart'; // Import Baker model to access canceled orders

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final baker = Provider.of<Baker>(context); // Access the Baker provider
    final canceledOrders = baker.canceledOrders; // Access canceled orders

    // Group canceled orders by order ID
    final groupedCanceledOrders = <String, List<CartItem>>{};
    for (var cartItem in canceledOrders) {
      if (groupedCanceledOrders.containsKey(cartItem.id)) {
        groupedCanceledOrders[cartItem.id]!.add(cartItem);
      } else {
        groupedCanceledOrders[cartItem.id] = [cartItem];
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order History"),
        backgroundColor: Colors.blue,
      ),
      body: groupedCanceledOrders.isNotEmpty
          ? ListView.builder(
              itemCount: groupedCanceledOrders.length,
              itemBuilder: (context, index) {
                final orderId = groupedCanceledOrders.keys.elementAt(index);
                final orderItems = groupedCanceledOrders[orderId]!;

                return Card(
                  margin: const EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(color: Colors.blue, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row for Order ID and the three-dot button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Display Order ID
                            Text(
                              'Order ID: $orderId',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            // Three-dot button aligned to the top-right corner
                            PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'Buy Again') {
                                  // Add all items from the order to the cart
                                  for (var item in orderItems) {
                                    baker.addToCart(
                                        item.food, item.selectedAddons);
                                  }
                                  // Navigate to cart page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const CartPage(),
                                    ),
                                  );
                                }
                              },
                              itemBuilder: (BuildContext context) {
                                return {'Buy Again'}.map((String choice) {
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Text(choice),
                                  );
                                }).toList();
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Display each item in the order
                        Column(
                          children: orderItems.map((cartItem) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: [
                                  Image.asset(
                                    cartItem.food.imagepath,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Cake: ${cartItem.food.name}',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      const Text(
                                        'Cancelled',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: Text("No canceled orders."),
            ),
    );
  }
}
