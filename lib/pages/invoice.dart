import 'package:flutter/material.dart';
import 'package:bake/models/cart_item.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:bake/components/my_buttons.dart'; // Custom button component
import 'package:bake/pages/order_status.dart'; // Import OrderStatus page
import 'package:provider/provider.dart';
import 'package:bake/models/baker.dart';

class Invoice extends StatefulWidget {
  final String customerName;
  final String address;
  final String orderType;
  final DateTime date;
  final TimeOfDay time;
  final double totalPrice;
  final List<CartItem> userCart;
  final String paymentMethod;

  const Invoice({
    Key? key,
    required this.customerName,
    required this.address,
    required this.orderType,
    required this.date,
    required this.time,
    required this.totalPrice,
    required this.userCart,
    required this.paymentMethod,
  }) : super(key: key);

  @override
  _InvoiceState createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  @override
  Widget build(BuildContext context) {
    // Format the date properly
    final baker = Provider.of<Baker>(context, listen: false);
    String formattedDate = DateFormat('yyyy-MM-dd').format(widget.date);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Invoice',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Customer and Order Information
            _buildInfoBox(
              'Customer Information',
              [
                _buildInfoRow('Name', widget.customerName),
                _buildInfoRow('Address', widget.address),
                _buildInfoRow('Order Type', widget.orderType),
                _buildInfoRow('Date', formattedDate),
                _buildInfoRow('Time', widget.time.format(context)),
                _buildInfoRow('Payment Method', widget.paymentMethod),
              ],
            ),
            const SizedBox(height: 20),

            // Ordered Items Section
            const Text(
              'Your Cart:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.userCart.length,
              itemBuilder: (context, index) {
                final cartItem = widget.userCart[index];
                return _buildCartItem(cartItem);
              },
            ),
            const SizedBox(height: 20),

            // Total Price Section
            _buildInfoBox(
              'Total Price',
              [
                Text(
                  'P${widget.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Proceed Button
            MyButtons(
              text: 'Proceed to Order Status',
              onTap: () {
                baker.completeOrder();
                // Navigate to OrderStatusPage
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderStatusPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build an information box
  Widget _buildInfoBox(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  // Helper method to build individual info rows
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Build Cart Item UI with Addons
  Widget _buildCartItem(CartItem cartItem) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Image.asset(
                cartItem.food.imagepath,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(cartItem.food.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Quantity: ${cartItem.quantity}'),
                  const SizedBox(height: 4),
                  if (cartItem.selectedAddons.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Selected Addons:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ...cartItem.selectedAddons.map((addon) {
                          return Text(
                              '${addon.name} (P${addon.price.toStringAsFixed(2)})');
                        }).toList(),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
