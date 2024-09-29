import 'package:bake/components/my_buttons.dart';
import 'package:bake/models/cart_item.dart';
import 'package:bake/pages/payment.dart';
import 'package:flutter/material.dart';

class Checkout extends StatefulWidget {
  final String orderType;
  final DateTime date;
  final TimeOfDay time;
  final double totalPrice;
  final List<CartItem> userCart; // Accept cart items

  const Checkout({
    Key? key,
    required this.orderType,
    required this.date,
    required this.time,
    required this.totalPrice,
    required this.userCart, // Add this to the constructor
  }) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _pinLocationController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'David Manalo');
    _addressController =
        TextEditingController(text: 'Grand Central Residences');
    _pinLocationController =
        TextEditingController(text: 'Grand Central Residences');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _pinLocationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildEditableRow('Customer name', _nameController),
            buildEditableRow('Address', _addressController),
            buildEditableRow('Pin Location', _pinLocationController),
            buildRow('Order type', widget.orderType),
            buildRow(
                'Preferred date', "${widget.date.toLocal()}".split(' ')[0]),
            buildRow('Preferred time', widget.time.format(context)),
            const SizedBox(height: 20),

            // Display Cart Items
            const Text(
              'Your Cart:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),

            ListView.builder(
              shrinkWrap: true, // Important to make it work in a Column
              physics:
                  const NeverScrollableScrollPhysics(), // Disable scrolling for this ListView
              itemCount: widget.userCart.length,
              itemBuilder: (context, index) {
                final cartItem = widget.userCart[index];
                return buildCartItem(cartItem);
              },
            ),
            const SizedBox(height: 20),

            // Total Price Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Price:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'P${widget.totalPrice.toStringAsFixed(2)}', // Add ₱ before the formatted total price
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Checkout Button
            MyButtons(
              text: 'Proceed to Payment',
              onTap: () {
                // Pass the user data from Checkout to the Payment page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Payment(
                      customerName: _nameController.text,
                      address: _addressController.text,
                      orderType: widget.orderType,
                      date: widget.date,
                      time: widget.time,
                      totalPrice: widget.totalPrice,
                      userCart: widget.userCart,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Build Cart Item UI with selected addons
  Widget buildCartItem(CartItem cartItem) {
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
                        const SizedBox(
                          height: 10,
                        ),
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

  Widget buildEditableRow(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
              ),
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
