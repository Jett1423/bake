import 'package:bake/models/cart_item.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'food.dart';

class Baker extends ChangeNotifier {
  //list of food menu

  final List<Food> _menu = [
    //anniversary

    Food(
        name: "annivcake 1",
        description: "annivcake 1 desc",
        imagepath: "assets/images/anniversary/a1.png",
        modelpath: "assets/3d/image1.glb",
        price: 450.00,
        category: FoodCategory.anniversary,
        availableAddons: [
          Addon(name: "Normal candle", price: 10.00),
          Addon(name: "Sparkling Fireworks candle ", price: 50.00),
          Addon(name: "Aspen cake stand", price: 100.00),
        ]),
    Food(
        name: "annivcake 2",
        description: "annivcake 2 desc",
        imagepath: "assets/images/anniversary/a2.png",
        modelpath: "assets/3d/image1.glb",
        price: 450.00,
        category: FoodCategory.anniversary,
        availableAddons: [
          Addon(name: "Normal candle", price: 10.00),
          Addon(name: "Sparkling Fireworks candle ", price: 50.00),
          Addon(name: "Aspen cake stand", price: 100.00),
        ]),
    Food(
        name: "annivcake 3",
        description: "annivcake 3",
        imagepath: "assets/images/anniversary/a3.png",
        modelpath: "assets/3d/image1.glb",
        price: 450.00,
        category: FoodCategory.anniversary,
        availableAddons: [
          Addon(name: "Normal candle", price: 10.00),
          Addon(name: "Sparkling Fireworks candle ", price: 50.00),
          Addon(name: "Aspen cake stand", price: 100.00),
        ]),
    Food(
        name: "annivcake 4",
        description: "annivcake 4",
        imagepath: "assets/images/anniversary/a4.png",
        modelpath: "assets/3d/image1.glb",
        price: 450.00,
        category: FoodCategory.anniversary,
        availableAddons: [
          Addon(name: "Normal candle", price: 10.00),
          Addon(name: "Sparkling Fireworks candle ", price: 50.00),
          Addon(name: "Aspen cake stand", price: 100.00),
        ]),
    Food(
        name: "annivcake 5",
        description: "annivcake 5",
        imagepath: "assets/images/anniversary/a5.png",
        modelpath: "assets/3d/image1.glb",
        price: 450.00,
        category: FoodCategory.anniversary,
        availableAddons: [
          Addon(name: "Normal candle", price: 10.00),
          Addon(name: "Sparkling Fireworks candle ", price: 50.00),
          Addon(name: "Aspen cake stand", price: 100.00),
        ]),

    //birthday
    Food(
        name: "bday cake 1",
        description: "bday cake 1",
        imagepath: "assets/images/birthday/b1.png",
        modelpath: "assets/3d/image1.glb",
        price: 100.00,
        category: FoodCategory.birthday,
        availableAddons: [
          Addon(name: "Normal candle", price: 10.00),
          Addon(name: "Sparkling Fireworks candle ", price: 50.00),
          Addon(name: "Aspen cake stand", price: 100.00),
        ]),
    Food(
        name: "bday cake 2",
        description: "bday cake 2",
        imagepath: "assets/images/birthday/b2.png",
        modelpath: "assets/3d/image1.glb",
        price: 100.00,
        category: FoodCategory.birthday,
        availableAddons: [
          Addon(name: "Normal candle", price: 10.00),
          Addon(name: "Sparkling Fireworks candle ", price: 50.00),
          Addon(name: "Aspen cake stand", price: 100.00),
        ]),
    Food(
        name: "bday cake 3",
        description: "bday cake 3",
        imagepath: "assets/images/birthday/b3.png",
        modelpath: "assets/3d/image1.glb",
        price: 100.00,
        category: FoodCategory.birthday,
        availableAddons: [
          Addon(name: "Normal candle", price: 10.00),
          Addon(name: "Sparkling Fireworks candle ", price: 50.00),
          Addon(name: "Aspen cake stand", price: 100.00),
        ]),
    Food(
        name: "bday cake 4",
        description: "bday cake 4",
        imagepath: "assets/images/birthday/b4.png",
        modelpath: "assets/3d/image1.glb",
        price: 100.00,
        category: FoodCategory.birthday,
        availableAddons: [
          Addon(name: "Normal candle", price: 10.00),
          Addon(name: "Sparkling Fireworks candle ", price: 50.00),
          Addon(name: "Aspen cake stand", price: 100.00),
        ]),
    Food(
        name: "bday cake 5",
        description: "bday cake 5",
        imagepath: "assets/images/birthday/b5.png",
        modelpath: "assets/3d/image1.glb",
        price: 100.00,
        category: FoodCategory.birthday,
        availableAddons: [
          Addon(name: "Normal candle", price: 10.00),
          Addon(name: "Sparkling Fireworks candle ", price: 50.00),
          Addon(name: "Aspen cake stand", price: 100.00),
        ]),

    //surprise
    Food(
        name: "surprise cake 1",
        description: "surprise cake 1",
        imagepath: "assets/images/surprise/s1.png",
        modelpath: "assets/3d/image1.glb",
        price: 300.00,
        category: FoodCategory.surprise,
        availableAddons: [
          Addon(name: "Normal candle", price: 10.00),
          Addon(name: "Sparkling Fireworks candle ", price: 50.00),
          Addon(name: "Aspen cake stand", price: 100.00),
        ]),
    Food(
        name: "surprise cake 2",
        description: "surprise cake 1",
        imagepath: "assets/images/surprise/s2.png",
        modelpath: "assets/3d/image1.glb",
        price: 300.00,
        category: FoodCategory.surprise,
        availableAddons: [
          Addon(name: "Normal candle", price: 10.00),
          Addon(name: "Sparkling Fireworks candle ", price: 50.00),
          Addon(name: "Aspen cake stand", price: 100.00),
        ]),
    Food(
        name: "surprise cake 3",
        description: "surprise cake 3",
        imagepath: "assets/images/surprise/s3.png",
        modelpath: "assets/3d/image1.glb",
        price: 300.00,
        category: FoodCategory.surprise,
        availableAddons: [
          Addon(name: "Normal candle", price: 10.00),
          Addon(name: "Sparkling Fireworks candle ", price: 50.00),
          Addon(name: "Aspen cake stand", price: 100.00),
        ]),
    Food(
        name: "surprise cake 4",
        description: "surprise cake 4",
        imagepath: "assets/images/surprise/s4.png",
        modelpath: "assets/3d/image1.glb",
        price: 300.00,
        category: FoodCategory.surprise,
        availableAddons: [
          Addon(name: "Normal candle", price: 10.00),
          Addon(name: "Sparkling Fireworks candle ", price: 50.00),
          Addon(name: "Aspen cake stand", price: 100.00),
        ]),
    Food(
        name: "surprise cake 5",
        description: "surprise cake 5",
        imagepath: "assets/images/surprise/s5.png",
        modelpath: "assets/3d/image1.glb",
        price: 300.00,
        category: FoodCategory.surprise,
        availableAddons: [
          Addon(name: "Normal candle", price: 10.00),
          Addon(name: "Sparkling Fireworks candle ", price: 50.00),
          Addon(name: "Aspen cake stand", price: 100.00),
        ]),

    //teacher
    Food(
        name: "teacher cake 1",
        description: "teacher cake 1",
        imagepath: "assets/images/teacher/t1.png",
        modelpath: "assets/3d/image1.glb",
        price: 500.00,
        category: FoodCategory.teacher,
        availableAddons: [
          Addon(name: "Normal candle", price: 10.00),
          Addon(name: "Sparkling Fireworks candle ", price: 50.00),
          Addon(name: "Aspen cake stand", price: 100.00),
        ]),
    Food(
        name: "teacher cake 2",
        description: "teacher cake 2",
        imagepath: "assets/images/teacher/t2.png",
        modelpath: "assets/3d/image1.glb",
        price: 500.00,
        category: FoodCategory.teacher,
        availableAddons: [
          Addon(name: "Normal candle", price: 10.00),
          Addon(name: "Sparkling Fireworks candle ", price: 50.00),
          Addon(name: "Aspen cake stand", price: 100.00),
        ]),
    Food(
        name: "teacher cake 3",
        description: "teacher cake 3",
        imagepath: "assets/images/teacher/t3.png",
        modelpath: "assets/3d/image1.glb",
        price: 500.00,
        category: FoodCategory.teacher,
        availableAddons: [
          Addon(name: "Normal candle", price: 10.00),
          Addon(name: "Sparkling Fireworks candle ", price: 50.00),
          Addon(name: "Aspen cake stand", price: 100.00),
        ]),
    Food(
        name: "teacher cake 4",
        description: "teacher cake 4",
        imagepath: "assets/images/teacher/t4.png",
        modelpath: "assets/3d/image1.glb",
        price: 500.00,
        category: FoodCategory.teacher,
        availableAddons: [
          Addon(name: "Normal candle", price: 10.00),
          Addon(name: "Sparkling Fireworks candle ", price: 50.00),
          Addon(name: "Aspen cake stand", price: 100.00),
        ]),
    Food(
        name: "teacher cake 5",
        description: "teacher cake 5",
        imagepath: "assets/images/teacher/t5.png",
        modelpath: "assets/3d/image1.glb",
        price: 500.00,
        category: FoodCategory.teacher,
        availableAddons: [
          Addon(name: "Normal candle", price: 10.00),
          Addon(name: "Sparkling Fireworks candle ", price: 50.00),
          Addon(name: "Aspen cake stand", price: 100.00),
        ]),

    //valentines
    Food(
        name: "valentines cake 1",
        description: "valentines cake 1",
        imagepath: "assets/images/valentines/v1.png",
        modelpath: "assets/3d/image1.glb",
        price: 700.00,
        category: FoodCategory.valentines,
        availableAddons: [
          Addon(name: "Normal candle", price: 10.00),
          Addon(name: "Sparkling Fireworks candle ", price: 50.00),
          Addon(name: "Aspen cake stand", price: 100.00),
        ]),
    Food(
        name: "valentines cake 2",
        description: "valentines cake 2",
        imagepath: "assets/images/valentines/v2.png",
        modelpath: "assets/3d/image1.glb",
        price: 700.00,
        category: FoodCategory.valentines,
        availableAddons: [
          Addon(name: "Normal candle", price: 10.00),
          Addon(name: "Sparkling Fireworks candle ", price: 50.00),
          Addon(name: "Aspen cake stand", price: 100.00),
        ]),
    Food(
        name: "valentines cake 3",
        description: "valentines cake 3",
        imagepath: "assets/images/valentines/v3.png",
        modelpath: "assets/3d/image1.glb",
        price: 700.00,
        category: FoodCategory.valentines,
        availableAddons: [
          Addon(name: "Normal candle", price: 10.00),
          Addon(name: "Sparkling Fireworks candle ", price: 50.00),
          Addon(name: "Aspen cake stand", price: 100.00),
        ]),
    Food(
        name: "valentines cake 4",
        description: "valentines cake 4",
        imagepath: "assets/images/valentines/v4.png",
        modelpath: "assets/3d/image1.glb",
        price: 700.00,
        category: FoodCategory.valentines,
        availableAddons: [
          Addon(name: "Normal candle", price: 10.00),
          Addon(name: "Sparkling Fireworks candle ", price: 50.00),
          Addon(name: "Aspen cake stand", price: 100.00),
        ]),
    Food(
        name: "valentines cake 5",
        description: "valentines cake 5",
        imagepath: "assets/images/valentines/v5.png",
        modelpath: "assets/3d/image1.glb",
        price: 700.00,
        category: FoodCategory.valentines,
        availableAddons: [
          Addon(name: "Normal candle", price: 10.00),
          Addon(name: "Sparkling Fireworks candle ", price: 50.00),
          Addon(name: "Aspen cake stand", price: 100.00),
        ]),
  ];

