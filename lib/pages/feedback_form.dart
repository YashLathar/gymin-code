import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_in/constants.dart';
import 'package:reviews_slider/reviews_slider.dart';

class FeedbackFormPage extends StatefulWidget {
  const FeedbackFormPage({Key? key}) : super(key: key);

  @override
  State<FeedbackFormPage> createState() => _FeedbackFormPageState();
}

class _FeedbackFormPageState extends State<FeedbackFormPage> {
  bool buttonPressed = false;
  bool buttonnotpressed = false;
  final responseController = TextEditingController();

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
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        border: Border.all(
                            width: 2.0,
                            color: Theme.of(context).backgroundColor),
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Theme.of(context).textTheme.bodyText2!.color,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Feedback",
                          style: kSubHeadingStyle.copyWith(
                              color:
                                  Theme.of(context).textTheme.bodyText2!.color),
                        ),
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        border: Border.all(
                          width: 2.0,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            FontAwesomeIcons.plus,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(15, 10, 15, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How would you rate Our Services?',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText2!.color,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
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
                    // Align(
                    //   alignment: Alignment.center,
                    //   child: Text(
                    //     selectedValue1.toString(),
                    //     style: TextStyle(color: Colors.redAccent),
                    //   ),
                    // ),
                    SizedBox(height: 20),
                    Text(
                      'Your Experience of our Products?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 20),
                    ReviewSlider(
                      optionStyle: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                      onChange: onChange3,
                      initialValue: 3,
                    ),
                    // Align(
                    //   alignment: Alignment.center,
                    //   child: Text(
                    //     selectedValue3.toString(),
                    //     style: TextStyle(color: Colors.redAccent),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(15, 10, 15, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Response",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: responseController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText2!.color),
                      decoration: InputDecoration(
                        // prefixIcon: Icon(Icons.text_fields,
                        //     color:
                        //         Theme.of(context).textTheme.bodyText2!.color),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Theme.of(context).backgroundColor,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.redAccent,
                            width: 2,
                          ),
                        ),
                        hintText: "Enter your Feedback",
                        hintStyle: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyText2!.color),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 5.0,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                    onPressed: () async {
                      // setState(() {
                      //   buttonnotpressed = true;
                      // });
                      // await Future.delayed(Duration(seconds: 2));
                      // Navigator.pop(context);
                      // aShowToast(
                      //   msg: "Thanks For Your FeedBack",
                      // );
                      // setState(() {
                      //   buttonnotpressed = false;
                      //   buttonPressed = true;
                      // });
                    },
                    child: Text("Submit Your Response"
                        // buttonnotpressed ? "Submitting" : "Send Review",
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
