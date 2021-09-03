import 'package:flutter/material.dart';
import 'package:gym_in/constants.dart';

class GymOwnerPage extends StatefulWidget {
  const GymOwnerPage({ Key? key }) : super(key: key);

  @override
  _GymOwnerPageState createState() => _GymOwnerPageState();
}

class _GymOwnerPageState extends State<GymOwnerPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      color: Color(0xffF2F2F2),
      child: Container(
        margin: EdgeInsets.only(top: 50),
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "GymOwner's Zone",
                        style: kSubHeadingStyle,
                      ),
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          
                        }, 
                        icon: Icon(Icons.add))
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Center(
                child: Text("Gym's")
                ),
            ),
          ]
        )
      )
    );
  }
}