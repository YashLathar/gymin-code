import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostWidget extends HookWidget {
  final String userImage;
  final String userName;
  final String image;

  const PostWidget({
    Key? key,
    required this.userName,
    required this.userImage,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLiked = useState(false);
    final isSaved = useState(false);

    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50.0,
                      height: 50.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60.0),
                        child: Image.network(userImage),
                      ),
                    ),
                    SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '5 min',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Icon(
                  Icons.more_horiz,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          Stack(alignment: Alignment.center, children: [
            GestureDetector(
              onDoubleTap: () {
                isLiked.value = true;
              },
              child: Container(
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    image,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
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
            ),
          ]),
          Container(
            padding: EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            isLiked.value = !isLiked.value;
                          },
                          child: Icon(
                            isLiked.value
                                ? FontAwesomeIcons.solidHeart
                                : FontAwesomeIcons.heart,
                            color:
                                isLiked.value ? Colors.redAccent : Colors.black,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text("2902"),
                      ],
                    ),
                    SizedBox(width: 30),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.commentAlt,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10),
                        Text('376')
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    isSaved.value = !isSaved.value;
                  },
                  child: Icon(
                    isSaved.value ? Icons.bookmark : Icons.bookmark_border,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
