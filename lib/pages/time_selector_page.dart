import 'package:flutter/material.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/widgets/reusable_button.dart';
import 'package:gym_in/widgets/rounded_button.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

final userSelectedFromTimeProvider = StateProvider<TimeOfDay>((ref) {
  return TimeOfDay(hour: 8, minute: 0);
});

final userSelectedPriceProvider = StateProvider<int>((ref) {
  return 0;
});

final userSelectedToTimeProvider = StateProvider<String>((ref) {
  return TimeOfDay(hour: 10, minute: 0).hour.toString();
});

final userselectedforhoursProvider = StateProvider<int>((ref) {
  return 1;
});

class TimeSelector extends HookWidget {
  const TimeSelector({
    Key? key,
    required this.price,
    required this.threeHourPrice,
    required this.twoHourPrice,
  }) : super(key: key);

  final int price;
  final int twoHourPrice;
  final int threeHourPrice;

  Future<TimeOfDay> pickFromTime(BuildContext context) async {
    TimeOfDay fromTime = TimeOfDay(hour: 8, minute: 0);
    await showTimePicker(
      context: context,
      initialTime: fromTime,
    ).then((value) {
      if (value != null) {
        fromTime = value;
      }
    });
    return fromTime;
  }

  @override
  Widget build(BuildContext context) {
    final selectedPrice = useProvider(userSelectedPriceProvider);
    final selected = useState(1);
    final fromTime = useState(TimeOfDay(hour: 8, minute: 0));
    final influencedtoHour = fromTime.value.hour + selected.value;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                                  color: Theme.of(context).backgroundColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "Number of hours",
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
                              color: Colors.transparent,
                            ),
                          ),
                          child: Center(
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    width: size.width,
                    child: Column(
                      children: [
                        // Text(
                        //   "Number of hours",
                        //   style: kMainHeadingStyle.copyWith(
                        //       fontSize: 20,
                        //       color: Theme.of(context).textTheme.bodyText2!.color),
                        // ),
                        GestureDetector(
                          onTap: () {
                            selected.value = 1;
                            selectedPrice.state = price;
                            context.read(userselectedforhoursProvider).state =
                                1;
                          },
                          child: ResuableButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "1 Hour",
                                  style: kSmallContentStyle.copyWith(
                                      color: Colors.black),
                                ),
                                Text(
                                  "₹ $price",
                                  style: kSmallContentStyle.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            borderColor: selected.value == 1
                                ? Colors.redAccent
                                : Color(0xffF2F2F2),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            selected.value = 2;
                            selectedPrice.state = price * 2;
                            context.read(userselectedforhoursProvider).state =
                                2;
                          },
                          child: ResuableButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "2 Hour",
                                  style: kSmallContentStyle.copyWith(
                                      color: Colors.black),
                                ),
                                Text(
                                  "₹ $twoHourPrice",
                                  style: kSmallContentStyle.copyWith(
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            borderColor: selected.value == 2
                                ? Colors.redAccent
                                : Color(0xffF2F2F2),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            selected.value = 3;
                            selectedPrice.state = price * 2;
                            context.read(userselectedforhoursProvider).state =
                                3;
                          },
                          child: ResuableButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "3 Hour",
                                  style: kSmallContentStyle.copyWith(
                                      color: Colors.black),
                                ),
                                Text(
                                  "₹ $threeHourPrice",
                                  style: kSmallContentStyle.copyWith(
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            borderColor: selected.value == 3
                                ? Colors.redAccent
                                : Color(0xffF2F2F2),
                          ),
                        ),
                        Text(
                          "From",
                          style: kMainHeadingStyle.copyWith(
                              fontSize: 20,
                              color:
                                  Theme.of(context).textTheme.bodyText2!.color),
                        ),
                        RoundedButton(
                            buttonText: fromTime.value.hour.toString() +
                                " : " +
                                fromTime.value.minute.toString(),
                            onPressed: () async {
                              final selectedFromTime =
                                  await pickFromTime(context);

                              context.read(userSelectedFromTimeProvider).state =
                                  selectedFromTime;

                              fromTime.value = selectedFromTime;
                            }),
                        Text(
                          "To",
                          style: kMainHeadingStyle.copyWith(
                              fontSize: 20,
                              color:
                                  Theme.of(context).textTheme.bodyText2!.color),
                        ),
                        RoundedButton(
                          buttonText: influencedtoHour.toString() +
                              " : " +
                              fromTime.value.minute.toString(),
                          onPressed: () {},
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.redAccent),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Continue",
                          ),
                        ),
                      ],
                    ),
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
