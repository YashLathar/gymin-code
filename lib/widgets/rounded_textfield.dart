import 'package:flutter/material.dart';
import 'package:gym_in/constants.dart';

class RoundedTextField extends StatelessWidget {
  const RoundedTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.secureIt,
  });

  final TextEditingController controller;
  final String hintText;
  final bool secureIt;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        obscureText: secureIt,
        style: TextStyle(color: Theme.of(context).textTheme.bodyText2!.color),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.arrow_forward,
              color: Theme.of(context).textTheme.bodyText2!.color),
          hintText: hintText,
          hintStyle: kRoundedButtonTextStyle.copyWith(
            fontSize: 15,
            color: Theme.of(context).textTheme.bodyText2!.color,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Theme.of(context).backgroundColor,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.redAccent, //0xffF14C37
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
