import 'package:bake/components/my_buttons.dart';
import 'package:bake/components/my_cart_tile.dart';
import 'package:bake/models/baker.dart';
import 'package:bake/pages/checkout.dart';
import 'package:bake/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bake/models/order_details.dart'; // Import OrderDetails class

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  // Function to calculate total price of all items in the cart
  double calculateTotalPrice(List<CartItem> userCart) {
    // Accessing the totalPrice getter from CartItem
    return userCart.fold(0.0, (sum, cartItem) => sum + cartItem.totalPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Baker>(
      builder: (context, baker, child) {
        // cart
        final userCart = baker.cart;

        // calculate total price
        final totalPrice = calculateTotalPrice(userCart);

        // Fetch order details from provider
        final orderDetails = Provider.of<OrderDetails>(context);

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("Cart"),
            actions: [
              // clear all
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                          "Are you sure you want to clear the cart?"),
                      actions: [
                        // cancel button
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                        // yes
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            baker.clearCart();
                          },
                          child: const Text("Yes"),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    userCart.isEmpty
                        ? const Expanded(
                            child: Center(
                              child: Text(
                                "Cart is empty...",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: userCart.length,
                              itemBuilder: (context, index) {
                                // get individual cart item
                                final cartItem = userCart[index];

                                // return cart UI (MyCartTile will access the cartItem details)
                                return MyCartTile(
                                  cartItem: cartItem,
                                );
                              },
                            ),
                          ),
                  ],
                ),
              ),
              // Display total price
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Total Price: \P${totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // button checkout
              MyButtons(
                text: "Checkout",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Checkout(
                        orderType: orderDetails.orderType,
                        date: orderDetails.selectedDate,
                        time: orderDetails.selectedTime,
                        totalPrice: totalPrice,
                        userCart: userCart,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
