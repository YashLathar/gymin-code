import 'package:flutter/material.dart';

class FacilityCard extends StatelessWidget {
  const FacilityCard({Key? key, required this.icon, required this.text})
      : super(key: key);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 2.0,
          color: Color(0xffF2F2F2),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 35,
            color: Color(0xffc9c9c9),
          ),
          SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(
              color: Color(0xffc9c9c9),
            ),
          ),
        ],
      ),
    );
  }
}
