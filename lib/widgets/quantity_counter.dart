import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_in/controllers/cart_controller.dart';
import 'package:gym_in/widgets/toast_msg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuantityCounter extends HookWidget {
  const QuantityCounter(
      {Key? key, required this.productId, required this.quantity})
      : super(key: key);

  final String productId;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    final cart = useProvider(cartProvider);

    return Container(
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              cart.decrementProductQuantity(productId);
            },
            child: Container(
              margin: EdgeInsets.only(right: 10),
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffF2F2F2),
              ),
              child: Center(
                child: Icon(
                  FontAwesomeIcons.minus,
                  size: 15,
                ),
              ),
            ),
          ),
          Center(
            child: Text(
              "0$quantity",
              style: TextStyle(fontSize: 18),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (quantity < 3) {
                cart.incrementProductQuantity(productId);
              } else {
                aShowToast(msg: "Cannot add more products");
              }
            },
            child: Container(
              margin: EdgeInsets.only(left: 10),
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffF2F2F2),
              ),
              child: Center(
                child: Icon(
                  FontAwesomeIcons.plus,
                  size: 15,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
