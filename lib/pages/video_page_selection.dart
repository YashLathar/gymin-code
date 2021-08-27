import 'package:flutter/material.dart';
import 'package:gym_in/constants.dart';

class VideoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Stack(children: [
                Container(
                  height: size.height,
                  child: Image.asset(
                    'assets/video_page_assets/BodyBuilder.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 160,
                  top: 260,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/videoInfoPage",
                          arguments: 0);
                    },
                    child: Image.asset(
                      'assets/video_page_assets/ChestOverlay.png',
                      fit: BoxFit.cover,
                      width: 100,
                      repeat: ImageRepeat.noRepeat,
                    ),
                  ),
                ),
                Positioned(
                  left: 100,
                  top: 270,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/videoInfoPage",
                          arguments: 1);
                    },
                    child: Image.asset(
                      'assets/video_page_assets/BicepsOverlay.png',
                      fit: BoxFit.cover,
                      width: 45,
                      repeat: ImageRepeat.noRepeat,
                    ),
                  ),
                ),
                Positioned(
                  left: 180,
                  top: 320,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/videoInfoPage",
                          arguments: 2);
                    },
                    child: Image.asset(
                      'assets/video_page_assets/AbsOverlay.png',
                      fit: BoxFit.cover,
                      width: 55,
                      repeat: ImageRepeat.noRepeat,
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  bottom: 170,
                  child: RotatedBox(
                    quarterTurns: -1,
                    child: Text(
                      "GymIn",
                      style: kHeadingTextStyle.copyWith(
                          fontSize: 50, color: Colors.white),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
