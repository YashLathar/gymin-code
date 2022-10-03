import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/controllers/cart_controller.dart';
import 'package:gym_in/services/cart_service.dart';
import 'package:gym_in/widgets/quantity_counter.dart';
import 'package:gym_in/widgets/toast_msg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartProduct extends HookConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider);
    final isLoading = useState(false);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      height: 130,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).scaffoldBackgroundColor),
      child: Row(
        children: [
          Container(
            width: 130,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(imageUrl),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName.length > 20
                      ? productName.substring(0, 20) + "..."
                      : productName + " ...",
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
                                      height: 80,
                                      width: 80,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }

                        await ref.read(cartServiceProvider)
                            .removeItemFromCart(productId, user!.uid);

                        isLoading.value = false;
                        Navigator.pop(context);
                        ref.read(cartProvider).removeProduct(productId);
                        aShowToast(msg: "Product has been removed from Cart");
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
