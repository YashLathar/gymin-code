import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/general_providers.dart';
import 'package:gym_in/models/order.dart';
import 'package:gym_in/services/error_Handler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseOrdersService {
  Future<void> addToOrders(
    String gymName,
    String bookingFromTiming,
    String bookingToTime,
    String userPlan,
    String date,
    String gymPhoto,
    BuildContext context,
  );
  Future<List<Order>> retrievAllOrders();
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
  Future<DocumentReference> addToOrders(
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
      });
      return doc;
    } on FirebaseException catch (e) {
      throw ErrorHandler.errorDialog(context, e);
    }
  }

  @override
  Future<List<Order>> retrievAllOrders() async {
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
}
