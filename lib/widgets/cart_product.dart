import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// ignore: implementation_imports
import 'package:flutter_riverpod/src/provider.dart';
import 'package:gym_in/controllers/cart_controller.dart';
import 'package:gym_in/services/cart_service.dart';
import 'package:gym_in/widgets/quantity_counter.dart';

class CartProduct extends HookWidget {
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
    final isLoading = useState(false);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      height: 160,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "₹" + price,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        isLoading.value = true;
                        if (isLoading.value) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Container(
                                  color: Colors.transparent,
                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white,
                                      ),
                                      height: 100,
                                      width: 100,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }

                        await context
                            .read(cartServiceProvider)
                            .removeItemFromCart(productId);

                        isLoading.value = false;
                        Navigator.pop(context);
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
