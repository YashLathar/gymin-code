import 'package:flutter/material.dart';

class RoundedCard extends StatelessWidget {
  RoundedCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        int sensitivity = 20;
        if (details.delta.dx > sensitivity) {
          Navigator.pushNamed(context, '/bookingPage');
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.8),
          borderRadius: BorderRadius.circular(50),
        ),
        height: 80,
        // width: size.width / 1.1,
        child: child,
      ),
    );
  }
}
