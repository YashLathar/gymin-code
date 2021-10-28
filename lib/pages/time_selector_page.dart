import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/widgets/rounded_button.dart';

class TimeSelector extends HookWidget {
  const TimeSelector({Key? key}) : super(key: key);

  Future<void> pickToTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    await showTimePicker(
      context: context,
      initialTime: initialTime,
    ).then((value) => print(value));
  }

  Future<void> pickFromTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 8, minute: 0);
    await showTimePicker(
      context: context,
      initialTime: initialTime,
    ).then((value) => print(value!.hour));
  }

  @override
  Widget build(BuildContext context) {
    final fromTime = useState(8);
    final toTime = useState(9);
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
                buttonText: fromTime.value.toString(),
                onPressed: () async {
                  await pickFromTime(context);
                },
              ),
              SizedBox(height: 200),
              Text(
                "To",
                style: kMainHeadingStyle,
              ),
              RoundedButton(
                buttonText: toTime.value.toString(),
                onPressed: () async {
                  await pickToTime(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
