import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/dumy-data/gyms_info.dart';
import 'package:gym_in/widgets/horizontal_select_card.dart';
import 'package:gym_in/widgets/reusable_button.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

enum Plans {
  notSelected,
  hourly,
  monthly,
  quarterly,
  halfyealy,
  yearly,
}

class GymCheckoutPage extends HookWidget {
  const GymCheckoutPage({
    Key? key,
    required this.dataIndex,
  }) : super(key: key);

  final dynamic dataIndex;

  @override
  Widget build(BuildContext context) {
    final selected = useState(Plans.notSelected);
    final today = DateTime.now();

    Size size = MediaQuery.of(context).size;
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
                        padding: EdgeInsets.symmetric(horizontal: 20),
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
                                    color: Color(0xFFf2f2f2)),
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
                                  "Order Detail",
                                  style: kSmallHeadingTextStyle,
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
                                  gymsData[dataIndex].gymPhotoUrl[0],
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
                                gymsData[dataIndex].gymName,
                                style: kSubHeadingStyle,
                              ),
                            ),
                            Text(
                              gymsData[dataIndex].address,
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
                            GestureDetector(
                              onTap: () {
                                selected.value = Plans.hourly;
                              },
                              child: ResuableButton(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    selected.value == Plans.hourly
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Hourly",
                                                style: kSmallHeadingTextStyle,
                                              ),
                                              Text(
                                                "₹" + "397",
                                                style: kSubHeadingStyle,
                                              ),
                                            ],
                                          )
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Hourly",
                                                style: kSmallHeadingTextStyle,
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
                                                  builder:
                                                      (BuildContext context) {
                                                    return SfDateRangePicker(
                                                      selectionMode:
                                                          DateRangePickerSelectionMode
                                                              .single,
                                                      backgroundColor:
                                                          Colors.white,
                                                      showActionButtons: true,
                                                      onSubmit: (Object value) {
                                                        // Navigator.pop(context);
                                                        Navigator
                                                            .pushReplacementNamed(
                                                                context,
                                                                "/timeSelectorPage");
                                                      },
                                                      onCancel: () {
                                                        Navigator.pop(context);
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
                                borderColor: selected.value == Plans.hourly
                                    ? Colors.redAccent
                                    : Color(0xffF2F2F2),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                selected.value = Plans.monthly;
                              },
                              child: ResuableButton(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    selected.value == Plans.monthly
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Monthly",
                                                style: kSmallHeadingTextStyle,
                                              ),
                                              Text(
                                                "₹" + "697",
                                                style: kSubHeadingStyle,
                                              ),
                                            ],
                                          )
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Monthly",
                                                style: kSmallHeadingTextStyle,
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
                                                  builder:
                                                      (BuildContext context) {
                                                    return SfDateRangePicker(
                                                      initialSelectedRange:
                                                          PickerDateRange(
                                                        today,
                                                        today.add(
                                                          Duration(days: 30),
                                                        ),
                                                      ),
                                                      selectionMode:
                                                          DateRangePickerSelectionMode
                                                              .range,
                                                      backgroundColor:
                                                          Colors.white,
                                                      showActionButtons: true,
                                                      onSubmit: (Object value) {
                                                        Navigator.pop(context);
                                                      },
                                                      onCancel: () {
                                                        Navigator.pop(context);
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
                                borderColor: selected.value == Plans.monthly
                                    ? Colors.redAccent
                                    : Color(0xffF2F2F2),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                selected.value = Plans.quarterly;
                              },
                              child: ResuableButton(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    selected.value == Plans.quarterly
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Quarterly",
                                                style: kSmallHeadingTextStyle,
                                              ),
                                              Text(
                                                "₹" + "997",
                                                style: kSubHeadingStyle,
                                              ),
                                            ],
                                          )
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Quartely",
                                                style: kSmallHeadingTextStyle,
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
                                                  builder:
                                                      (BuildContext context) {
                                                    return SfDateRangePicker(
                                                      initialSelectedRange:
                                                          PickerDateRange(
                                                        today,
                                                        today.add(
                                                          Duration(days: 30),
                                                        ),
                                                      ),
                                                      selectionMode:
                                                          DateRangePickerSelectionMode
                                                              .single,
                                                      backgroundColor:
                                                          Colors.white,
                                                      showActionButtons: true,
                                                      onSubmit: (Object value) {
                                                        Navigator.pop(context);
                                                      },
                                                      onCancel: () {
                                                        Navigator.pop(context);
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
                                borderColor: selected.value == Plans.quarterly
                                    ? Colors.redAccent
                                    : Color(0xffF2F2F2),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                selected.value = Plans.halfyealy;
                              },
                              child: ResuableButton(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    selected.value == Plans.halfyealy
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Half-Yearly",
                                                style: kSmallHeadingTextStyle,
                                              ),
                                              Text(
                                                "₹" + "1497",
                                                style: kSubHeadingStyle,
                                              ),
                                            ],
                                          )
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Half-Yearly",
                                                style: kSmallHeadingTextStyle,
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
                                                  builder:
                                                      (BuildContext context) {
                                                    return SfDateRangePicker(
                                                      view: DateRangePickerView
                                                          .year,
                                                      initialSelectedRange:
                                                          PickerDateRange(
                                                        today,
                                                        today.add(
                                                          Duration(days: 30),
                                                        ),
                                                      ),
                                                      selectionMode:
                                                          DateRangePickerSelectionMode
                                                              .single,
                                                      backgroundColor:
                                                          Colors.white,
                                                      showActionButtons: true,
                                                      onSubmit: (Object value) {
                                                        Navigator.pop(context);
                                                      },
                                                      onCancel: () {
                                                        Navigator.pop(context);
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
                                borderColor: selected.value == Plans.halfyealy
                                    ? Colors.redAccent
                                    : Color(0xffF2F2F2),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                selected.value = Plans.yearly;
                              },
                              child: ResuableButton(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    selected.value == Plans.yearly
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Yearly",
                                                style: kSmallHeadingTextStyle,
                                              ),
                                              Text(
                                                "₹" + "1997",
                                                style: kSubHeadingStyle,
                                              ),
                                            ],
                                          )
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Yearly",
                                                style: kSmallHeadingTextStyle,
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
                                                  builder:
                                                      (BuildContext context) {
                                                    return SfDateRangePicker(
                                                      view: DateRangePickerView
                                                          .year,
                                                      selectionMode:
                                                          DateRangePickerSelectionMode
                                                              .single,
                                                      backgroundColor:
                                                          Colors.white,
                                                      showActionButtons: true,
                                                      onSubmit: (Object value) {
                                                        Navigator.pop(context);
                                                      },
                                                      onCancel: () {
                                                        Navigator.pop(context);
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
                                borderColor: selected.value == Plans.yearly
                                    ? Colors.redAccent
                                    : Color(0xffF2F2F2),
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
                              "Payment Method",
                              style: kSubHeadingStyle,
                            ),
                            SizedBox(height: 10),
                            HorizontalSelectCard(),
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
                                  "Total",
                                  style: kSmallContentStyle.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "₹ 790.00",
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
                              borderRadius: BorderRadius.circular(20)),
                          child: MaterialButton(
                            onPressed: () {},
                            child: Text(
                              "Checkout (₹ 790.00)",
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
