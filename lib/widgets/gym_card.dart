import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/widgets/toast_msg.dart';
import 'package:like_button/like_button.dart';
import 'package:flutter/cupertino.dart';

class GymCard extends HookWidget {
  GymCard({
    required this.gname,
    required this.gPhoto,
    required this.gratings,
    required this.open,
    required this.gaddress,
  });

  final String gname;
  final String gPhoto;
  final bool open;
  final String gratings;
  final String gaddress;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    width: 250,
                    height: 190,
                    color: Theme.of(context).scaffoldBackgroundColor,
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
                        onTap: onLikeButtonTapped,
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
                  gname,
                  style: kLoginPageSubHeadingTextStyle.copyWith(
                    color: Theme.of(context).textTheme.bodyText2!.color,
                  ),
                ),
                Text(
                  gaddress,
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
                        open ? "Open" : "Closed",
                        style: TextStyle(
                            color: open ? Colors.green : Colors.redAccent),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: 
                                  Theme.of(context).textTheme.bodyText2!.color,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .color,
                              ),
                              child: Center(
                                child: Text(
                                  gratings.toString(),
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
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

//  gymhomecontainer() {
//   final Stream<QuerySnapshot> _gymStream =
//       FirebaseFirestore.instance.collection('gymdata').snapshots();
//   return StreamBuilder<QuerySnapshot>(
//       stream: _gymStream,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Center(
//               child: Container(
//                 height: 50,
//                 width: 50,
//                 child: Center(
//                   child: Text("Something Went Wrong"),
//                 ),
//               ),
//           );
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//               child: Container(
//                 height: 50,
//                 width: 50,
//                 child: Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               ),
//           );
//         }

//         return Container(
//             padding: EdgeInsets.all(8),
//             child: ListView(
//               children: snapshot.data!.docs.map((DocumentSnapshot document) {
//                 Map<String, dynamic> data =
//                     document.data()! as Map<String, dynamic>;
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => GymPage(
//                           gymName: data['gname'],
//                           gymPhoto: data['gphoto'],
//                           gymratings: data['gratings'],
//                           gymopen: data['open'],
//                           gymaddress: data['gaddress'],
//                           trainername: data['gtrainername'],
//                           trainerphoto: data['gtrainerphoto'],
//                           trainerrating: data['gtrainerrating'],
//                           traineravailable: data['gtraineravailable'],
//                           gymId: document.id,
//                         ),
//                       ),
//                     );
//                   },
//                   child: GymCard(
//                     gname: data['gname'],
//                     gPhoto: data['gphoto'],
//                     gratings: data['gratings'],
//                     open: data['open'],
//                     gaddress: data['gaddress'],
//                   ),
//                 );
//               }).toList(),
//             ),
//         );
//       },
//     );
// }
