import 'package:flutter/material.dart';
import 'package:gym_in/constants.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Text('No messages here yet....', style: kHeadingTextStyle),
        ),
      ),
    );
  }
}
