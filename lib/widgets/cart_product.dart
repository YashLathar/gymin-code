import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter_riverpod/src/provider.dart';
import 'package:gym_in/controllers/cart_controller.dart';
import 'package:gym_in/widgets/quantity_counter.dart';

class CartProduct extends StatelessWidget {
  const CartProduct({
    Key? key,
    required this.imageUrl,
    required this.productName,
    required this.price,
    required this.productId,
  }) : super(key: key);

  final String imageUrl;
  final String productName;
  final String price;
  final String productId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        context.read(cartProvider).removeItem(productId);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(imageUrl),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "₹" + price,
                    style: TextStyle(fontSize: 18, color: Colors.redAccent),
                  ),
                  QuantityCounter(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
