import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_in/constants.dart';

class TrainerCard extends HookWidget {
  TrainerCard({
    required this.trainersName,
    required this.trainersPhotoUrl,
    required this.index,
    required this.ratings,
    required this.availability,
    required this.height,
    required this.width,
  });

  final String trainersName;
  final String trainersPhotoUrl;
  final int index;
  final bool availability;
  final int ratings;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
                      width: width,
                      height: height,
                      color: Colors.white,
                      child: Image.network(
                        trainersPhotoUrl,
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
                  Container(
                    margin: EdgeInsets.only(left: 87, top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trainersName,
                          style: kSubHeadingStyle,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                availability ? "Available" : "Not Available",
                                style: TextStyle(
                                    color: availability
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
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
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
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
