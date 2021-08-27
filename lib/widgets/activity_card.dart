import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  ActivityCard({required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: (Colors.grey[400])!,
            offset: Offset(
              0,
              10,
            ),
            blurRadius: 10.0,
            spreadRadius: -5.0,
          ), //BoxShadow
        ],
      ),
      child: child,
    );
  }
}
