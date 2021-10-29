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
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Color(0xffF14C37),
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
