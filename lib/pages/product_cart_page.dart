import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/controllers/cart_controller.dart';
import 'package:gym_in/widgets/cart_product.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductCartPage extends HookWidget {
  ProductCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartControllerProvider = useProvider(cartProvider);
    // print(cartControllerProvider.products);
    Size size = MediaQuery.of(context).size;
    return Material(
      color: Color(0xffF2F2F2),
      child: SafeArea(
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.width,
              child: cartControllerProvider.products.isEmpty
                  ? Column(
                      children: [
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "My Cart",
                                    style: kSubHeadingStyle,
                                  ),
                                ),
                              ),
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.add_shopping_cart_outlined,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 240,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/img/empty-cart.gif",
                                height: 175.0,
                                width: 150.0,
                              ),
                              Text(
                                "Your Cart is Empty",
                                style: kSmallContentStyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                  border: Border.all(
                                    width: 2.0,
                                    color: Colors.black,
                                  ),
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "My Cart",
                                    style: kSubHeadingStyle,
                                  ),
                                ),
                              ),
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                  border: Border.all(
                                    width: 2.0,
                                    color: Colors.black,
                                  ),
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.add_shopping_cart_outlined,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            children: cartControllerProvider.products
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
            ),
            Positioned(
              bottom: 0,
              child: cartControllerProvider.products.isEmpty
                  ? Container(
                      padding: EdgeInsets.only(
                          bottom: 15, left: 15, right: 15, top: 15),
                      color: Colors.white,
                      width: size.width,
                      child: Container(
                        height: 65,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Start Shopping",
                            style: kSubHeadingStyle.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.only(
                          bottom: 15, left: 15, right: 15, top: 15),
                      color: Colors.white,
                      width: size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
                            child: Text(
                              "Order Info",
                              style: kSubHeadingStyle,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Subtotal",
                                  style: kSmallContentStyle.copyWith(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "Rs. ${cartControllerProvider.totalPrice.toString()}",
                                  style: kSmallContentStyle.copyWith(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Shipping",
                                  style: kSmallContentStyle.copyWith(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "+ Rs. 80",
                                  style: kSmallContentStyle.copyWith(
                                    fontSize: 15,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: kSmallContentStyle.copyWith(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "Rs. ${cartControllerProvider.totalPrice.toString()}",
                                  style: kSmallContentStyle.copyWith(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 65,
                            width: size.width,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                print("product purchased");
                              },
                              child: Text(
                                "Rs. ${cartControllerProvider.totalPrice.toString()}",
                                style: kSubHeadingStyle.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}



                    // Container(
                    //   margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(15),
                    //       color: Colors.white),
                    //   height: 50,
                    //   width: MediaQuery.of(context).size.width,
                    //   child: Center(
                    //     child: Text(
                    //       "Try Adding some Products",
                    //       style: kSmallContentStyle,
                    //     ),
                    //   ),
                    // ),