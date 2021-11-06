import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class InfoCircle extends HookWidget {
  InfoCircle({
    required this.child,
    required this.colors,
  });
    final Widget child;
  final List<Color> colors;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        // boxShadow: [
        //   BoxShadow(
        //     color: (Colors.grey[400])!,
        //     offset: Offset(
        //       0,
        //       10,
        //     ),
        //     blurRadius: 10.0,
        //     spreadRadius: -5.0,
        //   ), //BoxShadow
        // ],
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        color: Colors.white,
      ),
      child: child,
    );
  }
}