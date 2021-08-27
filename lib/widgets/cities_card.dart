import 'package:flutter/material.dart';
import 'package:gym_in/constants.dart';

class CitiesCard extends StatelessWidget {
  CitiesCard({
    required this.cityName,
    required this.color,
    required this.cityWidget,
  });

  final String cityName;
  final Widget cityWidget;
  final Color color;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 7.5,
      ),
      constraints: BoxConstraints(
        minWidth: size.width / 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            color,
            Colors.white,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(cityName, style: kSubHeadingStyle.copyWith(color: Colors.white)),
          cityWidget,
        ],
      ),
    );
  }
}
