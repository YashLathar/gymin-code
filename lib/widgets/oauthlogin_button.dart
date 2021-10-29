import 'package:flutter/material.dart';

class OAuthLoginButton extends StatelessWidget {
  OAuthLoginButton({
    required this.icon,
    required this.onPressed,
  });

  final Widget icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(child: icon),
      ),
      onTap: onPressed,
    );
  }
}
