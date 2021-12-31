import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/models/product_Order.dart';
import 'package:gym_in/widgets/toast_msg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductOrderWidget extends HookWidget {
  const ProductOrderWidget({
    Key? key,
    required this.productOrder,
  }) : super(key: key);

  final ProductOrder productOrder;

  @override
  Widget build(BuildContext context) {
    final user = useProvider(authControllerProvider);
    return SimpleDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          height: 606,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.all(15),
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    "assets/img/splashlogo.png",
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 15),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 19, bottom: 12),
                        child: Text(
                          "Ordered Products", // $gymName",
                          style:
                              kSmallContentStyle.copyWith(color: Colors.grey),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              width: 50,
                              height: 50,
                              color: Colors.white,
                              child: Image.network(
                                productOrder.productsPhotos[0],
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              ),
                            ),
                          ),
                          // ClipRRect(
                          //   borderRadius: BorderRadius.circular(30),
                          //   child: Container(
                          //     width: 50,
                          //     height: 50,
                          //     color: Colors.redAccent,
                          //   ),
                          // ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            productOrder.productsName[0].length > 15
                                ? productOrder.productsName[0]
                                        .substring(0, 15) +
                                    "..."
                                : productOrder.productsName[0] + " ...",
                            style: kSmallContentStyle,
                          ),
                        ],
                      ),
                    ),
                    productOrder.productsName.length > 2
                        ? Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    color: Colors.white,
                                    child: Image.network(
                                      productOrder.productsPhotos[1],
                                      fit: BoxFit.cover,
                                      filterQuality: FilterQuality.high,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                // ClipRRect(
                                //   borderRadius: BorderRadius.circular(30),
                                //   child: Container(
                                //     width: 50,
                                //     height: 50,
                                //     color: Colors.redAccent,
                                //   ),
                                // ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  productOrder.productsName[1].length > 15
                                      ? productOrder.productsName[1]
                                              .substring(0, 15) +
                                          "..."
                                      : productOrder.productsName[1] + " ...",
                                  style: kSmallContentStyle,
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    productOrder.productsName.length > 3
                        ? Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    color: Colors.white,
                                    child: Image.network(
                                      productOrder.productsPhotos[2],
                                      fit: BoxFit.cover,
                                      filterQuality: FilterQuality.high,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                // ClipRRect(
                                //   borderRadius: BorderRadius.circular(30),
                                //   child: Container(
                                //     width: 50,
                                //     height: 50,
                                //     color: Colors.redAccent,
                                //   ),
                                // ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  productOrder.productsName[2].length > 15
                                      ? productOrder.productsName[2]
                                              .substring(0, 15) +
                                          "..."
                                      : productOrder.productsName[2] + " ...",
                                  style: kSmallContentStyle,
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 19, top: 15, bottom: 12),
                        child: Text(
                          "For:",
                          style:
                              kSmallContentStyle.copyWith(color: Colors.grey),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user!.photoURL!),
                        radius: 25,
                      ),
                      title: Text(
                        user.displayName!,
                        style: kSmallContentStyle.copyWith(
                          color: Theme.of(context).textTheme.bodyText2!.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              DottedLine(
                dashColor: Theme.of(context).textTheme.bodyText2!.color!,
              ),
              Expanded(
                child: SizedBox(),
              ),
              Center(
                child: Text(
                  productOrder.totalPrice.toString(),
                  style: kSmallHeadingTextStyle.copyWith(
                    color: Theme.of(context).textTheme.bodyText2!.color!,
                    fontSize: 45,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 30,
                ),
                child: Center(
                  child: Text(
                    "Total Price",
                    style: kSmallHeadingTextStyle.copyWith(
                      color: Theme.of(context).textTheme.bodyText2!.color!,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      aShowToast(msg: "Saved to Your Orders");
                    },
                    child: Text(
                      "Save Ticket",
                      style: kSubHeadingStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
