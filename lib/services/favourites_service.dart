import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/custom_exception.dart';
import 'package:gym_in/general_providers.dart';
import 'package:gym_in/models/gym.dart';
import 'package:gym_in/models/product.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseFavService {
  Future<void> addProductToFav(Product product);
  Future<List<Product>> getProductsFromFav();
  Future<void> deleteProductsFromFav(String docId);
  Future<void> addGymToFav(Gym gym);
  Future<List<Gym>> getGymsFromFav();
  Future<void> deleteGymFromFav(String docId);
}

final favServiceProvider = Provider<FavService>((ref) {
  final user = ref.read(authControllerProvider);
  return FavService(ref.read, user);
});

class FavService implements BaseFavService {
  final Reader _read;
  final User? user;

  FavService(this._read, this.user);

  @override
  Future<void> addProductToFav(Product product) async {
    try {
      await _read(firestoreProvider)
          .collection("favorites")
          .doc(user!.uid)
          .collection("favoriteProduct")
          .add({
        "image": product.image,
        "title": product.title,
        "price": product.price,
        "description": product.description,
      });
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }

  @override
  Future<void> deleteProductsFromFav(String docId) async {
    try {
      await _read(firestoreProvider)
          .collection("favorites")
          .doc(user!.uid)
          .collection("favoriteProduct")
          .doc(docId)
          .delete();
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }

  @override
  Future<List<Product>> getProductsFromFav() async {
    try {
      final docs = await _read(firestoreProvider)
          .collection("favorites")
          .doc(user!.uid)
          .collection("favoriteProduct")
          .get();

      return docs.docs.map((data) {
        return Product.fromDocument(data);
      }).toList();
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }

  @override
  Future<void> addGymToFav(Gym gym) async {
    try {
      await _read(firestoreProvider)
          .collection("favorites")
          .doc(user!.uid)
          .collection("favoriteGym")
          .add({
        "image": gym.gymPhoto,
        "title": gym.gymName,
        "address": gym.gymaddress,
      });
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }

  @override
  Future<void> deleteGymFromFav(String docId) async {
    try {
      await _read(firestoreProvider)
          .collection("favorites")
          .doc(user!.uid)
          .collection("favoriteGym")
          .doc(docId)
          .delete();
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }

  @override
  Future<List<Gym>> getGymsFromFav() async {
    try {
      final docs = await _read(firestoreProvider)
          .collection("favorites")
          .doc(user!.uid)
          .collection("favoriteGym")
          .get();

      return docs.docs.map((data) {
        return Gym.fromDocument(data);
      }).toList();
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }
}
