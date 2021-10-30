import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter_riverpod/src/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_in/controllers/cart_controller.dart';

class QuantityCounter extends StatelessWidget {
  const QuantityCounter(
      {Key? key, required this.productId, required this.quantity})
      : super(key: key);

  final String productId;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              context.read(cartProvider).decrementProductQuantity(productId);
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
              context.read(cartProvider).incrementProductQuantity(productId);
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
