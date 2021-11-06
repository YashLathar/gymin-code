import 'package:flutter/material.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/widgets/reusable_button.dart';
import 'package:gym_in/widgets/rounded_button.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

final userSelectedFromTimeProvider = StateProvider<String>((ref) {
  return TimeOfDay(hour: 8, minute: 0).toString();
});

final userSelectedToTimeProvider = StateProvider<String>((ref) {
  return TimeOfDay(hour: 10, minute: 0).toString();
});

final userSelectedPriceProvider = StateProvider<int>((ref) {
  return 397;
});

class TimeSelector extends HookWidget {
  const TimeSelector({Key? key}) : super(key: key);

  Future<TimeOfDay> pickFromTime(BuildContext context) async {
    TimeOfDay fromTime = TimeOfDay(hour: 8, minute: 0);
    await showTimePicker(
      context: context,
      initialTime: fromTime,
    ).then((value) => fromTime = value!);

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
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                width: size.width,
                child: Column(
                  children: [
                    Text(
                      "Number of hours",
                      style: kMainHeadingStyle.copyWith(fontSize: 20),
                    ),
                    GestureDetector(
                      onTap: () {
                        selected.value = 1;
                        selectedPrice.state = 397;
                      },
                      child: ResuableButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("1 Hour"),
                            Text("₹ 397"),
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
                        selectedPrice.state = 700;
                      },
                      child: ResuableButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("2 Hour"),
                            Text("₹ 700"),
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
                        selectedPrice.state = 1000;
                      },
                      child: ResuableButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("3 Hour"),
                            Text("₹ 1000"),
                          ],
                        ),
                        borderColor: selected.value == 3
                            ? Colors.redAccent
                            : Color(0xffF2F2F2),
                      ),
                    ),
                    Text(
                      "From",
                      style: kMainHeadingStyle.copyWith(fontSize: 20),
                    ),
                    RoundedButton(
                      buttonText: fromTime.value.hour.toString() +
                          " : " +
                          fromTime.value.minute.toString(),
                      onPressed: () async {
                        await pickFromTime(context).then((value) {
                          fromTime.value = value;
                        });
                      },
                    ),
                    Text(
                      "To",
                      style: kMainHeadingStyle.copyWith(fontSize: 20),
                    ),
                    RoundedButton(
                      buttonText: influencedtoHour.toString() +
                          " : " +
                          fromTime.value.minute.toString(),
                      onPressed: () {},
                    ),
                    TextButton(
                      onPressed: () {
                        context.read(userSelectedFromTimeProvider).state =
                            fromTime.value.hour.toString();

                        context.read(userSelectedToTimeProvider).state =
                            influencedtoHour.toString();

                        Navigator.pop(context);
                      },
                      child: Text(
                        "continue",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
