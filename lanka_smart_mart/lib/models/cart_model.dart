import 'package:flutter/material.dart';
import 'product_model.dart';

class CartModel extends ChangeNotifier {
  final Map<String, CartItemModel> _items = {};

  Map<String, CartItemModel> get items => _items;

  int get itemCount => _items.length;

  double get totalPrice {
    double total = 0.0;
    _items.forEach((key, item) {
      total += item.totalPrice;
    });
    return total;
  }

  void addItem(ProductModel product, int quantity) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity += quantity;
    } else {
      _items[product.id] = CartItemModel(
        product: product,
        quantity: quantity,
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void updateQuantity(String productId, int quantity) {
    if (_items.containsKey(productId)) {
      if (quantity <= 0) {
        _items.remove(productId);
      } else {
        _items[productId]!.quantity = quantity;
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  bool isEmpty() => _items.isEmpty;

  List<CartItemModel> getCartItems() => _items.values.toList();
}
