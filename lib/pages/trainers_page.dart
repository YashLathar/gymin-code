import 'package:flutter/material.dart';
import 'package:gym_in/constants.dart';

class TrainerZone extends StatefulWidget {
  const TrainerZone({ Key? key }) : super(key: key);

  @override
  _TrainerZoneState createState() => _TrainerZoneState();
}

class _TrainerZoneState extends State<TrainerZone> {
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
                        "Trainer's Zone",
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
                child: Text("trainer's"),
              ),
            )
          ]
        )
      )
    );
  }
}