import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/widgets/toast_msg.dart';
import 'package:like_button/like_button.dart';

class GymListCard extends HookWidget {
  GymListCard({
    Key? key,
    required this.gname,
    required this.gPhoto,
    required this.gratings,
    required this.open,
    required this.gaddress,
  }) : super(key: key);

  final String gname;
  final String gPhoto;
  final bool open;
  final String gratings;
  final String gaddress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   Navigator.pushNamed(
      //     context,
      //     "/gymPage",
      //     // arguments: id,
      //   );
      // },
      child: Container(
        width: 270,
        height: 75,
        margin: EdgeInsets.symmetric(
          horizontal: 10,
        ),
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
                          width: 60,
                          height: 60,
                          color: Colors.white,
                          child: Image.network(
                            gPhoto,
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
                // Positioned(child: Divider())
                // SizedBox(
                //   height: 5,
                // ),
              ],
            ),
            Positioned(
              left: 85,
              // right: 50,
              child: Container(
                margin: EdgeInsets.only(
                  left: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      gname,
                      style: kSmallHeadingTextStyle,
                    ),
                    Text(
                      gaddress,
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            open ? "Open" : "Closed",
                            style: TextStyle(
                              color: open ? Colors.green : Colors.redAccent,
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Color(0xffFFD700),
                                ),
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
                                      gratings.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Divider()
                  ],
                ),
              ),
            ),
            Positioned(
              right: 5,
              //top: 15,
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black.withOpacity(0.4),
                ),
                child: Center(
                  child: LikeButton(
                    onTap: onLikeButtonTapped,
                    size: 25,
                    bubblesSize: 500,
                    animationDuration: Duration(milliseconds: 1500),
                    circleColor: CircleColor(
                      start: Color(0xff00ddff),
                      end: Color(0xff0099cc),
                    ),
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
    );
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    await Future.delayed(Duration(seconds: 1));
    aShowToast(
      msg: "Added to your Favourites",
    );
    return !isLiked;
  }
}
