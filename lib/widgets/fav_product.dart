import 'package:flutter/material.dart';
import 'package:gym_in/controllers/favourites_controller.dart';
import 'package:gym_in/services/favourites_service.dart';
import 'package:gym_in/widgets/toast_msg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FavProduct extends HookConsumerWidget {
  const FavProduct({
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
    final favController = ref.watch(favouritesControllerProvider);
    final favProvider = ref.watch(favServiceProvider);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      height: 160,
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
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2.0,
                          color: Colors.redAccent,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          await favProvider.deleteProductsFromFav(productId);
                          favController.removeProduct(productId);
                          aShowToast(msg: "Removed from Favourites");
                        },
                        child: Text(
                          "Remove",
                          style: TextStyle(
                              color: Theme.of(context).backgroundColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
