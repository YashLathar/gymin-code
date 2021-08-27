import 'package:flutter/material.dart';

class OAuthLoginButton extends StatelessWidget {
  OAuthLoginButton(
      {required this.icon, required this.onPressed, required this.color});

  final Widget icon;
  final Function() onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      width: 320,
      height: 38,
      child: MaterialButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        color: color,
        child: icon,
        onPressed: onPressed,
      ),
    );
  }
}
