import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/custom_exception.dart';
import 'package:gym_in/general_providers.dart';
import 'package:gym_in/models/product.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseCartService {
  Future<List<Product>> getCartItems(String userUID);
  Future<void> addItemToCart({
    required Product product,
    required String userUID,
  });
  Future<void> removeItemFromCart(
    String docID,
    String userUID,
  );
}

final cartServiceProvider = Provider<CartService>((ref) {
  return CartService(ref.read);
});

class CartService implements BaseCartService {
  final Reader _read;

  CartService(this._read);

  @override
  Future<void> addItemToCart({
    required Product product,
    required String userUID,
  }) async {
    try {
      await _read(firestoreProvider)
          .collection("cart")
          .doc(userUID)
          .collection("userCart")
          .doc(product.productId)
          .set({
        "image": product.image,
        "title": product.title,
        "price": product.price,
        "description": product.description,
        "timeStamp": FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }

  @override
  Future<List<Product>> getCartItems(String userUID) async {
    try {
      final documents = await _read(firestoreProvider)
          .collection("cart")
          .doc(userUID)
          .collection("userCart")
          .get();

      final products =
          documents.docs.map((doc) => Product.fromDocument(doc)).toList();

      return products;
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }

  @override
  Future<void> removeItemFromCart(
    String docID,
    String userUID,
  ) async {
    try {
      await _read(firestoreProvider)
          .collection("cart")
          .doc(userUID)
          .collection("userCart")
          .doc(docID)
          .delete();
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }
}
