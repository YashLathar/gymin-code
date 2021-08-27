import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserPostWidget extends HookWidget {
  final List<String> images;

  const UserPostWidget({
    required this.images,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final isLiked = useState(false);
    final imageIndex = useState(0);

    return Container(
      width: size.width,
      height: size.height,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              width: size.width / 1.4,
              child: Column(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onDoubleTap: () {
                        isLiked.value = true;
                      },
                      onHorizontalDragEnd: (details) {
                        if (imageIndex.value < images.length - 1) {
                          if (details.primaryVelocity! < 0) {
                            imageIndex.value++;
                          }
                        }
                        if (imageIndex.value > 0) {
                          if (details.primaryVelocity! > 0) {
                            imageIndex.value--;
                          }
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                          images[imageIndex.value],
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: Icon(
                            FontAwesomeIcons.angleLeft,
                            size: 35,
                            color: imageIndex.value == 0
                                ? Colors.grey
                                : Colors.black,
                          ),
                          onTap: () {
                            if (imageIndex.value > 0) {
                              imageIndex.value--;
                            }
                          },
                        ),
                        GestureDetector(
                          child: Icon(
                            FontAwesomeIcons.angleRight,
                            size: 35,
                            color: imageIndex.value == images.length - 1
                                ? Colors.grey
                                : Colors.black,
                          ),
                          onTap: () {
                            if (imageIndex.value < images.length - 1) {
                              imageIndex.value++;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        child: Icon(
                          isLiked.value
                              ? FontAwesomeIcons.solidHeart
                              : FontAwesomeIcons.heart,
                          color:
                              isLiked.value ? Colors.redAccent : Colors.black,
                          size: 30,
                        ),
                        onTap: () {
                          isLiked.value = !isLiked.value;
                        },
                      ),
                      SizedBox(height: 10),
                      Text("2902"),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        child: Icon(
                          FontAwesomeIcons.commentAlt,
                          size: 30,
                        ),
                        onTap: () {},
                      ),
                      SizedBox(height: 10),
                      Text("390"),
                    ],
                  ),
                  GestureDetector(
                    child: Icon(
                      FontAwesomeIcons.share,
                      size: 30,
                    ),
                    onTap: () {},
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
