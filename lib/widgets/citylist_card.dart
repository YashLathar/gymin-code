import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/widgets/toast_msg.dart';

class CityListCard extends HookWidget {
  CityListCard({
    required this.cityName,
    required this.cityPhotoUrl,
    required this.availability,
    required this.index,
    required this.height,
    required this.width,
  });

  final String cityName;
  final String cityPhotoUrl;
  final bool availability;
  final int index;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Future.delayed(Duration(seconds: 1));
        aShowToast(
          msg: availability ? "Bookings available, Go to Gym Page" : "Coming Soon to Your City",
        );
      },
      child: Container(
        width: 270,
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                            cityPhotoUrl,
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
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
            Positioned(
              left: 85,
              child: Container(
                margin: EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cityName,
                      style: kSmallHeadingTextStyle,
                    ),
                    Text(
                      availability ? "Available" : "Coming Soon",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
