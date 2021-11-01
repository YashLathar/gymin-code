import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_in/constants.dart';
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
                onPressed: () {},
              ),
              SizedBox(height: 200),
              Text(
                "To",
                style: kMainHeadingStyle,
              ),
              RoundedButton(
                buttonText: toTime.value.toString(),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
