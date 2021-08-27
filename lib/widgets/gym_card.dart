import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:gym_in/constants.dart';
import 'package:like_button/like_button.dart';

class GymCard extends HookWidget {
  GymCard({
    required this.gymName,
    required this.gymPhotoUrl,
    required this.index,
    required this.ratings,
    required this.isCurrentlyOpen,
    required this.address,
  });

  final String gymName;
  final String gymPhotoUrl;
  final int index;
  final bool isCurrentlyOpen;
  final int ratings;
  final String address;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          "/gymPage",
          arguments: index,
        );
      },
      child: Container(
        width: 270,
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: 270,
                      height: 220,
                      color: Colors.white,
                      child: Image.network(
                        gymPhotoUrl,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    right: 15,
                    top: 15,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white.withOpacity(0.4),
                      ),
                      child: Center(
                        child: LikeButton(
                          size: 25,
                          bubblesSize: 500,
                          animationDuration: Duration(milliseconds: 1500),
                          circleColor: CircleColor(
                              start: Color(0xff00ddff), end: Color(0xff0099cc)),
                          bubblesColor: BubblesColor(
                            dotPrimaryColor: Color(0xff33b5e5),
                            dotSecondaryColor: Color(0xff0099cc),
                          ),
                          likeBuilder: (bool isLiked) {
                            return Icon(
                              Icons.favorite,
                              color: isLiked ? Colors.redAccent : Colors.white,
                              size: 25,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    gymName,
                    style: kLoginPageSubHeadingTextStyle,
                  ),
                  Text(
                    address,
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isCurrentlyOpen ? "Open" : "Closed",
                          style: TextStyle(
                              color: isCurrentlyOpen
                                  ? Colors.green
                                  : Colors.redAccent),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Icon(Icons.star, color: Color(0xffFFD700)),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Color(0xffFFD700),
                                  ),
                                  child: Center(
                                      child: Text(
                                    ratings.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ))),
                            ],
                          ),
                        ),
                      ],
                    ),
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
