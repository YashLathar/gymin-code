import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/models/gym.dart';
import 'package:gym_in/models/product.dart';
import 'package:gym_in/services/favourites_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final favouritesControllerProvider =
    ChangeNotifierProvider<FavouritesContorller>((ref) {
  return FavouritesContorller(ref.read);
});

class FavouritesContorller extends ChangeNotifier {
  final Reader _read;
  List<Product> _favProducts = [];
  List<Gym> _favGyms = [];

  FavouritesContorller(this._read) : super() {
    retrieveProductsFromFirebase();
    retrieveGymsFromFirebase();
  }

  UnmodifiableListView<Product> get favProducts =>
      UnmodifiableListView(_favProducts);
  UnmodifiableListView<Gym> get favGyms => UnmodifiableListView(_favGyms);

  Future<void> retrieveProductsFromFirebase() async {
    final favProducts = await _read(favServiceProvider).getProductsFromFav();

    _favProducts = favProducts;

    notifyListeners();
  }

  Future<void> retrieveGymsFromFirebase() async {
    final favGyms = await _read(favServiceProvider).getGymsFromFav();

    _favGyms = favGyms;

    notifyListeners();
  }

  void addProductToFav(Product product) {
    _favProducts.add(product);
    _favProducts.map((item) {
      if (item.productId == product.productId) {
        return product.isLiked = true;
      }
    }).toList();

    notifyListeners();
  }

  void removeProduct(String productId) {
    _favProducts.removeWhere((product) => product.productId == productId);

    notifyListeners();
  }

  void addGymToFav(Gym gym) async {
    _favGyms.add(gym);

    notifyListeners();
  }

  void removeGym(String gymId) {
    _favGyms.removeWhere((gym) => gym.gymId == gymId);

    notifyListeners();
  }
}
