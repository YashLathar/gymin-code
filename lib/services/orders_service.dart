import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/custom_exception.dart';
import 'package:gym_in/general_providers.dart';
import 'package:gym_in/models/order.dart';
import 'package:gym_in/models/product_Order.dart';
import 'package:gym_in/services/error_Handler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseOrdersService {
  Future<void> addToGymOrders(
    String gymName,
    String bookingFromTiming,
    String bookingToTime,
    String userPlan,
    String date,
    String gymPhoto,
    BuildContext context,
  );
  Future<void> addToProductOrders(
    List<String> productsName,
    List<String> productsPhotos,
    int totalPrice,
  );
  Future<Order> getSingleGymOrder(String docId);
  Future<ProductOrder> getSingleProductOrder(String docId);
  Future<Order> authenticateGymOrder(String docId);
  Future<List<Order>> retrievAllGymOrders();
  Future<List<ProductOrder>> retrievAllProductOrders();
}

final ordersServiceProvider = Provider<OrdersService>((ref) {
  final user = ref.read(authControllerProvider);
  return OrdersService(ref.read, user);
});

class OrdersService implements BaseOrdersService {
  final Reader _read;
  final User? user;

  OrdersService(this._read, this.user);

  @override
  Future<DocumentReference> addToGymOrders(
    String gymName,
    String gymPhoto,
    String bookingFromTiming,
    String bookingToTime,
    String userPlan,
    String date,
    BuildContext context,
  ) async {
    try {
      final doc = await _read(firestoreProvider)
          .collection("bookings")
          .doc(user!.uid)
          .collection("userBookings")
          .add({
        "userName": user!.displayName,
        "gymName": gymName,
        "userPlan": userPlan,
        "bookingFromTiming": bookingFromTiming,
        "bookingToTiming": bookingToTime,
        "gymPhoto": gymPhoto,
        "date": date,
        "timeStamp": FieldValue.serverTimestamp(),
      });

      await _read(firestoreProvider)
          .collection("allGymBookings")
          .doc(doc.id)
          .set({
        "userName": user!.displayName,
        "gymName": gymName,
        "userPlan": userPlan,
        "bookingFromTiming": bookingFromTiming,
        "bookingToTiming": bookingToTime,
        "gymPhoto": gymPhoto,
        "date": date,
        "timeStamp": FieldValue.serverTimestamp(),
      });
      return doc;
    } on FirebaseException catch (e) {
      throw ErrorHandler.errorDialog(context, e);
    }
  }

  @override
  Future<List<Order>> retrievAllGymOrders() async {
    try {
      final documentSnapshots = await _read(firestoreProvider)
          .collection("bookings")
          .doc(user!.uid)
          .collection("userBookings")
          .get();

      final orders = documentSnapshots.docs.map((order) {
        return Order(
          docId: order.id,
          gymPhoto: order.data()["gymPhoto"],
          userImage: user!.photoURL,
          userName: user!.displayName,
          fromTime: order.data()["bookingFromTiming"],
          fromDate: order.data()["date"],
          gymName: order.data()["gymName"],
          planSelected: order.data()["userPlan"],
        );
      }).toList();

      return orders;
    } on FirebaseException catch (e) {
      throw Text(e.message ?? "ERROR");
    }
  }

  @override
  Future<Order> getSingleGymOrder(String docId) async {
    try {
      final documentSnapshot = await _read(firestoreProvider)
          .collection("bookings")
          .doc(user!.uid)
          .collection("userBookings")
          .doc(docId)
          .get();

      if (documentSnapshot.exists) {
        final order = Order(
          gymName: documentSnapshot.data()!["gymName"],
          docId: docId,
          fromDate: documentSnapshot.data()!["date"],
          fromTime: documentSnapshot.data()!["bookingFromTiming"],
          planSelected: documentSnapshot.data()!["userPlan"],
          gymPhoto: documentSnapshot.data()!["gymPhoto"],
          userName: documentSnapshot.data()!["userName"],
        );
        return order;
      } else {
        final mtyOrder = Order.mtOrder();

        return mtyOrder;
      }
    } on FirebaseException catch (e) {
      throw Text(e.message ?? "ERROR");
    }
  }

  @override
  Future<DocumentReference> addToProductOrders(
    List<String> productsName,
    List<String> productsPhotos,
    int totalPrice,
  ) async {
    try {
      final doc = await _read(firestoreProvider)
          .collection("bookings")
          .doc(user!.uid)
          .collection("userProductOrders")
          .add({
        "productsPhotos": productsPhotos,
        "productsName": productsName,
        "totalPrice": totalPrice,
        "timeStamp": FieldValue.serverTimestamp(),
      });

      return doc;
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }

  @override
  Future<ProductOrder> getSingleProductOrder(String docId) async {
    try {
      final documentSnapshot = await _read(firestoreProvider)
          .collection("bookings")
          .doc(user!.uid)
          .collection("userProductOrders")
          .doc(docId)
          .get();

      if (documentSnapshot.exists) {
        final productOrder = ProductOrder(
          productsName: documentSnapshot.data()!["productsName"],
          productsPhotos: documentSnapshot.data()!["productsPhotos"],
          totalPrice: documentSnapshot.data()!["totalPrice"],
        );
        return productOrder;
      } else {
        final mtOrder = ProductOrder.mtProductOrder();

        return mtOrder;
      }
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }

  @override
  Future<List<ProductOrder>> retrievAllProductOrders() async {
    try {
      final documentSnapshots = await _read(firestoreProvider)
          .collection("bookings")
          .doc(user!.uid)
          .collection("userProductOrders")
          .get();

      final orders = documentSnapshots.docs.map((order) {
        return ProductOrder(
          productsName: order.data()["productsName"],
          productsPhotos: order.data()["productsPhotos"],
          totalPrice: order.data()["totalPrice"],
          docId: order.id,
        );
      }).toList();

      return orders;
    } on FirebaseException catch (e) {
      throw CustomExeption(message: e.message);
    }
  }

  @override
  Future<Order> authenticateGymOrder(String docId) async {
    try {
      final documentSnapshot = await _read(firestoreProvider)
          .collection("allGymBookings")
          .doc(docId)
          .get();

      if (documentSnapshot.exists) {
        final order = Order(
          gymName: documentSnapshot.data()!["gymName"],
          docId: docId,
          fromDate: documentSnapshot.data()!["date"],
          fromTime: documentSnapshot.data()!["bookingFromTiming"],
          planSelected: documentSnapshot.data()!["userPlan"],
          gymPhoto: documentSnapshot.data()!["gymPhoto"],
          userName: documentSnapshot.data()!["userName"],
        );
        return order;
      } else {
        final mtyOrder = Order.mtOrder();

        return mtyOrder;
      }
    } on FirebaseException catch (e) {
      throw Text(e.message ?? "ERROR");
    }
  }
}
