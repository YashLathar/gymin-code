import 'package:flutter/material.dart';
import 'package:gym_in/constants.dart';

class WorkoutSessionCard extends StatelessWidget {
  WorkoutSessionCard({required this.duration, required this.price});

  final String duration;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(),
      constraints: BoxConstraints(minHeight: 100),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 2,
            color: Colors.grey,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  duration,
                  style: kSmallHeadingTextStyle,
                ),
                SizedBox(height: 15),
                Text(
                  "Rs. " + price,
                  style: kSmallContentStyle,
                ),
              ],
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 50,
                width: 130,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Text('Select',
                      style:
                          kSmallHeadingTextStyle.copyWith(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