  // User cart and completed/canceled orders lists
  final List<CartItem> _cart = [];
  // Store completed orders as a list of lists (each order is a list of CartItems)
  final List<List<CartItem>> _completedOrders = [];
  final List<CartItem> _canceledOrders = [];

  // A variable to store the order ID
  String? _currentOrderId;

  // Getters
  List<Food> get menu => _menu;
  List<CartItem> get cart => _cart;
  List<List<CartItem>> get completedOrders => _completedOrders;
  List<CartItem> get canceledOrders => _canceledOrders;

  // Add item to cart (assign orderId when adding to the cart)
  void addToCart(Food food, List<Addon> selectedAddons) {
    // Generate an order ID the first time an item is added to the cart
    if (_currentOrderId == null) {
      _currentOrderId = DateTime.now().millisecondsSinceEpoch.toString();
    }

    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      bool isSameFood = item.food == food;
      bool isSameAddons =
          const ListEquality().equals(item.selectedAddons, selectedAddons);
      return isSameFood && isSameAddons;
    });

    if (cartItem != null) {
      cartItem.quantity++;
    } else {
      _cart.add(CartItem(
        food: food,
        selectedAddons: selectedAddons,
        id: _currentOrderId!, // Assign the same order ID to each item in the cart
      ));
    }
    notifyListeners();
  }

  // Remove item from cart
  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);
    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }
    notifyListeners();
  }

  // Complete the current order
  void completeOrder() {
    if (_cart.isNotEmpty) {
      // Move the entire cart to completed orders as a single order (a list of CartItems)
      _completedOrders.add(List.from(_cart)); // Group items as one order
      clearCart(); // Clear the cart after completing the order
    }
  }

  // Clear the cart after order completion
  void clearCart() {
    _cart.clear();
    _currentOrderId = null; // Reset the order ID after completion
    notifyListeners();
  }

// Add this to your Baker class in baker.dart
  void cancelOrder(List<CartItem> orderItems) {
    // Remove from completed orders
    _completedOrders.remove(
        orderItems); // Assuming each 'orderItems' is a group of CartItems
    // Add to canceled orders (optional: if you want to store cancelled orders)
    _canceledOrders.addAll(orderItems); // Move each item to the canceled list
    notifyListeners(); // Notify listeners to update the UI
  }

  // Get total price
  double getTotalPrice() {
    double total = 0.0;
    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;
      for (Addon addon in cartItem.selectedAddons) {
        itemTotal += addon.price;
      }
      total += itemTotal * cartItem.quantity;
    }
    return total;
  }

  // Get total item count
  int getTotalItemCount() {
    int totalCount = 0;
    for (CartItem cartItem in _cart) {
      totalCount += cartItem.quantity;
    }
    return totalCount;
  }
}
  /*
  HELPERS
  */

// generate receipt

//format double value into money

