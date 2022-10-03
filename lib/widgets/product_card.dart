import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_in/controllers/favourites_controller.dart';
import 'package:gym_in/models/product.dart';
import 'package:gym_in/services/favourites_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductCard extends HookConsumerWidget {
  const ProductCard({
    Key? key,
    required this.title,
    required this.price,
    required this.image,
    required this.description,
    required this.productId,
  }) : super(key: key);

  final String image;
  final String title;
  final int price;
  final String description;
  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favControllerProvider = ref.watch(favouritesControllerProvider);
    final favProvider = ref.watch(favServiceProvider);
    final isUiLiked = useState(false);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        child: Column(
          children: [
            Container(
              height: 170,
              width: 130,
              child: Hero(
                tag: productId,
                child: Image.network(
                  image,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
            Container(
              height: 120,
              padding: EdgeInsets.symmetric(horizontal: 15),
              width: 170,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300]
                  // Color(0xFF676e8a),
                  // Theme.of(context).scaffoldBackgroundColor,
                  // Color(0xffF2F2F2),
                  ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title.length > 20
                        ? title.substring(0, 20) + "..."
                        : title + " ...",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "₹" + price.toString(),
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w600),
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.redAccent),
                        child: IconButton(
                          onPressed: () async {
                            final thisProduct = favControllerProvider
                                .favProducts
                                .where((product) =>
                                    product.productId == productId);

                            if (thisProduct.isEmpty) {
                              isUiLiked.value = !isUiLiked.value;
                              if (isUiLiked.value) {
                                final product = Product(
                                  description: description,
                                  image: image,
                                  title: title,
                                  price: price,
                                  productId: productId,
                                  isLiked: isUiLiked.value,
                                );

                                await favProvider.addProductToFav(product);

                                favControllerProvider.addProductToFav(product);
                                Fluttertoast.showToast(
                                    msg: "Added to Favourites");
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Already in Favourites");
                            }
                          },
                          icon: Icon(
                            Icons.favorite,
                            size: 15,
                            color:
                                isUiLiked.value ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
