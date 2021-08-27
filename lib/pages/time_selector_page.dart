import 'package:flutter/material.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/widgets/rounded_button.dart';

class TimeSelector extends StatelessWidget {
  const TimeSelector({Key? key}) : super(key: key);

  Future pickToTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (newTime == null) return;
  }

  Future pickFromTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 8, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (newTime == null) return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "From",
                style: kMainHeadingStyle,
              ),
              RoundedButton(
                buttonText: "Select Time",
                onPressed: () {
                  pickFromTime(context);
                },
              ),
              SizedBox(height: 200),
              Text(
                "To ",
                style: kMainHeadingStyle,
              ),
              RoundedButton(
                buttonText: "Select Time",
                onPressed: () {
                  pickToTime(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
