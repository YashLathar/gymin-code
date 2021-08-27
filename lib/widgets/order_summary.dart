import 'package:flutter/material.dart';
import 'package:gym_in/constants.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    Key? key,
    required this.subtotal,
    required this.shipping,
    required this.total,
  }) : super(key: key);

  final String subtotal;
  final String shipping;
  final String total;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Summary",
            style: kSmallContentStyle,
          ),
          Divider(thickness: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal",
                style: kSmallContentStyle,
              ),
              Text(
                "₹" + subtotal,
                style: kSmallContentStyle.copyWith(color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tax",
                style: kSmallContentStyle,
              ),
              Text(
                "₹" + shipping,
                style: kSmallContentStyle.copyWith(color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: kSubHeadingStyle,
              ),
              Text(
                "₹" + total,
                style: kSubHeadingStyle.copyWith(color: Colors.redAccent),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
