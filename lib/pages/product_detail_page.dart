import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/controllers/cart_controller.dart';
import 'package:gym_in/models/product.dart';
import 'package:gym_in/pages/product_cart_page.dart';
import 'package:gym_in/services/cart_service.dart';
import 'package:gym_in/widgets/toast_msg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reviews_slider/reviews_slider.dart';

class ProductDetailPage extends HookWidget {
  final String title, image, productID, description, rating;
  final int price;
  const ProductDetailPage({
    Key? key,
    required this.title,
    required this.image,
    required this.price,
    required this.productID,
    required this.description,
    required this.rating,
  }) : super(key: key);

  Widget build(BuildContext context) {
    final cartService = useProvider(cartServiceProvider);
    final cartControllerProvider = useProvider(cartProvider);
    final isLoading = useState(false);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Container(
                width: size.width,
                height: 1350,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        boxShadow: [
                          BoxShadow(
                            color: (Colors.grey[100])!,
                            offset: Offset(
                              0,
                              10,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: -5.0,
                          ),
                        ],
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                // padding: EdgeInsets.only(top: 3),
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
                              // Container(
                              //   margin: EdgeInsets.only(left: 15),
                              //   child: Center(
                              //     child: Text(
                              //       "Details",
                              //       style: kSubHeadingStyle.copyWith(
                              //           color: Theme.of(context)
                              //               .textTheme
                              //               .bodyText2!
                              //               .color),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          // Container(
                          //   child: IconButton(
                          //     onPressed: () {},
                          //     icon: Icon(
                          //       Icons.more_vert,
                          //       color: Colors.redAccent,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: size.width,
                                // color: Colors.white,
                                child: Hero(
                                  tag: productID,
                                  child: Image.network(
                                    image,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                      width: 2,
                                      color: Theme.of(context).backgroundColor),
                                ),
                                margin: EdgeInsets.only(top: size.width),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 15),
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              title,
                                              style:
                                                  kSmallContentStyle.copyWith(
                                                fontSize: 22,
                                              ),
                                            ),
                                            Container(
                                              width: 45,
                                              height: 38,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    width: 2.0,
                                                    color: Colors.redAccent),
                                              ),
                                              child: Center(
                                                child: IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.favorite,
                                                    color: Theme.of(context)
                                                        .backgroundColor,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 5,
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                              left: 5,
                                              right: 5,
                                              top: 2,
                                              bottom: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                15,
                                              ),
                                              color: Colors.redAccent,
                                            ),
                                            child: Text(rating + "⭐️"),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            child: Text(
                                              "317 ratings",
                                              style:
                                                  kSmallContentStyle.copyWith(
                                                fontSize: 12,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        bottom: 20,
                                      ),
                                      child: Text(
                                        description,
                                      ),
                                    ),
                                    // Divider(
                                    //   thickness: 1.5,
                                    //   color: Theme.of(context).backgroundColor,
                                    // ),
                                    InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                          backgroundColor: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(25),
                                            ),
                                          ),
                                          context: context,
                                          builder: (context) {
                                            return OffersandCoupons();
                                          },
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          border: Border.all(
                                              width: 2,
                                              color: Theme.of(context)
                                                  .backgroundColor),
                                        ),
                                        padding: EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                        ),
                                        height: 50,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Offers and Coupons",
                                              style:
                                                  kSmallContentStyle.copyWith(
                                                color: Colors.redAccent,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Icon(
                                              Icons.expand_more,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .color,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Divider(
                                    //   thickness: 3.0 / 2,
                                    //   color: Theme.of(context).backgroundColor,
                                    // ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                        width: 2,
                                        color:
                                            Theme.of(context).backgroundColor),),
                                      padding: EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        top: 15,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Deliver to",
                                                style:
                                                    kSmallContentStyle.copyWith(
                                                  fontSize: 13,
                                                ),
                                              ),
                                              Text(
                                                "Ram Ganga Vihar - Moradabad",
                                                style:
                                                    kSmallContentStyle.copyWith(
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.car_rental,
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .color,
                                                  ),
                                                  Text(
                                                    "Deliver in 3 Days",
                                                    style: kSmallContentStyle
                                                        .copyWith(
                                                      fontSize: 13,
                                                      color: Colors.redAccent,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              TextButton(
                                                onPressed: () {},
                                                child: Text(
                                                  "Change Address",
                                                  style: kSmallContentStyle
                                                      .copyWith(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    // Divider(
                                    //   thickness: 2.0,
                                    //   color: Theme.of(context).backgroundColor,
                                    // ),
                                    Container(
                                      decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                        width: 2,
                                        color:
                                            Theme.of(context).backgroundColor),),
                                      padding: EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Ratings and Reviews",
                                                style: kSmallContentStyle,
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  showModalBottomSheet(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .vertical(
                                                          top: Radius.circular(
                                                              25),
                                                        ),
                                                      ),
                                                      context: context,
                                                      builder: (context) {
                                                        return ReviewsPSheet();
                                                      });
                                                },
                                                child: Text(
                                                  "Rate Product",
                                                  style: kSmallContentStyle
                                                      .copyWith(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: 100,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            child: Text(
                                              "Loading...",
                                              style:
                                                  kSmallContentStyle.copyWith(
                                                      color: Colors.redAccent),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 25,
                                          )
                                          // ReviewCard(
                                          //   userPhotoUrl:
                                          //       reviewsData[dataIndex].userPhotoUrl[0],
                                          //   userName: reviewsData[dataIndex].userName,
                                          //   index: 0,
                                          //   button: reviewsData[dataIndex].editButton,
                                          //   height: 30,
                                          //   width: 30,
                                          // ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: (Colors.grey[400])!,
                      offset: Offset(
                        0,
                        -10,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: -5.0,
                    ),
                  ],
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: size.width / 1.5,
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2.0,
                          color: Colors.redAccent,
                        ),
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: MaterialButton(
                        onPressed: () async {
                          final product = Product(
                            title: title,
                            price: price,
                            productId: productID,
                            image: image,
                          );
                          final thisProduct = cartControllerProvider.products
                              .where(
                                  (product) => product.productId == productID);

                          if (thisProduct.isEmpty) {
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
                                            borderRadius:
                                                BorderRadius.circular(15),
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

                            await cartService.addItemToCart(product: product);

                            isLoading.value = false;
                            Navigator.pop(context);

                            cartControllerProvider.addProduct(product);

                            Fluttertoast.showToast(
                                msg: "Product has been added to your cart");
                          } else {
                            cartControllerProvider
                                .incrementProductQuantity(productID);
                            Fluttertoast.showToast(
                                msg:
                                    "Quantity of the product has been increased");
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Add to Cart",
                              style: kSmallContentStyle.copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .color,
                              ),
                            ),
                            Text(
                              "₹" + price.toString(),
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 2.0, color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(15)),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductCartPage(),
                              ),
                            );
                          },
                          child: Icon(Icons.shopping_cart,
                              color: Theme.of(context).backgroundColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OffersandCoupons extends StatelessWidget {
  const OffersandCoupons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 30,
      ),
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.drag_handle,
            color: Theme.of(context).textTheme.bodyText2!.color,
          ),
          Text(
            "Offers will be Added Soon",
            style: kSmallContentStyle,
          ),
        ],
      ),
    );
  }
}

