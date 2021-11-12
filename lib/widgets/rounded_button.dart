import 'package:flutter/material.dart';
import 'package:gym_in/constants.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({required this.buttonText, required this.onPressed});

  final String buttonText;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      width: size.width / 2.5,
      height: 45,
      child: MaterialButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        color: Colors.grey[300],
        child: Text(
          buttonText,
          style: kRoundedButtonTextStyle,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
