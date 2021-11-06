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
    required this.quantity,
  }) : super(key: key);

  final String imageUrl;
  final String productName;
  final String price;
  final String productId;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).scaffoldBackgroundColor),
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
                Row(
                  children: [
                    Text(
                      "₹" + price,
                      style: TextStyle(fontSize: 18, color: Colors.redAccent),
                    ),
                    SizedBox(
                      width: size.width / 5,
                    ),
                    IconButton(
                      onPressed: () {
                        context.read(cartProvider).removeProduct(productId);
                      },
                      icon: Icon(
                        Icons.remove_shopping_cart,
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                  ],
                ),
                QuantityCounter(
                  productId: productId,
                  quantity: quantity,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
