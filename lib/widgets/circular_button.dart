import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  CircularButton({required this.onPressed, required this.icon});

  final Function() onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: RawMaterialButton(
        onPressed: onPressed,
        child: Icon(icon),
        constraints: BoxConstraints.tightFor(
          width: 40,
          height: 40,
        ),
        shape: CircleBorder(),
        fillColor: Colors.orange,
      ),
    );
  }
}
