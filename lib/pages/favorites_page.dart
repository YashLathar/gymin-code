import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/controllers/favourites_controller.dart';
import 'package:gym_in/widgets/cart_product.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FavoritesPage extends HookWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favProducts = useProvider(favouritesControllerProvider).favProducts;
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
                Expanded(
                  child: Center(
                    child: Text(
                      "Your Favourites",
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
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add_circle,
                        color: Theme.of(context).textTheme.bodyText2!.color,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: favProducts
                  .map((product) => CartProduct(
                        productId: product.productId,
                        imageUrl: product.image,
                        quantity: product.quantity,
                        price: product.price.toString(),
                        productName: product.title,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    ));
  }
}
