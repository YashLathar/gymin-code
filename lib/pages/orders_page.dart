import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/models/order.dart';
import 'package:gym_in/pages/booking_result.dart';
import 'package:gym_in/services/orders_service.dart';
import 'package:gym_in/widgets/error_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final ordersListProvider = FutureProvider.autoDispose<List<Order>>((ref) async {
  ref.maintainState = false;

  final ordersService = ref.watch(ordersServiceProvider);
  final orders = await ordersService.retrievAllOrders();
  return orders;
});

class OrdersPage extends HookWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = useProvider(authControllerProvider);
    final orders = useProvider(ordersListProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text("Orders"),
      ),
      body: orders.when(
          data: (orders) {
            return RefreshIndicator(
              onRefresh: () {
                return context.refresh(ordersListProvider);
              },
              child: ListView(
                padding: const EdgeInsets.only(top: 10),
                children: orders
                    .map(
                      (order) => Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 8.0,
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 6.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xff676e8a),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            leading: Container(
                              padding: EdgeInsets.only(right: 12.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                          width: 1.0, color: Colors.white24))),
                              child: Icon(Icons.book, color: Colors.white),
                            ),
                            title: Text(
                              order.gymName,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              order.userName ?? "username",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            trailing: Icon(Icons.keyboard_arrow_right,
                                color: Colors.white, size: 30.0),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return QrResultScreen(
                                    gymName: order.gymName,
                                    userImage: user!.photoURL,
                                    userName: order.userName,
                                    fromDate: order.fromDate,
                                    fromTime: order.fromTime,
                                    planSelected: order.planSelected,
                                    docId: order.docId,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, s) {
            return Center(
                child:
                    ErrorBody(message: "Oops, something unexpected happened"));
          }),
    );
  }
}
