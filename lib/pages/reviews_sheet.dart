import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/widgets/toast_msg.dart';
import 'package:reviews_slider/reviews_slider.dart';

class RatingsSheet extends StatefulWidget {
  const RatingsSheet({Key? key}) : super(key: key);

  @override
  _RatingsSheetState createState() => _RatingsSheetState();
}

class _RatingsSheetState extends State<RatingsSheet> {
  bool buttonPressed = false;
  bool buttonnotpressed = false;

  int selectedValue1 = 0;
  int selectedValue2 = 0;
  int selectedValue3 = 0;

  void onChange1(int value) {
    setState(() {
      selectedValue1 = value;
    });
  }

  void onChange2(int value) {
    setState(() {
      selectedValue2 = value;
    });
  }

  void onChange3(int value) {
    setState(() {
      selectedValue3 = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
        height: 475,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.all(6),
              child: Icon(Icons.drag_handle),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text(
                        "Your Private Feedback",
                        style: kSmallHeadingTextStyle.copyWith(
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'How was the service you received?',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    SizedBox(height: 20),
                    ReviewSlider(
                      optionStyle: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                      onChange: onChange1,
                      initialValue: 4,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        selectedValue1.toString(),
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Your Experience of our Services?',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    ReviewSlider(
                      optionStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      onChange: onChange3,
                      initialValue: 3,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        selectedValue3.toString(),
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 5.0,
                        ),
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            setState(() {
                              buttonnotpressed = true;
                            });
                            await Future.delayed(Duration(seconds: 2));
                            Navigator.pop(context);
                            aShowToast(
                              msg: "Thanks For Your FeedBack",
                            );
                            setState(() {
                              buttonnotpressed = false;
                              buttonPressed = true;
                            });
                          },
                          icon: Icon(Icons.check),
                          label: Text(
                            buttonnotpressed ?
                            "Submitting" : "Send Review" ,),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      ],
    );
  }
}
