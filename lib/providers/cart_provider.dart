import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addToCart(Map<String, dynamic> recipe, int price) {
    final index = _cartItems.indexWhere((item) => item['id'] == recipe['id']);
    if (index >= 0) {
      _cartItems[index]['quantity'] += 1;
    } else {
      _cartItems.add({
        ...recipe,
        'quantity': 1,
        'price': price, // Save price with item
      });
    }
    notifyListeners();
  }

  void increaseQuantity(Map<String, dynamic> recipe) {
    final index = _cartItems.indexWhere((item) => item['id'] == recipe['id']);
    if (index >= 0) {
      _cartItems[index]['quantity'] += 1;
      notifyListeners();
    }
  }

  void decreaseQuantity(Map<String, dynamic> recipe) {
    final index = _cartItems.indexWhere((item) => item['id'] == recipe['id']);
    if (index >= 0 && _cartItems[index]['quantity'] > 1) {
      _cartItems[index]['quantity'] -= 1;
    } else {
      return;
    }
    notifyListeners();
  }

  void removeFromCart(Map<String, dynamic> recipe) {
    _cartItems.removeWhere((item) => item['id'] == recipe['id']);
    notifyListeners();
  }
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  int get cartCount =>
      _cartItems.fold(0, (sum, item) => sum + (item['quantity'] as int));

  double get totalPrice => _cartItems.fold(
        0,
        (sum, item) => sum + (item['price'] as int) * (item['quantity'] as int),
      );
}
