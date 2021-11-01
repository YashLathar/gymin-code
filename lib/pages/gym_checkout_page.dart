import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/pages/booking_result.dart';
import 'package:gym_in/widgets/reusable_button.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

enum Plans {
  notSelected,
  hourly,
  monthly,
  quarterly,
  halfyealy,
  yearly,
}

final priceselectorProvider = StateProvider<int>((ref) {
  return 397;
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
    final selected = useState(Plans.notSelected);
    final today = DateTime.now();
    Size size = MediaQuery.of(context).size;

    late Razorpay _razorpay;

    void _handlePaymentSuccess(PaymentSuccessResponse response) {
      // succeeds
      showDialog(
        context: context,
        builder: (context) {
          return QrResultScreen(
            dataIndex: 0,
          );
        },
      );
    }

    void _handlePaymentError(PaymentFailureResponse response) {
      // Do something when payment fails
      showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(title: Text("Payment Failed"));
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
    
    },
     );

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
      color: Colors.white,
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xFFf2f2f2),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  "Order Details",
                                  style: kSubHeadingStyle,
                                  //kSmallHeadingTextStyle,
                                ),
                              ),
                            ),
                            SizedBox(width: 50),
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
                                style: kSubHeadingStyle,
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
                                style: kSubHeadingStyle,
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      selected.value = Plans.hourly;
                                      context
                                          .read(priceselectorProvider)
                                          .state = 397;
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
                                                          kSmallHeadingTextStyle,
                                                    ),
                                                    Text(
                                                      "₹" + "397",
                                                      style: kSubHeadingStyle,
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
                                                          kSmallHeadingTextStyle,
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
                                                            onSubmit:
                                                                (Object value) {
                                                              // Navigator.pop(context);
                                                              Navigator
                                                                  .pushReplacementNamed(
                                                                      context,
                                                                      "/timeSelectorPage");
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
                                                  style: kSubHeadingStyle,
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
                                      context
                                          .read(priceselectorProvider)
                                          .state = 697;
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
                                                          kSmallHeadingTextStyle,
                                                    ),
                                                    Text(
                                                      "₹" + "697",
                                                      style: kSubHeadingStyle,
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
                                                          kSmallHeadingTextStyle,
                                                    ),
                                                  ],
                                                ),
                                          selected.value == Plans.monthly
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
                                                  style: kSubHeadingStyle,
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
                                      context
                                          .read(priceselectorProvider)
                                          .state = 997;
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
                                                          kSmallHeadingTextStyle,
                                                    ),
                                                    Text(
                                                      "₹" + "997",
                                                      style: kSubHeadingStyle,
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
                                                          kSmallHeadingTextStyle,
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
                                                  style: kSubHeadingStyle,
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
                                      context
                                          .read(priceselectorProvider)
                                          .state = 1497;
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
                                                          kSmallHeadingTextStyle,
                                                    ),
                                                    Text(
                                                      "₹" + "1497",
                                                      style: kSubHeadingStyle,
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
                                                          kSmallHeadingTextStyle,
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
                                                  style: kSubHeadingStyle,
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
                                      context
                                          .read(priceselectorProvider)
                                          .state = 1997;
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
                                                          kSmallHeadingTextStyle,
                                                    ),
                                                    Text(
                                                      "₹" + "1997",
                                                      style: kSubHeadingStyle,
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
                                                          kSmallHeadingTextStyle,
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
                                                  style: kSubHeadingStyle,
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
                              style: kSubHeadingStyle,
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
                                  "₹ ${context.read(priceselectorProvider).state.toString()}.99",
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
                              final formatprice =
                                  context.read(priceselectorProvider).state *
                                      100;
                              openCheckout(
                                name: gymcheckName,
                                price: formatprice.toString(),
                                description: gymcheckAddress,
                                image: gymcheckPhoto,
                              );
                            },
                            child: Text(
                              "Checkout (₹ ${context.read(priceselectorProvider).state.toString()}.99)",
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
