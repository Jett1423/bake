import 'package:flutter/material.dart';
import 'package:bake/models/cart_item.dart';
import 'package:bake/pages/invoice.dart'; // Assuming you navigate to the invoice page after payment
import 'package:bake/components/my_buttons.dart'; // Assuming this is your custom button component

class Payment extends StatefulWidget {
  final String customerName;
  final String address;
  final String orderType;
  final DateTime date;
  final TimeOfDay time;
  final double totalPrice;
  final List<CartItem> userCart;

  const Payment({
    Key? key,
    required this.customerName,
    required this.address,
    required this.orderType,
    required this.date,
    required this.time,
    required this.totalPrice,
    required this.userCart,
  }) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  String? _selectedPaymentMethod; // To store selected payment method

  @override
  Widget build(BuildContext context) {
    // final baker = Provider.of<Baker>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Payment Method',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildPaymentOption(
                      'Gcash', 'assets/images/gcash.png', 'gcash'),
                  _buildPaymentOption(
                      'Grabpay', 'assets/images/grab.png', 'grabpay'),
                  _buildPaymentOption(
                      'PayMaya', 'assets/images/maya.png', 'paymaya'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            MyButtons(
              text: "Proceed payment",
              onTap: () {
                // Ensure a payment method is selected
                if (_selectedPaymentMethod == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please select a payment method')),
                  );
                  return;
                }

                // baker.completeOrder();

                // Navigate to the Invoice Page after payment
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Invoice(
                      customerName: widget.customerName,
                      address: widget.address,
                      orderType: widget.orderType,
                      date: widget.date,
                      time: widget.time,
                      totalPrice: widget.totalPrice,
                      userCart: widget.userCart,
                      paymentMethod:
                          _selectedPaymentMethod!, // Pass selected payment method
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

  // Helper method to build payment options
  Widget _buildPaymentOption(String title, String imagePath, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(8),
      ),
      child: RadioListTile<String>(
        value: value,
        groupValue: _selectedPaymentMethod,
        onChanged: (String? newValue) {
          setState(() {
            _selectedPaymentMethod = newValue;
          });
        },
        title: Row(
          children: [
            Image.asset(
              imagePath,
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 10),
            Text(title),
          ],
        ),
      ),
    );
  }
}
