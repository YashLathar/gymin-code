import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_in/constants.dart';
// import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/pages/time_selector_page.dart';
import 'package:gym_in/widgets/reusable_button.dart';
import 'package:gym_in/widgets/toast_msg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

enum Plans {
  hourly,
  monthly,
  quarterly,
  halfyealy,
  yearly,
}

final dateProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

class GymCheckoutPage extends HookWidget {
  final String gymcheckId, gymcheckPhoto, gymcheckName, gymcheckAddress;
  const GymCheckoutPage({
    Key? key,
    required this.gymcheckId,
    required this.gymcheckName,
    required this.gymcheckPhoto,
    required this.gymcheckAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fromTime = useProvider(userSelectedFromTimeProvider).state;
    // final toTime = useProvider(userSelectedToTimeProvider).state;
    final selectedPrice = useProvider(userSelectedPriceProvider);
    // final user = useProvider(authControllerProvider);
    final selected = useState(Plans.hourly);
    final today = DateTime.now();
    Size size = MediaQuery.of(context).size;

    bool isValidDate(DateTime date) {
      final todayDate = DateTime.now();
      if (date.day > todayDate.day) {
        return true;
      } else {
        return false;
      }
    }

    // late Razorpay _razorpay;

    // Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    //   // succeeds

    //   final doc = await context.read(ordersServiceProvider).addToOrders(
    //         gymcheckName,
    //         gymcheckPhoto,
    //         fromTime,
    //         toTime,
    //         selected.value.toString(),
    //         context.read(dateProvider).state.day.toString(),
    //         context,
    //       );

    //   showDialog(
    //     context: context,
    //     builder: (context) {
    //       return QrResultScreen(
    //         gymName: gymcheckName,
    //         gymPhoto: gymcheckPhoto,
    //         userName: user!.displayName,
    //         userImage: user.photoURL,
    //         fromDate: context.read(dateProvider).state.day.toString(),
    //         fromTime: context.read(userSelectedFromTimeProvider).state,
    //         planSelected: selected.value.toString(),
    //         docId: doc.id,
    //       );
    //     },
    //   );
    // }

    // void _handlePaymentError(PaymentFailureResponse response) {
    //   // Do something when payment fails
    //   showDialog(
    //       context: context,
    //       builder: (context) {
    //         return SimpleDialog(
    //             backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    //             title: Text(
    //               "Payment Failed",
    //               style: TextStyle(
    //                   color: Theme.of(context).textTheme.bodyText2!.color),
    //             ));
    //       });
    // }

    // void _handleExternalWallet(ExternalWalletResponse response) {
    //   // Do something when an external wallet is selected
    // }

    // useEffect(() {
    //   _razorpay = Razorpay();
    //   _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    //   _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    //   _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    //   return () {
    //     _razorpay.clear();
    //   };
    // });

    // void openCheckout(
    //     {String? name,
    //     String? description,
    //     String? price,
    //     String? image}) async {
    //   var options = {
    //     'key': 'rzp_test_8NBNETBLt7d5Bg',
    //     'amount': price,
    //     'name': name,
    //     'description': description,
    //     'image': image,
    //     'prefill': {'contact': '8979642723', 'email': 'test@pay.com'},
    //   };
    //   _razorpay.open(options);
    // }

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
                                      selectedPrice.state = 397;
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
                                                      "₹" + "397",
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
                                                                Navigator
                                                                    .pushReplacementNamed(
                                                                        context,
                                                                        "/timeSelectorPage");

                                                                final formattetDate =
                                                                    DateTime.parse(value
                                                                        .value
                                                                        .toString());
                                                                context
                                                                        .read(
                                                                            dateProvider)
                                                                        .state =
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
                                                  "₹" + "397",
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
                                      selectedPrice.state = 697;
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
                                                      "₹" + "697",
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
                                                                    .range,
                                                            backgroundColor:
                                                                Colors.white,
                                                            showActionButtons:
                                                                true,
                                                            onSubmit:
                                                                (Object value) {
                                                              Navigator.pop(
                                                                  context);
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
                                                  "₹" + "697",
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
                                  SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      selected.value = Plans.quarterly;
                                      selectedPrice.state = 997;
                                    },
                                    child: ResuableButton(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          selected.value == Plans.quarterly
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Quarterly",
                                                      style:
                                                          kSmallHeadingTextStyle
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                    ),
                                                    Text(
                                                      "₹" + "997",
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
                                                      "Quartely",
                                                      style:
                                                          kSmallHeadingTextStyle
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                    ),
                                                  ],
                                                ),
                                          selected.value == Plans.quarterly
                                              ? InkWell(
                                                  onTap: () {
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
                                                            onSubmit:
                                                                (Object value) {
                                                              Navigator.pop(
                                                                  context);
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
                                                  "₹" + "997",
                                                  style:
                                                      kSubHeadingStyle.copyWith(
                                                          color: Colors.black),
                                                ),
                                        ],
                                      ),
                                      borderColor:
                                          selected.value == Plans.quarterly
                                              ? Colors.redAccent
                                              : Color(0xffF2F2F2),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      selected.value = Plans.halfyealy;
                                      selectedPrice.state = 1497;
                                    },
                                    child: ResuableButton(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          selected.value == Plans.halfyealy
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Half-Yearly",
                                                      style:
                                                          kSmallHeadingTextStyle
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                    ),
                                                    Text(
                                                      "₹" + "1497",
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
                                                      "Half-Yearly",
                                                      style:
                                                          kSmallHeadingTextStyle
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                    ),
                                                  ],
                                                ),
                                          selected.value == Plans.halfyealy
                                              ? InkWell(
                                                  onTap: () {
                                                    showDialog<Widget>(
                                                        barrierColor:
                                                            Colors.transparent,
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return SfDateRangePicker(
                                                            view:
                                                                DateRangePickerView
                                                                    .year,
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
                                                            onSubmit:
                                                                (Object value) {
                                                              Navigator.pop(
                                                                  context);
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
                                                  "₹" + "1497",
                                                  style:
                                                      kSubHeadingStyle.copyWith(
                                                          color: Colors.black),
                                                ),
                                        ],
                                      ),
                                      borderColor:
                                          selected.value == Plans.halfyealy
                                              ? Colors.redAccent
                                              : Color(0xffF2F2F2),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      selected.value = Plans.yearly;
                                      selectedPrice.state = 1997;
                                    },
                                    child: ResuableButton(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          selected.value == Plans.yearly
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Yearly",
                                                      style:
                                                          kSmallHeadingTextStyle
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                    ),
                                                    Text(
                                                      "₹" + "1997",
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
                                                      "Yearly",
                                                      style:
                                                          kSmallHeadingTextStyle
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                    ),
                                                  ],
                                                ),
                                          selected.value == Plans.yearly
                                              ? InkWell(
                                                  onTap: () {
                                                    showDialog<Widget>(
                                                        barrierColor:
                                                            Colors.transparent,
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return SfDateRangePicker(
                                                            view:
                                                                DateRangePickerView
                                                                    .year,
                                                            selectionMode:
                                                                DateRangePickerSelectionMode
                                                                    .single,
                                                            backgroundColor:
                                                                Colors.white,
                                                            showActionButtons:
                                                                true,
                                                            onSubmit:
                                                                (Object value) {
                                                              Navigator.pop(
                                                                  context);
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
                                                  "₹" + "1997",
                                                  style:
                                                      kSubHeadingStyle.copyWith(
                                                          color: Colors.black),
                                                ),
                                        ],
                                      ),
                                      borderColor:
                                          selected.value == Plans.yearly
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Amount",
                                  style: kSmallContentStyle.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "₹ ${selectedPrice.state.toString()}.99",
                                  style: kSmallHeadingTextStyle,
                                ),
                              ],
                            ),
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
                                    "${context.read(userselectedforhoursProvider).state.toString()}" +
                                        selected.value.toString(),
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
                                  Text(
                                    context
                                        .read(dateProvider)
                                        .state
                                        .day
                                        .toString(),
                                    style: kSmallHeadingTextStyle,
                                  ),
                                ]),
                            selected.value == Plans.hourly
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                        Text(
                                          "Timing",
                                          style: kSmallContentStyle.copyWith(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          fromTime,
                                          style: kSmallHeadingTextStyle,
                                        ),
                                      ])
                                : Container(),
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
                            onPressed: () {
                              // final formatprice = selectedPrice.state * 100;
                              // openCheckout(
                              //   name: gymcheckName,
                              //   price: formatprice.toString(),
                              //   description: gymcheckAddress,
                              //   image: gymcheckPhoto,
                              // );
                            },
                            child: Text(
                              "Checkout (₹ ${selectedPrice.state.toString()}.99)",
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
