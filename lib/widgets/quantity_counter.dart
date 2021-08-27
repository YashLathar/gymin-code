import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QuantityCounter extends StatelessWidget {
  const QuantityCounter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffF2F2F2),
            ),
            child: Center(
              child: Icon(
                FontAwesomeIcons.minus,
                size: 15,
              ),
            ),
          ),
          Center(
            child: Text(
              "01",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffF2F2F2),
            ),
            child: Center(
              child: Icon(
                FontAwesomeIcons.plus,
                size: 15,
              ),
            ),
          )
        ],
      ),
    );
  }
}
