import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/baker.dart'; // Import Baker model to access completed and canceled orders
import 'home_page.dart'; // Import HomePage for navigation

class OrderStatusPage extends StatefulWidget {
  const OrderStatusPage({super.key});

  @override
  State<OrderStatusPage> createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage> {
  // Function to request changes in the order
  void requestChanges(String orderId) {
    print('Requesting changes for Order ID: $orderId');
  }

  // Function to cancel an order (with confirmation dialog)
  void cancelOrder(String orderId, Baker baker) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure you want to cancel this order?'),
          content: const Text('Request for cancellation of order'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final index = baker.completedOrders.indexWhere((orderList) =>
                    orderList[0].id == orderId); // Find order by ID

                if (index != -1) {
                  final orderItems = baker.completedOrders[index];

                  // Remove the order from completedOrders
                  baker.cancelOrder(
                      orderItems); // Call the updated cancelOrder method from Baker

                  Navigator.of(context).pop(); // Close the dialog

                  // Show confirmation that the request was sent
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: const Text('Order has been cancelled.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: const Text('Close'),
                          ),
                        ],
                      );
                    },
                  );

                  print('Order ID $orderId has been cancelled');
                }
              },
              child: const Text(
                'Request',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final baker =
        Provider.of<Baker>(context); // Access the Baker model using Provider
    final orders = baker.completedOrders; // Get the completed orders

    // Hardcoded statuses for demonstration (replace this with real statuses if available)
    List<String> statuses = [
      'reviewing',
      'finalizing',
      'finished',
      'cancelled'
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Orders",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Custom back button
          onPressed: () {
            // Navigate to the home page when back button is pressed
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
      ),
      body: orders.isNotEmpty
          ? ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final orderItems =
                    orders[index]; // List of CartItems for this order
                final String orderId =
                    orderItems[0].id; // Use the shared order ID

                // Cycle through hardcoded statuses or use actual status logic
                final String orderStatus = statuses[index % statuses.length];

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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Display order ID and status
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Order ID: $orderId',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Order Status: $orderStatus',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            // Three-dot popup menu
                            PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'Request Changes') {
                                  requestChanges(orderId);
                                } else if (value == 'Cancel Order') {
                                  cancelOrder(orderId, baker);
                                }
                              },
                              itemBuilder: (BuildContext context) => [
                                const PopupMenuItem(
                                  value: 'Request Changes',
                                  child: Text('Request Changes'),
                                ),
                                const PopupMenuItem(
                                  value: 'Cancel Order',
                                  child: Text(
                                    'Cancel Order',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Display each item in the order directly (no dropdown)
                        Column(
                          children: orderItems.map((cartItem) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
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
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                          Text(
                                            'Quantity: ${cartItem.quantity}',
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  // Display selected addons, if any
                                  if (cartItem.selectedAddons.isNotEmpty)
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(top: 4.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center, // Center the addons horizontally
                                          children: [
                                            const Text(
                                              'Addons:',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(
                                                height:
                                                    4), // Add some space between the 'Addons' label and the actual addons
                                            ...cartItem.selectedAddons.map(
                                              (addon) => Text(
                                                '${addon.name}                                  ',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                                textAlign: TextAlign
                                                    .center, // Ensure that each addon text is centered
                                              ),
                                            ),
                                          ],
                                        )),
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
              child: Text("No orders yet."),
            ),
    );
  }
}
