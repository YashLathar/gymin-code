import 'package:flutter/material.dart';

class FacilityCard extends StatelessWidget {
  const FacilityCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.isfacilityavailable,
    required this.onpressed,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final bool isfacilityavailable;
  final Function onpressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 95,
      height: 95,
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
            size: 30,
            color: isfacilityavailable ? Colors.blue : Color(0xffc9c9c9),
          ),
          SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(
              color: Color(0xffc9c9c9),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
