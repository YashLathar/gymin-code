import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/widgets/toast_msg.dart';

class ReviewCard extends HookWidget {
  const ReviewCard({
    required this.userName,
    required this.userPhotoUrl,
    required this.index,
    required this.button,
    required this.height,
    required this.width,
  });

  final String userName;
  final String userPhotoUrl;
  final int index;
  final bool button;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: MediaQuery.of(context).size.width,
        //margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: Container(
                                  width: width,
                                  height: height,
                                  color: Colors.white,
                                  child: Image.network(
                                    userPhotoUrl,
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.high,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Text(
                                userName,
                                style: kSmallContentStyle,
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.more_vert,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text("⭐️⭐️⭐️⭐️⭐️", style: kSmallContentStyle),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "21/09/2021",
                            style: kSmallContentStyle.copyWith(fontSize: 14,),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          "I had given this game 5 star before Just because I enjoyed playing it, but I don't think it deserves it anymore Just because of hackers and Bugs..."),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      Container(
                        child: button
                            ? Row(
                                children: [
                                  Text(
                                    "Was this review helpful?",
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      //await Future.delayed(Duration(seconds: 1));
                                      aShowToast(
                                          msg:
                                              "Your Feedback has been recived");
                                    },
                                    child: Text(
                                      "Yes",
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      //await Future.delayed(Duration(seconds: 1));
                                      aShowToast(
                                          msg:
                                              "Your Feedback has been recived");
                                    },
                                    child: Text("No"),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  TextButton.icon(
                                    onPressed: () {},
                                    icon: Icon(Icons.edit),
                                    label: Text("Edit Your Review "),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
