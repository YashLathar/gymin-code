import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/models/order.dart';
import 'package:gym_in/pages/booking_result.dart';
import 'package:gym_in/services/orders_service.dart';
import 'package:gym_in/widgets/error_widget.dart';

import 'package:gym_in/models/product_Order.dart';
import 'package:gym_in/widgets/product_order_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final ordersListProvider = FutureProvider.autoDispose<List<Order>>((ref) async {
  ref.maintainState = false;

  final ordersService = ref.watch(ordersServiceProvider);
  final orders = await ordersService.retrievAllGymOrders();
  return orders;
});

final ordersListForProductsProvider =
    FutureProvider.autoDispose<List<ProductOrder>>((ref) async {
  ref.maintainState = false;

  final ordersService = ref.watch(ordersServiceProvider);
  final orders = await ordersService.retrievAllProductOrders();
  return orders;
});

class OrdersPage extends HookConsumerWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider);
    final orders = ref.watch(ordersListProvider);
    final productOrders = ref.watch(ordersListForProductsProvider);
    final tabController = useTabController(initialLength: 2);
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  border: Border.all(
                      width: 2.0, color: Theme.of(context).backgroundColor),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Theme.of(context).textTheme.bodyText2!.color,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Your Orders",
                    style: kSubHeadingStyle.copyWith(
                        color: Theme.of(context).textTheme.bodyText2!.color),
                  ),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  border: Border.all(
                    width: 2.0,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
                child: Center(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      FontAwesomeIcons.plus,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          width: size.width,
          height: 75,
          child: TabBar(
            controller: tabController,
            indicatorColor: Colors.redAccent,
            tabs: [
              Tab(
                child: Text(
                  "Gyms",
                  style: TextStyle(
                      fontSize: 22,
                      color: Theme.of(context).textTheme.bodyText2!.color),
                ),
              ),
              Tab(
                child: Text(
                  "Products",
                  style: TextStyle(
                      fontSize: 22,
                      color: Theme.of(context).textTheme.bodyText2!.color),
                ),
              ),
            ],
          ),
        ),
        Expanded(
            child: TabBarView(
          controller: tabController,
          children: [
            orders.when(
                data: (orders) {
                  return orders.isEmpty
                      ? Center(
                          child: Container(
                            child: Image.asset(
                              "assets/img/animation_1.gif",
                              height: 175.0,
                              width: 150.0,
                            ),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () {
                            return ref.refresh(ordersListProvider.future);
                          },
                          child: ListView(
                            padding: const EdgeInsets.only(top: 10),
                            children: orders
                                .map(
                                  (order) => Card(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.white70, width: 1),
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
                                                      width: 1.0,
                                                      color: Colors.white24))),
                                          child: Icon(Icons.book,
                                              color: Colors.white),
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
                                        trailing: Icon(
                                            Icons.keyboard_arrow_right,
                                            color: Colors.white,
                                            size: 30.0),
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return QrResultScreen(
                                                gymName: order.gymName,
                                                gymPhoto: order.gymPhoto,
                                                userImage: user!.photoURL,
                                                userName: order.userName,
                                                fromDate: order.fromDate,
                                                fromTime: order.fromTime,
                                                planSelected:
                                                    order.planSelected,
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
                      child: ErrorBody(
                          message: "Oops, something unexpected happened"));
                }),
            productOrders.when(
                data: (orders) {
                  return orders.isEmpty
                      ? Center(
                          child: Container(
                            child: Image.asset(
                              "assets/img/animation_1.gif",
                              height: 175.0,
                              width: 150.0,
                            ),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () {
                            return ref.refresh(ordersListProvider.future);
                          },
                          child: ListView(
                            padding: const EdgeInsets.only(top: 10),
                            children: orders
                                .map(
                                  (order) => Card(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.white70, width: 1),
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
                                                      width: 1.0,
                                                      color: Colors.white24))),
                                          child: Icon(Icons.book,
                                              color: Colors.white),
                                        ),
                                        title: Text(
                                          order.productsName[0].length > 20
                                              ? order.productsName[0]
                                                      .substring(0, 20) +
                                                  "..."
                                              : order.productsName[0] + " ...",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          "by: " + user!.displayName!,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        trailing: Icon(
                                            Icons.keyboard_arrow_right,
                                            color: Colors.white,
                                            size: 30.0),
                                        onTap: () async {
                                          final productOrder = await ref.read(ordersServiceProvider)
                                              .getSingleProductOrder(
                                                  order.docId!);

                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return ProductOrderWidget(
                                                productOrder: productOrder,
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
                      child: ErrorBody(
                          message: "Oops, something unexpected happened"));
                }),
          ],
        ))
      ],
    )));
  }
}
