import 'package:flutter/material.dart';

class OrderDetails extends ChangeNotifier {
  String _orderType = "Reserve";
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  String get orderType => _orderType;
  DateTime get selectedDate => _selectedDate;
  TimeOfDay get selectedTime => _selectedTime;

  void setOrderType(String newValue) {
    _orderType = newValue;
    notifyListeners();
  }

  void setDate(DateTime newDate) {
    _selectedDate = newDate;
    notifyListeners();
  }

  void setTime(TimeOfDay newTime) {
    _selectedTime = newTime;
    notifyListeners();
  }
}
