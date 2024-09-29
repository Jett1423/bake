import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bake/models/order_details.dart'; // Import the OrderDetails class

class MyDescriptionBox extends StatefulWidget {
  const MyDescriptionBox({super.key});

  @override
  State<MyDescriptionBox> createState() => _MyDescriptionBoxState();
}

class _MyDescriptionBoxState extends State<MyDescriptionBox> {
  @override
  Widget build(BuildContext context) {
    final orderDetails = Provider.of<OrderDetails>(context, listen: true);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.only(
        left: 25,
        right: 25,
        bottom: 10,
      ),
      child: Column(
        children: [
          // Type of Order
          Row(
            children: [
              Expanded(
                child: Text(
                  "Type of Order",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DropdownButton<String>(
                value: orderDetails.orderType,
                onChanged: (newValue) {
                  orderDetails.setOrderType(newValue!);
                },
                items: <String>['Reserve', 'Rush']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Delivery Date
          Row(
            children: [
              Expanded(
                child: Text(
                  "Preferred Date",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: orderDetails.selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != orderDetails.selectedDate) {
                    orderDetails.setDate(picked);
                  }
                },
                child: Text(
                  "${orderDetails.selectedDate.toLocal()}".split(' ')[0],
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Delivery Time
          Row(
            children: [
              Expanded(
                child: Text(
                  "Preferred Time",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: orderDetails.selectedTime,
                  );
                  if (picked != null && picked != orderDetails.selectedTime) {
                    orderDetails.setTime(picked);
                  }
                },
                child: Text(
                  "${orderDetails.selectedTime.format(context)}",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
