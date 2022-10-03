import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/controllers/cart_controller.dart';
import 'package:gym_in/controllers/favourites_controller.dart';
import 'package:gym_in/models/product.dart';
import 'package:gym_in/pages/product_cart_page.dart';
import 'package:gym_in/pages/setting_page.dart';
import 'package:gym_in/pages/user_page.dart';
import 'package:gym_in/services/cart_service.dart';
import 'package:gym_in/services/favourites_service.dart';
import 'package:gym_in/services/user_detail_service.dart';
import 'package:gym_in/widgets/toast_msg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reviews_slider/reviews_slider.dart';

class ProductDetailPage extends HookConsumerWidget {
  final String title,
      image,
      productID,
      description,
      rating,
      specifications,
      discount;
  final int price, finalPrice;
  final bool inStock;
  const ProductDetailPage({
    Key? key,
    required this.title,
    required this.image,
    required this.price,
    required this.productID,
    required this.description,
    required this.rating,
    required this.inStock,
    required this.finalPrice,
    required this.specifications,
    required this.discount,
  }) : super(key: key);

  Widget build(BuildContext context, WidgetRef ref) {
    final cartService = ref.watch(cartServiceProvider);
    final cartControllerProvider = ref.watch(cartProvider);
    final favControllerProvider = ref.watch(favouritesControllerProvider);
    final favProvider = ref.watch(favServiceProvider);
    final isUiLiked = useState(false);
    final isLoading = useState(false);
    final user = ref.watch(authControllerProvider);
    final userInfo = ref.watch(userDetailFutureShowProvider);
    Size size = MediaQuery.of(context).size;
    final authControllerState = ref.watch(authControllerProvider);
    final userDetailProvider = ref.watch(userDetailServiceProvider);
    final addressController = useTextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              physics: ClampingScrollPhysics(),
              children: [
                Container(
                  width: size.width,
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
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: Theme.of(context).backgroundColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(35),
                                        border: Border.all(
                                          width: 2.0,
                                          color:
                                              Theme.of(context).backgroundColor,
                                        ),
                                      ),
                                      child: Center(
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductCartPage(),
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.shopping_cart,
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .color,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          borderRadius:
                                              BorderRadius.circular(35),
                                        ),
                                        child: Center(
                                          child: Text(cartControllerProvider
                                              .products.length
                                              .toString()),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                // Container(
                                //   width: 50,
                                //   height: 50,
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(35),
                                //     border: Border.all(
                                //       width: 2.0,
                                //       color: Theme.of(context).backgroundColor,
                                //     ),
                                //   ),
                                //   child: Center(
                                //     child: IconButton(
                                //       onPressed: () {
                                //         showModalBottomSheet(
                                //             backgroundColor: Theme.of(context)
                                //                 .scaffoldBackgroundColor,
                                //             shape: RoundedRectangleBorder(
                                //               borderRadius:
                                //                   BorderRadius.vertical(
                                //                 top: Radius.circular(25),
                                //               ),
                                //             ),
                                //             context: context,
                                //             builder: (context) {
                                //               return ReviewsPSheet();
                                //             });
                                //       },
                                //       icon: Icon(
                                //         Icons.rate_review,
                                //         color:
                                //             Theme.of(context).backgroundColor,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
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
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                  height: size.width,
                                  child: Hero(
                                    tag: productID,
                                    child: Center(
                                      child: Image.network(
                                        image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  // decoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.circular(25),
                                  //   border: Border.all(
                                  //       width: 1,
                                  //       color: Theme.of(context).backgroundColor),
                                  // ),
                                  margin: EdgeInsets.only(top: size.width),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Divider(
                                        color:
                                            Theme.of(context).backgroundColor,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Text(
                                                title.length > 80
                                                    ? title.substring(0, 80) +
                                                        "..."
                                                    : title + " ...",
                                                style:
                                                    kSmallContentStyle.copyWith(
                                                  fontSize: 22,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                inStock
                                                    ? Container(
                                                        height: 20,
                                                        width: 125,
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                8, 2, 5, 2),
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  15,
                                                                ),
                                                                color: Colors
                                                                    .green),
                                                        child: Text(
                                                          "Available in Stock",
                                                          style:
                                                              kSmallContentStyle
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12),
                                                        ),
                                                      )
                                                    : Container(
                                                        height: 20,
                                                        width: 150,
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                8, 2, 5, 2),
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  15,
                                                                ),
                                                                color: Colors
                                                                    .redAccent),
                                                        child: Text(
                                                          "Currently unavailable",
                                                          style:
                                                              kSmallContentStyle
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12),
                                                        ),
                                                      ),
                                                Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 15,
                                                    vertical: 5,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 5,
                                                          right: 5,
                                                          top: 2,
                                                          bottom: 2,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            15,
                                                          ),
                                                          color:
                                                              Colors.redAccent,
                                                        ),
                                                        child:
                                                            Text(rating + "⭐️"),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          "317 ratings",
                                                          style:
                                                              kSmallContentStyle
                                                                  .copyWith(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                          // vertical: 5,
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              "₹" + price.toString(),
                                              style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 22,
                                                  color: Colors.redAccent,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "₹" + finalPrice.toString(),
                                              style: GoogleFonts.lato(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                textStyle: TextStyle(
                                                  // fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .color,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          bottom: 10,
                                        ),
                                        child: Row(
                                          children: [
                                            Text("Discount"),
                                            SizedBox(width: 8),
                                            Text(discount + "%"),
                                            Icon(
                                              FontAwesomeIcons.tag,
                                              size: 13,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .color,
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
                                      Divider(
                                        thickness: 1,
                                        color:
                                            Theme.of(context).backgroundColor,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                            backgroundColor: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
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
                                          // decoration: BoxDecoration(
                                          //   // borderRadius:
                                          //   //     BorderRadius.circular(25),
                                          //   border: Border.all(
                                          //       width: 2,
                                          //       color: Theme.of(context)
                                          //           .backgroundColor),
                                          //),
                                          padding: EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                          ),
                                          height: 40,
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
                                      Divider(
                                        thickness: 1,
                                        color:
                                            Theme.of(context).backgroundColor,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 15,
                                          bottom: 20,
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Deliver to",
                                                  style: kSmallContentStyle,
                                                ),
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
                                                      "Deliver in 7-10 Days",
                                                      style: kSmallContentStyle
                                                          .copyWith(
                                                        fontSize: 13,
                                                        color: Colors.redAccent,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 20),
                                            // Divider(
                                            //   color: Theme.of(context)
                                            //       .backgroundColor,
                                            // ),
                                            Container(
                                              height: 60,
                                              margin: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  15,
                                                ),
                                                color: Colors.grey[300],
                                              ),
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                            Icons.location_pin),
                                                        userInfo.when(
                                                          data: (data) {
                                                            return Text(
                                                              data.address,
                                                              style:
                                                                  kSmallContentStyle
                                                                      .copyWith(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 17,
                                                              ),
                                                            );
                                                          },
                                                          loading: () =>
                                                              CircularProgressIndicator(),
                                                          error: (e, st) => Text(
                                                              "Not Working"),
                                                        ),
                                                      ],
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary: Colors
                                                                  .redAccent),
                                                      onPressed: () {
                                                        showModalBottomSheet(
                                                            isDismissible: true,
                                                            backgroundColor: Theme
                                                                    .of(context)
                                                                .scaffoldBackgroundColor,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.vertical(
                                                                      top: Radius
                                                                          .circular(
                                                                              25)),
                                                            ),
                                                            clipBehavior: Clip
                                                                .antiAliasWithSaveLayer,
                                                            context: context,
                                                            builder: (BuildContext
                                                                buildContext) {
                                                              return CustomBottomSheet(
                                                                isNumPad: false,
                                                                controller:
                                                                    addressController,
                                                                lable:
                                                                    "Address",
                                                                bottomLable:
                                                                    "Your Address",
                                                                onTap:
                                                                    () async {
                                                                  await userDetailProvider.updateUserAddress(
                                                                      addressController
                                                                          .text,
                                                                      authControllerState!
                                                                          .uid);
                                                                  ref.refresh(
                                                                      userDetailFutureShowProvider.future);
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              );
                                                            });
                                                      },
                                                      child: Text(
                                                        "Change",
                                                        style:
                                                            kSmallContentStyle
                                                                .copyWith(
                                                          fontSize: 15,
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
                                      Divider(
                                        thickness: 1.0,
                                        color:
                                            Theme.of(context).backgroundColor,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: 20,
                                            left: 15,
                                            right: 15,
                                            bottom: 120),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Specifications",
                                                  style: kSmallContentStyle,
                                                ),
                                                Icon(Icons.expand_more,
                                                    color: Theme.of(context)
                                                        .backgroundColor),
                                              ],
                                            ),
                                            SizedBox(height: 20),
                                            Container(child: Text("N/A")),
                                          ],
                                        ),
                                      ),
                                      // Divider(
                                      //   thickness: 1.0,
                                      //   color:
                                      //       Theme.of(context).backgroundColor,
                                      // ),
                                      // Container(
                                      //   padding: EdgeInsets.only(
                                      //       top: 20,
                                      //       left: 15,
                                      //       right: 15,
                                      //       bottom: 120),
                                      //   child: Column(
                                      //     children: [
                                      //       Row(
                                      //         mainAxisAlignment:
                                      //             MainAxisAlignment
                                      //                 .spaceBetween,
                                      //         children: [
                                      //           Text(
                                      //             "How to use",
                                      //             style: kSmallContentStyle,
                                      //           ),
                                      //           Icon(Icons.expand_more,
                                      //               color: Theme.of(context)
                                      //                   .backgroundColor),
                                      //         ],
                                      //       ),
                                      //       SizedBox(height: 20),
                                      //       Container(
                                      //         child: Text("N/A")
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                      // Container(
                                      //   // decoration: BoxDecoration(
                                      //   //   borderRadius: BorderRadius.circular(25),
                                      //   //   border: Border.all(
                                      //   //       width: 2,
                                      //   //       color: Theme.of(context)
                                      //   //           .backgroundColor),
                                      //   // ),
                                      //   padding: EdgeInsets.only(
                                      //       left: 15, right: 15, bottom: 200),
                                      //   child: Column(
                                      //     children: [
                                      //       Row(
                                      //         mainAxisAlignment:
                                      //             MainAxisAlignment
                                      //                 .spaceBetween,
                                      //         children: [
                                      //           Text(
                                      //             "Ratings and Reviews",
                                      //             style: kSmallContentStyle,
                                      //           ),
                                      //           TextButton(
                                      //             onPressed: () {
                                      //               showModalBottomSheet(
                                      //                   shape:
                                      //                       RoundedRectangleBorder(
                                      //                     borderRadius:
                                      //                         BorderRadius
                                      //                             .vertical(
                                      //                       top:
                                      //                           Radius.circular(
                                      //                               25),
                                      //                     ),
                                      //                   ),
                                      //                   context: context,
                                      //                   builder: (context) {
                                      //                     return ReviewsPSheet();
                                      //                   });
                                      //             },
                                      //             child: Text(
                                      //               "Rate Product",
                                      //               style: kSmallContentStyle
                                      //                   .copyWith(
                                      //                 fontSize: 15,
                                      //               ),
                                      //             ),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //       // Container(
                                      //       //   height: 100,
                                      //       //   color: Theme.of(context)
                                      //       //       .scaffoldBackgroundColor,
                                      //       //   child: Text(
                                      //       //     "Loading...",
                                      //       //     style:
                                      //       //         kSmallContentStyle.copyWith(
                                      //       //             color: Colors.redAccent),
                                      //       //   ),
                                      //       // ),
                                      //       // SizedBox(
                                      //       //   height: 25,
                                      //       // ),
                                      //       Container(
                                      //         height: 100,
                                      //         child: Column(
                                      //           crossAxisAlignment:
                                      //               CrossAxisAlignment.start,
                                      //           children: [
                                      //             Row(
                                      //               mainAxisAlignment:
                                      //                   MainAxisAlignment
                                      //                       .spaceBetween,
                                      //               children: [
                                      //                 Row(
                                      //                   children: [
                                      //                     Container(
                                      //                       height: 30,
                                      //                       width: 30,
                                      //                       decoration:
                                      //                           BoxDecoration(
                                      //                         borderRadius:
                                      //                             BorderRadius
                                      //                                 .circular(
                                      //                           15,
                                      //                         ),
                                      //                       ),
                                      //                       child: Icon(Icons
                                      //                           .verified_user),
                                      //                     ),
                                      //                     Text(
                                      //                       "Hemant Gurjar",
                                      //                       style:
                                      //                           kSmallContentStyle
                                      //                               .copyWith(
                                      //                         color: Theme.of(
                                      //                                 context)
                                      //                             .textTheme
                                      //                             .bodyText2!
                                      //                             .color,
                                      //                       ),
                                      //                     ),
                                      //                   ],
                                      //                 ),
                                      //                 IconButton(
                                      //                   onPressed: () {},
                                      //                   icon: Icon(
                                      //                     Icons.edit,
                                      //                     color:
                                      //                         Colors.redAccent,
                                      //                     // color: Theme.of(context).textTheme.bodyText2!.color,
                                      //                   ),
                                      //                 ),
                                      //               ],
                                      //             ),
                                      //             SizedBox(
                                      //               height: 10,
                                      //             ),
                                      //             Container(
                                      //               margin: EdgeInsets.only(
                                      //                   left: 10),
                                      //               child: Row(
                                      //                 mainAxisAlignment:
                                      //                     MainAxisAlignment
                                      //                         .spaceBetween,
                                      //                 children: [
                                      //                   Text(
                                      //                     "The Services are good. Although there's still \nsome room for improvement",
                                      //                     style: TextStyle(
                                      //                         color: Theme.of(
                                      //                                 context)
                                      //                             .textTheme
                                      //                             .bodyText2!
                                      //                             .color),
                                      //                   ),
                                      //                   Container(
                                      //                     child: Row(
                                      //                       children: [
                                      //                         Icon(Icons.star,
                                      //                             color: Color(
                                      //                                 0xffFFD700)),
                                      //                         SizedBox(
                                      //                           width: 5,
                                      //                         ),
                                      //                         Container(
                                      //                           width: 20,
                                      //                           height: 20,
                                      //                           decoration:
                                      //                               BoxDecoration(
                                      //                             borderRadius:
                                      //                                 BorderRadius
                                      //                                     .circular(
                                      //                                         50),
                                      //                             color: Color(
                                      //                                 0xffFFD700),
                                      //                           ),
                                      //                           child: Center(
                                      //                             child: Text(
                                      //                               "4",
                                      //                               // trainerrating
                                      //                               //     .toString(),
                                      //                               style: TextStyle(
                                      //                                   color: Colors
                                      //                                       .white,
                                      //                                   fontSize:
                                      //                                       15),
                                      //                             ),
                                      //                           ),
                                      //                         ),
                                      //                       ],
                                      //                     ),
                                      //                   ),
                                      //                 ],
                                      //               ),
                                      //             ),
                                      //           ],
                                      //         ),
                                      //       ),
                                      //       // ReviewCard(
                                      //       //   userPhotoUrl:
                                      //       //       reviewsData[dataIndex].userPhotoUrl[0],
                                      //       //   userName: reviewsData[dataIndex].userName,
                                      //       //   index: 0,
                                      //       //   button: reviewsData[dataIndex].editButton,
                                      //       //   height: 30,
                                      //       //   width: 30,
                                      //       // ),
                                      //       //     ],
                                      //       //   ),
                                      //       // )
                                      //     ],
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: (Colors.blueGrey[400])!,
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
                            description: description,
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

                            await cartService.addItemToCart(
                                product: product, userUID: user!.uid);

                            isLoading.value = false;
                            Navigator.pop(context);

                            cartControllerProvider.addProduct(product);

                            Fluttertoast.showToast(
                                msg: "Product has been added to your cart");
                          } else {
                            // cartControllerProvider
                            //     .incrementProductQuantity(productID);
                            Fluttertoast.showToast(
                                msg: "Product already exists in cart");
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                            // Text(
                            //   "₹" + price.toString(),
                            //   style: GoogleFonts.lato(
                            //     textStyle: TextStyle(
                            //       fontWeight: FontWeight.w700,
                            //       fontSize: 22,
                            //       color: Colors.black,
                            //     ),
                            //   ),
                            // ),
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
                          onPressed: () async {
                            final thisProduct = favControllerProvider
                                .favProducts
                                .where((product) =>
                                    product.productId == productID);

                            if (thisProduct.isEmpty) {
                              isUiLiked.value = !isUiLiked.value;
                              if (isUiLiked.value) {
                                final product = Product(
                                  description: description,
                                  image: image,
                                  title: title,
                                  price: price,
                                  productId: productID,
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
                          child: Icon(Icons.favorite,
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
  final feedbackController = TextEditingController();

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
      // height: 300,
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
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: Text(
                  //     selectedValue1.toString(),
                  //     style: TextStyle(color: Colors.redAccent),
                  //   ),
                  // ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    child: TextField(
                      controller: feedbackController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText2!.color),
                      decoration: InputDecoration(
                        // prefixIcon: Icon(Icons.text_fields,
                        //     color:
                        //         Theme.of(context).textTheme.bodyText2!.color),
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
                            color: Colors.redAccent,
                            width: 2,
                          ),
                        ),
                        hintText: "Enter your Feedback",
                        hintStyle: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyText2!.color),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 5.0,
                      ),
                      child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(primary: Colors.redAccent),
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
