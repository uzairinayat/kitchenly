import 'package:flutter/material.dart';

class CheckoutProvider with ChangeNotifier {
String? _selectedMethod;

  String? get selectedMethod => _selectedMethod;

  void selectMethod(String method) {
    _selectedMethod = method;
    notifyListeners();
  }

  bool isSelected(String method) => _selectedMethod == method;


}
