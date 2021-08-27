import 'package:flutter/material.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/dumy-data/posts_info.dart';
import 'package:gym_in/pages/uploadpage.dart';
import 'package:gym_in/widgets/post_widget.dart';


class FeedsPage extends StatefulWidget {

  @override
  _FeedsPageState createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xffF2F2F2),
        title: Row(
          children: [
            Text('Feeds',style: kSmallHeadingTextStyle,
            ),
            SizedBox(width: 270.0,),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UploadPage()));
              }, 
              icon: Icon(Icons.add_a_photo),
              ),
          ],
        ),
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return PostWidget(
              image: postData[index].image,
              userName: postData[index].userName,
              userImage: postData[index].userImage,
            );
          },
          itemCount: postData.length,
        ),
      ),
    );
  }
}
