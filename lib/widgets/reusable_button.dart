import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ResuableButton extends HookWidget {
  const ResuableButton({
    Key? key,
    required this.child,
    required this.borderColor,
  }) : super(key: key);

  final Widget child;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 2,
            color: borderColor,
          ),
          color: Colors.grey[300]),
      child: child,
    );
  }
}
