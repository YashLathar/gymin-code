import 'package:flutter/material.dart';
import 'package:gym_in/constants.dart';

class ShortTextField extends StatelessWidget {
  const ShortTextField({
    Key? key,
    required this.controller,
    required this.hintText,
  });

  final TextEditingController controller;
  final String hintText;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.streetAddress,
        //obscureText: secureIt,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.arrow_forward,
            color: Colors.black,
          ),
          hintText: hintText,
          hintStyle: kRoundedButtonTextStyle.copyWith(
              fontSize: 15, color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
        ),
      ),
    );
  }
}