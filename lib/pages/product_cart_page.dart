import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/controllers/cart_controller.dart';
import 'package:gym_in/services/orders_service.dart';
import 'package:gym_in/widgets/cart_product.dart';
import 'package:gym_in/widgets/product_order_widget.dart';
import 'package:gym_in/widgets/toast_msg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

final validatingPinProvider = StateProvider<bool>((ref) {
  return false;
});

class ProductCartPage extends HookWidget {
  ProductCartPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartControllerProvider = useProvider(cartProvider);
    final pincodeValidator = useProvider(validatingPinProvider);
    final user = useProvider(authControllerProvider);
    final paymentIntentData = useState({});
    final pincodeController = useTextEditingController();
    Size size = MediaQuery.of(context).size;
    final productsPhotos =
        cartControllerProvider.products.map((e) => e.image).toList();
    final productsName =
        cartControllerProvider.products.map((e) => e.title).toList();

    final processingPrice = (cartControllerProvider.totalPrice * 3) / 100;

    final finalPriceAfterProcessing =
        cartControllerProvider.totalPrice + processingPrice;

    Future<void> displayPaymentSheet() async {
      try {
        await Stripe.instance.presentPaymentSheet(
          // ignore: deprecated_member_use
          parameters: PresentPaymentSheetParameters(
            clientSecret: paymentIntentData.value["paymentIntent"],
            confirmPayment: true,
          ),
        );

        paymentIntentData.value = {};

        final doc =
            await context.read(ordersServiceProvider).addToProductOrders(
                  productsName,
                  productsPhotos,
                  finalPriceAfterProcessing.toInt(),
                );

        final productOrder = await context
            .read(ordersServiceProvider)
            .getSingleProductOrder(doc.id);

        showDialog(
          context: context,
          builder: (context) {
            return ProductOrderWidget(
              productOrder: productOrder,
            );
          },
        );
        aShowToast(msg: "Payment Successful");
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  title: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      "Payment Failed",
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText2!.color),
                    ),
                  ));
            });
      }
    }

    Future<void> makePayment() async {
      final formattedPrice = finalPriceAfterProcessing * 100;
      var url = Uri.parse(
          "https://us-central1-gym-in-14938.cloudfunctions.net/stripePayment");
      final response = await http.post(
        url,
        body: jsonEncode({
          "total": formattedPrice,
          "email": user!.email,
        }),
        headers: {"Content-Type": "application/json"},
      );

      paymentIntentData.value = json.decode(response.body);

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData.value["paymentIntent"],
          applePay: true,
          googlePay: true,
          style: ThemeMode.light,
          merchantCountryCode: "IN",
          merchantDisplayName: "Beyonder",
          billingDetails: BillingDetails(
            email: user.email,
          ),
        ),
      );

      displayPaymentSheet();
    }

    return Scaffold(
      body: SafeArea(
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
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
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.add_shopping_cart_outlined,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
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
                                  "assets/img/animation_1.gif",
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        color:
                                            Theme.of(context).backgroundColor,
                                      ),
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
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.add_shopping_cart,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: size.height / 1.7,
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
                      child: ListView(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(12, 0, 0, 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Order Info",
                                  style: kSubHeadingStyle.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .color),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                            isDismissible: true,
                                            backgroundColor: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top: Radius.circular(25)),
                                            ),
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            context: context,
                                            builder:
                                                (BuildContext buildContext) {
                                              return PincodeCheck(
                                                controller: pincodeController,
                                              );
                                            });
                                      },
                                      child: Text(
                                        "Check Pincode",
                                        style: kSmallContentStyle.copyWith(
                                          fontSize: 15,
                                          color: pincodeValidator.state
                                              ? Colors.green
                                              : Colors.redAccent,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
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
                            height: 5,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Processing Fee",
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
                                      "₹ ${processingPrice.toString()}",
                                      style: kSmallContentStyle.copyWith(
                                        fontSize: 15,
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
                                  "₹${finalPriceAfterProcessing.toString()}",
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
                              onPressed: () async {
                                final isEmailVerified = user!.emailVerified;
                                if (pincodeValidator.state) {
                                  if (isEmailVerified) {
                                    await makePayment();
                                  } else {
                                    aShowToast(msg: "Verify Email First");
                                  }
                                } else {
                                  aShowToast(msg: "Unauthenticated Pin Code");
                                }
                                // if (cartControllerProvider
                                //     .products.isNotEmpty) {
                                //   final formatprice =
                                //       cartControllerProvider.totalPrice * 100;
                                //   openCheckout(
                                //       name: cartControllerProvider
                                //           .products[0].title,
                                //       price: formatprice.toString(),
                                //       description: cartControllerProvider
                                //           .products[0].description,
                                //       image: cartControllerProvider
                                //           .products[0].image);
                                // }
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
                                    "₹${finalPriceAfterProcessing.toString()}",
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

class PincodeCheck extends StatelessWidget {
  const PincodeCheck({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    bool validatePincode(String pincode) {
      if (pincode == "244001") {
        aShowToast(msg: "You can proceed to check out");
        return true;
      } else if (pincode == "244002") {
        aShowToast(msg: "You can proceed to check out");
        return true;
      } else if (pincode == "244102") {
        aShowToast(msg: "You can proceed to check out");
        return true;
      } else if (pincode == "244103") {
        aShowToast(msg: "You can proceed to check out");
        return true;
      } else if (pincode == "244104") {
        aShowToast(msg: "You can proceed to check out");
        return true;
      } else if (pincode == "244301") {
        aShowToast(msg: "You can proceed to check out");
        return true;
      } else if (pincode.length > 6) {
        aShowToast(msg: "invalid pin code");
        return false;
      } else if (pincode.length < 6) {
        aShowToast(msg: "invalid pin code");
        return false;
      } else {
        aShowToast(msg: "invalid pin code");
        return false;
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Icon(Icons.drag_handle,
                color: Theme.of(context).backgroundColor),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Check Authenticity',
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText2!.color),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.cancel),
                color: Theme.of(context).textTheme.bodyText2!.color,
                iconSize: 25,
                //label: Text("Cancel")
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: 15.0,
                  ),
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText2!.color),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Theme.of(context).backgroundColor,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.redAccent, //0xffF14C37
                          width: 2,
                        ),
                      ),
                      hintText: "Enter Your Pincode",
                      hintStyle: TextStyle(
                          color: Theme.of(context).textTheme.bodyText2!.color),
                      helperText: 'Pincode',
                      helperStyle: TextStyle(
                          color: Theme.of(context).textTheme.bodyText2!.color),
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                    30, 30, 30, MediaQuery.of(context).viewInsets.bottom),
                child: MaterialButton(
                  color: Colors.redAccent,
                  child: Text(
                    "Check",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText2!.color),
                  ),
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      final validator = validatePincode(controller.text);
                      context.read(validatingPinProvider).state = validator;
                      Navigator.pop(context);
                    }
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
