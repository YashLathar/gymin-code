import 'package:flutter/material.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/dumy-data/video_info.dart';

class VideoInfoPage extends StatelessWidget {
  final dynamic dataIndex;

  VideoInfoPage({required this.dataIndex});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(videosData[dataIndex].name),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Image.network(
                'https://images.pexels.com/photos/3837788/pexels-photo-3837788.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                videosData[dataIndex].name,
                style: kLoginPageSubHeadingTextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
              child: Text(
                videosData[dataIndex].nameInfo,
                style: kRoundedButtonTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// Container(
//               margin: EdgeInsets.symmetric(vertical: 20),
//               height: 250,
//               child: VideoPlayerWidget(
//                 videoPlayerController: VideoPlayerController.network(
//                   videosData[dataIndex].videoId,
//                 ),
//                 looping: false,
//                 aspectRatio: 16 / 9,
//               ),
//             ),