class ReviewsPSheet extends StatefulWidget {
  const ReviewsPSheet({Key? key}) : super(key: key);

  @override
  _ReviewsPSheetState createState() => _ReviewsPSheetState();
}

class _ReviewsPSheetState extends State<ReviewsPSheet> {
  bool buttonPressed = false;
  bool buttonnotpressed = false;

  int selectedValue1 = 0;
  int selectedValue2 = 0;
  int selectedValue3 = 0;

  void onChange1(int value) {
    setState(() {
      selectedValue1 = value;
    });
  }

  void onChange2(int value) {
    setState(() {
      selectedValue2 = value;
    });
  }

  void onChange3(int value) {
    setState(() {
      selectedValue3 = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      height: 300,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(6),
            child: Icon(
              Icons.drag_handle,
              color: Theme.of(context).textTheme.bodyText2!.color,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      "Your Private Feedback",
                      style: kSmallContentStyle.copyWith(
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'How would you rate this Product?',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText2!.color,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ReviewSlider(
                    optionStyle: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    onChange: onChange1,
                    initialValue: 4,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      selectedValue1.toString(),
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                  // SizedBox(height: 20),
                  // Text(
                  //   'Your Experience of our Services?',
                  //   style: TextStyle(color: Colors.black, fontSize: 18),
                  // ),
                  // SizedBox(height: 20),
                  // ReviewSlider(
                  //   optionStyle: TextStyle(
                  //     color: Colors.black,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  //   onChange: onChange3,
                  //   initialValue: 3,
                  // ),
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: Text(
                  //     selectedValue3.toString(),
                  //     style: TextStyle(color: Colors.redAccent),
                  //   ),
                  // ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 5.0,
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            buttonnotpressed = true;
                          });
                          await Future.delayed(Duration(seconds: 2));
                          Navigator.pop(context);
                          aShowToast(
                            msg: "Thanks For Your FeedBack",
                          );
                          setState(() {
                            buttonnotpressed = false;
                            buttonPressed = true;
                          });
                        },
                        child: Text(
                          buttonnotpressed ? "Submitting" : "Send Review",
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
