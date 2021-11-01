import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/widgets/reusable_button.dart';
import 'package:gym_in/widgets/rounded_button.dart';

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
                      "From",
                      style: kMainHeadingStyle.copyWith(fontSize: 20),
                    ),
                    GestureDetector(
                      onTap: () {
                        selected.value = 1;
                      },
                      child: ResuableButton(
                        child: Row(
                          children: [Text("1 Hour")],
                        ),
                        borderColor: selected.value == 1
                            ? Colors.redAccent
                            : Color(0xffF2F2F2),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        selected.value = 2;
                      },
                      child: ResuableButton(
                        child: Row(
                          children: [
                            Text("2 Hour"),
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
                      },
                      child: ResuableButton(
                        child: Row(
                          children: [
                            Text("3 Hour"),
                          ],
                        ),
                        borderColor: selected.value == 3
                            ? Colors.redAccent
                            : Color(0xffF2F2F2),
                      ),
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
                      onPressed: () {},
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
