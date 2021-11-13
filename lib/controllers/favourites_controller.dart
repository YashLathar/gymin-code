import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:gym_in/models/gym.dart';
import 'package:gym_in/models/product.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final favouritesControllerProvider = ChangeNotifierProvider<FavouritesContorller>((ref) {
  return FavouritesContorller(ref.read);
});

class FavouritesContorller extends ChangeNotifier {
  final Reader _read;
  List<Product> _favProducts = [];
  List<Gym> _favGyms = [];

  FavouritesContorller(this._read);  // : super();

  UnmodifiableListView<Product> get favProducts =>
      UnmodifiableListView(_favProducts);
  UnmodifiableListView<Gym> get favGyms => UnmodifiableListView(_favGyms);

  void addProductToFav(Product product) {
    _favProducts.add(product);

    notifyListeners();
  }

  void removeProduct(String productId) {
    _favProducts.removeWhere((product) => product.productId == productId);

    notifyListeners();
  }

  void addGymToFav(Gym gym) {
    _favGyms.add(gym);

    notifyListeners();
  }

  void removeGym(String gymId) {
    _favGyms.removeWhere((gym) => gym.gymId == gymId);

    notifyListeners();
  }
}
