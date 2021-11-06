import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/general_providers.dart';
import 'package:gym_in/services/error_Handler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseOrdersService {
  Future<void> addToOrders(
      String gymName, String userPlan, BuildContext context);
  Future<void> retrievAllOrders(String userID);
}

final ordersServiceProvider = Provider<OrdersService>((ref) {
  return OrdersService(ref.read);
});

class OrdersService implements BaseOrdersService {
  final Reader _read;

  OrdersService(this._read);

  @override
  Future<void> addToOrders(
      String gymName, String userPlan, BuildContext context) async {
    final user = _read(authControllerProvider);

    try {
      await _read(firestoreProvider)
          .collection("bookings")
          .doc(user!.uid)
          .collection("userBookings")
          .add({
        "userName": user.displayName,
        "gymName": gymName,
        "userPlan": userPlan,
      });
    } on FirebaseException catch (e) {
      throw ErrorHandler.errorDialog(context, e);
    }
  }

  @override
  Future<void> retrievAllOrders(String userID) {
    // ignore: todo
    // TODO: implement retrievAllOrders
    throw UnimplementedError();
  }
}
