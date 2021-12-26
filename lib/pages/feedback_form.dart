import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/services/feedback_service.dart';
import 'package:gym_in/widgets/toast_msg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reviews_slider/reviews_slider.dart';

class FeedbackFormPage extends HookWidget {
  const FeedbackFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final feedbackController = useTextEditingController();
    final user = useProvider(authControllerProvider);
    final feedbackService = useProvider(feedbackServiceProvider);
    final selectedValue1 = useState(0);
    final selectedValue2 = useState(0);

    void onChange1(int value) {
      selectedValue1.value = value;
    }

    String convertRatingToResponse(int rating) {
      if (rating == 4) {
        return "Great";
      } else if (rating == 3) {
        return "Good";
      } else if (rating == 2) {
        return "Okay";
      } else if (rating == 1) {
        return "Bad";
      } else {
        return "Terrible";
      }
    }

    void onChange2(int value) {
      selectedValue2.value = value;
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
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
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6.0),
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
                      onChange: onChange2,
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
                      controller: feedbackController,
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
                      final serviceResponse =
                          convertRatingToResponse(selectedValue1.value);
      
                      final productsResponse =
                          convertRatingToResponse(selectedValue2.value);
      
                      if (feedbackController.text.isNotEmpty) {
                        await feedbackService
                            .addFeedbackDocument(
                              serviceResponse,
                              productsResponse,
                              user!.email!,
                              feedbackController.text,
                              user.uid,
                              user.displayName.toString(),
                              user.photoURL.toString(),
                            )
                            .onError((error, stackTrace) => aShowToast(
                                msg: "CANNOT make multiple Feedbacks"));
      
                        feedbackController.clear();
                        aShowToast(msg: "Your feedback has been submmited");
                      } else {
                        aShowToast(msg: "Fields can't be empty");
                      }
                    },
                    child: Text("Submit Your Response"),
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
