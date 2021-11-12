import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:gym_in/models/product.dart';
import 'package:gym_in/services/cart_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final cartProvider = ChangeNotifierProvider<CartContoller>((ref) {
  return CartContoller(ref.read);
});

class CartContoller extends ChangeNotifier {
  final Reader _read;
  List<Product> _products = [];

  CartContoller(this._read) : super() {
    retrieveItemFromCart();
  }

  UnmodifiableListView<Product> get products => UnmodifiableListView(_products);

  int get totalPrice => _products.fold(
      0, (int total, item) => total + item.price * item.quantity);

  Future<void> retrieveItemFromCart() async {
    final cartProducts = await _read(cartServiceProvider).getCartItems();

    _products = cartProducts;

    notifyListeners();
  }

  void addProduct(Product product) {
    _products.add(product);

    notifyListeners();
  }

  void removeProduct(String productId) {
    _products.removeWhere((product) => product.productId == productId);

    notifyListeners();
  }

  void incrementProductQuantity(String productId) {
    _products.map((product) {
      if (productId == product.productId) {
        return product.quantity += 1;
      }
    }).toList();

    notifyListeners();
  }

  void decrementProductQuantity(String productId) {
    _products.map((product) {
      if (productId == product.productId) {
        if (product.quantity > 1) {
          return product.quantity -= 1;
        }
      }
    }).toList();

    notifyListeners();
  }
}
