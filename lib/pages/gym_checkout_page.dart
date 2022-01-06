import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:gym_in/constants.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/pages/booking_result.dart';
import 'package:gym_in/pages/time_selector_page.dart';
import 'package:gym_in/services/orders_service.dart';
import 'package:gym_in/widgets/reusable_button.dart';
import 'package:gym_in/widgets/toast_msg.dart';

enum Plans {
  hourly,
  monthly,
  quarterly,
  halfyealy,
  yearly,
}

class GymCheckoutPage extends HookWidget {
  final String gymcheckId, gymcheckPhoto, gymcheckName, gymcheckAddress;
  final int hourlyPrice,
      twoHoursPrice,
      threeHoursPrice,
      monthlyPrice,
      registrationFee;
  const GymCheckoutPage({
    Key? key,
    required this.gymcheckId,
    required this.gymcheckName,
    required this.gymcheckPhoto,
    required this.twoHoursPrice,
    required this.threeHoursPrice,
    required this.gymcheckAddress,
    required this.monthlyPrice,
    required this.hourlyPrice,
    required this.registrationFee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fromTime = useProvider(userSelectedFromTimeProvider).state;
    final toTime = useProvider(userSelectedToTimeProvider).state;
    final selectedPrice = useProvider(userSelectedPriceProvider);
    final user = useProvider(authControllerProvider);
    final selected = useState(Plans.hourly);
    final noOfHours = useProvider(userselectedforhoursProvider);
    final now = DateTime.now();
    final date = useState(DateTime(now.year, now.month, now.day + 1));
    final today = DateTime.now();
    Size size = MediaQuery.of(context).size;
    final orderId = useState({});
    late Razorpay _razorpay;

    final discountedPrice = selectedPrice.state * 20 / 100;

    double priceAfterDiscount() {
      if (selected.value == Plans.monthly) {
        final totalPayable = selectedPrice.state - discountedPrice;
        return totalPayable;
      } else {
        final totalPayable = selectedPrice.state - discountedPrice;
        return totalPayable;
      }
    }

    final afterDiscount = priceAfterDiscount();

    double processingPrice() {
      if (selected.value == Plans.monthly) {
        final processingFee = afterDiscount * 3 / 100;
        return processingFee;
      } else {
        final processingFee = afterDiscount * 3 / 100;
        return processingFee;
      }
    }

    final processingFee = processingPrice();

    final totalPayable = processingFee + afterDiscount;

    bool isValidDate(DateTime date) {
      final todayDate = DateTime.now();

      if (date.isAfter(todayDate)) {
        return true;
      } else {
        return false;
      }
    }

    String formatPlan(Plans plan) {
      if (plan == Plans.monthly) {
        return "Monthly";
      } else {
        return "Hourly";
      }
    }

    final planSelected = formatPlan(selected.value);

    // Future<void> displayPaymentSheet() async {
    //   try {
    //     await Stripe.instance.presentPaymentSheet(
    //       // ignore: deprecated_member_use
    //       parameters: PresentPaymentSheetParameters(
    //         clientSecret: paymentIntentData.value["paymentIntent"],
    //         confirmPayment: true,
    //       ),
    //     );

    //     paymentIntentData.value = {};

    //     final doc = await context.read(ordersServiceProvider).addToGymOrders(
    //           gymcheckName,
    //           gymcheckPhoto,
    //           fromTime.hour.toString() + ":" + fromTime.minute.toString(),
    //           toTime,
    //           planSelected,
    //           date.value.day.toString() +
    //               "-" +
    //               date.value.month.toString() +
    //               "-" +
    //               date.value.year.toString(),
    //           context,
    //         );

    //     showDialog(
    //       context: context,
    //       builder: (context) {
    //         return QrResultScreen(
    //           gymName: gymcheckName,
    //           gymPhoto: gymcheckPhoto,
    //           userName: user!.displayName,
    //           userImage: user.photoURL,
    //           fromDate: date.value.day.toString() +
    //               "-" +
    //               date.value.month.toString() +
    //               "-" +
    //               date.value.year.toString(),
    //           fromTime:
    //               fromTime.hour.toString() + ":" + fromTime.minute.toString(),
    //           planSelected: planSelected,
    //           docId: doc.id,
    //         );
    //       },
    //     );
    //     aShowToast(msg: "Payment Successful");
    //   } catch (e) {
    //     showDialog(
    //         context: context,
    //         builder: (context) {
    //           return SimpleDialog(
    //               backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    //               title: Padding(
    //                 padding: const EdgeInsets.all(15),
    //                 child: Text(
    //                   "Payment Failed",
    //                   style: TextStyle(
    //                       color: Theme.of(context).textTheme.bodyText2!.color),
    //                 ),
    //               ));
    //         });
    //   }
    // }

    Future<void> makePayment() async {
      final price = totalPayable * 100;
      var url = Uri.parse(
          "https://us-central1-gym-in-14938.cloudfunctions.net/razorpayPayment");
      final response = await http.post(
        url,
        body: jsonEncode({
          "amount": price,
        }),
        headers: {"Content-Type": "application/json"},
      );

      final data = jsonDecode(response.body);

      orderId.value = data;

      final options = {
        'key': 'rzp_live_DlYzOC4F8Bq4Q9',
        'amount': price,
        'name': 'GYMIN',
        'order_id': orderId.value["orderId"],
        'description': "test payment",
        "currency": "INR",
        'timeout': 300,
        'prefill': {'email': user!.email}
      };

      _razorpay.open(options);

      // await Stripe.instance.initPaymentSheet(
      //   paymentSheetParameters: SetupPaymentSheetParameters(
      //     paymentIntentClientSecret: paymentIntentData.value["paymentIntent"],
      //     applePay: true,
      //     googlePay: true,
      //     style: ThemeMode.light,
      //     merchantCountryCode: "IN",
      //     merchantDisplayName: "Beyonder",
      //     billingDetails: BillingDetails(
      //       email: user.email,
      //     ),
      //   ),
      // );

      // displayPaymentSheet();
    }

    void _handlePaymentSuccess(PaymentSuccessResponse response) async {
      final doc = await context.read(ordersServiceProvider).addToGymOrders(
            gymcheckName,
            gymcheckPhoto,
            fromTime.hour.toString() + ":" + fromTime.minute.toString(),
            toTime,
            planSelected,
            date.value.day.toString() +
                "/" +
                date.value.month.toString() +
                "/" +
                date.value.year.toString(),
            noOfHours.state.toString() + "hours",
            response.orderId!,
            context,
          );

      showDialog(
        context: context,
        builder: (context) {
          return QrResultScreen(
            gymName: gymcheckName,
            gymPhoto: gymcheckPhoto,
            userName: user!.displayName,
            userImage: user.photoURL,
            fromDate: date.value.day.toString() +
                "-" +
                date.value.month.toString() +
                "-" +
                date.value.year.toString(),
            fromTime:
                fromTime.hour.toString() + ":" + fromTime.minute.toString(),
            planSelected: planSelected,
            docId: doc.id,
          );
        },
      );
      aShowToast(msg: "Payment Successful");
    }

    void _handlePaymentError(PaymentFailureResponse response) {
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

    void _handleExternalWallet(ExternalWalletResponse response) {
      aShowToast(msg: "Payment Successful");
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

    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              ListView(
                physics: ClampingScrollPhysics(),
                children: [
                  Column(
                    children: [
                      Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                                border: Border.all(
                                    width: 2.0,
                                    color: Theme.of(context).backgroundColor),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 6.0),
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
                                  "Order Details",
                                  style: kSubHeadingStyle.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .color),
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
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                              ),
                              child: Center(
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.add_circle,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                width: 270,
                                height: 220,
                                color: Colors.white,
                                child: Image.network(
                                  gymcheckPhoto,
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                gymcheckName,
                                style: kSubHeadingStyle.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .color),
                              ),
                            ),
                            Text(
                              gymcheckAddress,
                              style: kSmallContentStyle.copyWith(
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "Plans",
                                style: kSubHeadingStyle.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .color),
                              ),
                            ),
                            Container(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      selected.value = Plans.hourly;
                                      selectedPrice.state = hourlyPrice;
                                      noOfHours.state = 1;
                                    },
                                    child: ResuableButton(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          selected.value == Plans.hourly
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Hourly",
                                                      style:
                                                          kSmallHeadingTextStyle
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                    ),
                                                    Text(
                                                      "₹" +
                                                          hourlyPrice
                                                              .toString(),
                                                      style: kSubHeadingStyle
                                                          .copyWith(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ],
                                                )
                                              : Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Hourly",
                                                      style:
                                                          kSmallHeadingTextStyle
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                    ),
                                                  ],
                                                ),
                                          selected.value == Plans.hourly
                                              ? InkWell(
                                                  onTap: () {
                                                    showDialog<Widget>(
                                                        barrierColor:
                                                            Colors.transparent,
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return SfDateRangePicker(
                                                            selectionMode:
                                                                DateRangePickerSelectionMode
                                                                    .single,
                                                            backgroundColor:
                                                                Colors.white,
                                                            showActionButtons:
                                                                true,
                                                            onSelectionChanged:
                                                                (DateRangePickerSelectionChangedArgs
                                                                    value) {
                                                              final isVerified =
                                                                  isValidDate(DateTime
                                                                      .parse(value
                                                                          .value
                                                                          .toString()));
                                                              if (isVerified) {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            TimeSelector(
                                                                      price:
                                                                          hourlyPrice,
                                                                      twoHourPrice:
                                                                          twoHoursPrice,
                                                                      threeHourPrice:
                                                                          threeHoursPrice,
                                                                    ),
                                                                  ),
                                                                );

                                                                final formattetDate =
                                                                    DateTime.parse(value
                                                                        .value
                                                                        .toString());
                                                                date.value =
                                                                    formattetDate;
                                                              } else {
                                                                aShowToast(
                                                                    msg:
                                                                        "GYMS CAN NOT BE BOOKED ON PRIOR DATE");
                                                              }
                                                            },
                                                            onCancel: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          );
                                                        });
                                                  },
                                                  child: Icon(
                                                    Icons.calendar_today,
                                                    size: 35,
                                                  ),
                                                )
                                              : Text(
                                                  "₹" + hourlyPrice.toString(),
                                                  style:
                                                      kSubHeadingStyle.copyWith(
                                                          color: Colors.black),
                                                ),
                                        ],
                                      ),
                                      borderColor:
                                          selected.value == Plans.hourly
                                              ? Colors.redAccent
                                              : Color(0xffF2F2F2),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      selected.value = Plans.monthly;
                                      selectedPrice.state = monthlyPrice;
                                    },
                                    child: ResuableButton(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          selected.value == Plans.monthly
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Monthly",
                                                      style:
                                                          kSmallHeadingTextStyle
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                    ),
                                                    Text(
                                                      "₹" +
                                                          monthlyPrice
                                                              .toString(),
                                                      style: kSubHeadingStyle
                                                          .copyWith(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ],
                                                )
                                              : Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Monthly",
                                                      style:
                                                          kSmallHeadingTextStyle
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                    ),
                                                  ],
                                                ),
                                          selected.value == Plans.monthly
                                              ? InkWell(
                                                  onTap: () {
                                                    context
                                                        .read(
                                                            userselectedforhoursProvider)
                                                        .state = 1;

                                                    showDialog<Widget>(
                                                        barrierColor:
                                                            Colors.transparent,
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return SfDateRangePicker(
                                                            initialSelectedRange:
                                                                PickerDateRange(
                                                              today,
                                                              today.add(
                                                                Duration(
                                                                    days: 30),
                                                              ),
                                                            ),
                                                            selectionMode:
                                                                DateRangePickerSelectionMode
                                                                    .single,
                                                            backgroundColor:
                                                                Colors.white,
                                                            showActionButtons:
                                                                true,
                                                            onSelectionChanged:
                                                                (DateRangePickerSelectionChangedArgs
                                                                    value) {
                                                              final isVerified =
                                                                  isValidDate(DateTime
                                                                      .parse(value
                                                                          .value
                                                                          .toString()));
                                                              if (isVerified) {
                                                                final formattetDate =
                                                                    DateTime.parse(value
                                                                        .value
                                                                        .toString());
                                                                date.value =
                                                                    formattetDate;
                                                              } else {
                                                                aShowToast(
                                                                    msg:
                                                                        "GYMS CAN NOT BE BOOKED ON PRIOR DATE");
                                                              }
                                                            },
                                                            onCancel: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            onSubmit: (value) {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          );
                                                        });
                                                  },
                                                  child: Icon(
                                                    Icons.calendar_today,
                                                    size: 35,
                                                  ),
                                                )
                                              : Text(
                                                  "₹" + monthlyPrice.toString(),
                                                  style:
                                                      kSubHeadingStyle.copyWith(
                                                          color: Colors.black),
                                                ),
                                        ],
                                      ),
                                      borderColor:
                                          selected.value == Plans.monthly
                                              ? Colors.redAccent
                                              : Color(0xffF2F2F2),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order Info",
                              style: kSubHeadingStyle.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .color),
                            ),
                            SizedBox(height: 20),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Selected Plan",
                                    style: kSmallContentStyle.copyWith(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    planSelected,
                                    style: kSmallHeadingTextStyle,
                                  ),
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Date",
                                    style: kSmallContentStyle.copyWith(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          date.value.day.toString() + "/",
                                          style: kSmallHeadingTextStyle,
                                        ),
                                        Text(
                                          date.value.month.toString() + "/",
                                          style: kSmallHeadingTextStyle,
                                        ),
                                        Text(
                                          date.value.year.toString(),
                                          style: kSmallHeadingTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                            selected.value == Plans.hourly
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                        Text(
                                          "No. of Hours",
                                          style: kSmallContentStyle.copyWith(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          "${noOfHours.state.toString()} Hour",
                                          style: kSmallHeadingTextStyle,
                                        ),
                                      ])
                                : Container(),

                            selected.value == Plans.hourly
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                        Text(
                                          "Time",
                                          style: kSmallContentStyle.copyWith(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Text(
                                                fromTime.hour.toString() + ":",
                                                style: kSmallHeadingTextStyle,
                                              ),
                                              Text(
                                                fromTime.minute.toString(),
                                                style: kSmallHeadingTextStyle,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ])
                                : Container(),
                            selected.value == Plans.monthly
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Registration",
                                        style: kSmallContentStyle.copyWith(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        "+ ₹ $registrationFee",
                                        style: kSmallHeadingTextStyle.copyWith(
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  selected.value == Plans.monthly
                                      ? "Monthly Fee"
                                      : "Hourly Fee",
                                  style: kSmallContentStyle.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "+ ₹ ${selectedPrice.state}",
                                  style: kSmallHeadingTextStyle,
                                ),
                              ],
                            ),

                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text(
                            //       "Discount(15%)",
                            //       style: kSmallContentStyle.copyWith(
                            //         color: Colors.grey,
                            //       ),
                            //     ),
                            //     Text(
                            //       "₹ 150",
                            //       style: kSmallHeadingTextStyle,
                            //     ),
                            //   ],
                            // ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Discount (20%)",
                                  style: kSmallContentStyle.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "- ₹ ${discountedPrice.toString()}",
                                  style: kSmallHeadingTextStyle,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Processing fees(3%)",
                                  style: kSmallContentStyle.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "+ ₹ ${processingFee.toString()}",
                                  style: kSmallHeadingTextStyle,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Payable",
                                  style: kSmallContentStyle.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "₹ ${totalPayable.toString()}",
                                  style: kSmallHeadingTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            bottom: 25, left: 15, right: 15, top: 20),
                        width: size.width,
                        child: Container(
                          height: 65,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: MaterialButton(
                            onPressed: () async {
                              await user!.reload();
                              final isEmailVerified = user.emailVerified;

                              if (isEmailVerified) {
                                await makePayment();
                              } else {
                                aShowToast(msg: "Verify Email First");
                              }
                            },
                            child: Text(
                              "Checkout (₹ ${totalPayable.toString()})",
                              style: kSmallHeadingTextStyle.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
