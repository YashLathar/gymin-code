import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/controllers/cart_controller.dart';
import 'package:gym_in/widgets/cart_product.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ProductCartPage extends HookWidget {
  ProductCartPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartControllerProvider = useProvider(cartProvider);
    // print(cartControllerProvider.products);
    Size size = MediaQuery.of(context).size;

    late Razorpay _razorpay;

    Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
      // succeeds
      showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Text(
                "Order Success",
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText2!.color),
              ),
            );
          });
    }

    void _handlePaymentError(PaymentFailureResponse response) {
      // Do something when payment fails
      showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Text(
                "Order Failed",
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText2!.color),
              ),
            );
          });
    }

    void _handleExternalWallet(ExternalWalletResponse response) {
      // Do something when an external wallet is selected
    }

    useEffect(() {
      _razorpay = Razorpay();
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
      return () {
        _razorpay.clear();
      };
    });

    void openCheckout(
        {String? name,
        String? description,
        String? price,
        String? image}) async {
      var options = {
        'key': 'rzp_test_8NBNETBLt7d5Bg',
        'amount': price,
        'name': name,
        'description': description,
        'image': image,
        'prefill': {'contact': '8979642723', 'email': 'test@pay.com'},
      };
      _razorpay.open(options);
    }

    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Stack(
          children: [
            Container(
              width: size.width,
              child: cartControllerProvider.products.isEmpty
                  ? Column(
                      children: [
                        Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                      width: 2.0,
                                      color: Theme.of(context).backgroundColor),
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .color,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "My Cart",
                                    style: kSubHeadingStyle.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .color,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                        width: 2.0,
                                        color:
                                            Theme.of(context).backgroundColor),
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.add_shopping_cart_outlined,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .color,
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
                              color: Theme.of(context).scaffoldBackgroundColor),
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset(
                                  // "assets/img/empty-cart.gif",
                                  // "assets/img/animation_cart.gif",
                                  "assets/img/animation_1.gif",
                                  // "assets/img/animation_2.gif",
                                  // "assets/img/animation_3.gif",
                                  height: 175.0,
                                  width: 150.0,
                                ),
                              ),
                              Text(
                                "Your Cart is Empty",
                                style: kSmallContentStyle,
                              ),
                              Text(
                                "Try Adding some Products",
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
                          color: Theme.of(context).scaffoldBackgroundColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(35),
                                  border: Border.all(
                                    width: 2.0,
                                    color: Theme.of(context).backgroundColor,
                                  ),
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: Theme.of(context).backgroundColor,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "My Cart",
                                    style: kSubHeadingStyle.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .color),
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
                                    color: Theme.of(context).backgroundColor,
                                  ),
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.add_shopping_cart,
                                      color: Theme.of(context).backgroundColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: size.height / 1.7,
                          child: Expanded(
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
                      color: Theme.of(context).scaffoldBackgroundColor,
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
                      color: Theme.of(context).scaffoldBackgroundColor,
                      height: size.height / 3.5,
                      width: size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
                            child: Text(
                              "Order Info",
                              style: kSubHeadingStyle.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .color),
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
                                  "₹${cartControllerProvider.totalPrice.toString()}",
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
                                Row(
                                  children: [
                                    Text(
                                      "+",
                                      style: kSmallContentStyle.copyWith(
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      "₹80",
                                      style: kSmallContentStyle.copyWith(
                                        fontSize: 15,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
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
                                  "₹${cartControllerProvider.totalPrice.toString()}",
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
                            height: 50,
                            width: size.width,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                if (cartControllerProvider
                                    .products.isNotEmpty) {
                                  final formatprice =
                                      cartControllerProvider.totalPrice * 100;
                                  openCheckout(
                                      name: cartControllerProvider
                                          .products[0].title,
                                      price: formatprice.toString(),
                                      description: cartControllerProvider
                                          .products[0].description,
                                      image: cartControllerProvider
                                          .products[0].image);
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Pay",
                                    style: kSubHeadingStyle.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Text(
                                    "₹${cartControllerProvider.totalPrice.toString()}",
                                    style: kSubHeadingStyle.copyWith(
                                      color: Color(0xFF141221),
                                    ),
                                  ),
                                ],
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