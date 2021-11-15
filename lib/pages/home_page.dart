import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/pages/citylist_page.dart';
import 'package:gym_in/pages/gym_page.dart';
import 'package:gym_in/pages/gymlist_page.dart';
import 'package:gym_in/widgets/gym_card.dart';
import 'package:gym_in/widgets/toast_msg.dart';

class HomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _gymStream =
        FirebaseFirestore.instance.collection('gymdata').snapshots();
    final ScrollController _scrollController = ScrollController();
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
      stream: _gymStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Container(
              height: 50,
              width: 50,
              child: Center(
                child: Text("Something Went Wrong"),
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Container(
              height: 50,
              width: 50,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 50,
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              leading: GestureDetector(
                child:
                    // Theme.of(context) == AppTheme.darkTheme
                    // ?
                    Image.asset('assets/BurgermenudarkTheme.png'),
                // : Image.asset('assets/Burger-menu.png'),
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    aShowToast(msg: "In App Messaging Coming Soon");
                  },
                  icon: Icon(
                    FontAwesomeIcons.facebookMessenger,
                    color: Colors.redAccent,
                    // Theme.of(context).textTheme.bodyText2!.color,
                    size: 30,
                  ),
                )
              ],
              title: GestureDetector(
                onTap: () {
                  _scrollController.animateTo(
                    0.0,
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: 200),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Center(
                    child: Image.asset(
                      'assets/img/splashlogo.png',
                      height: 90,
                      width: 150,
                    ),
                  ),
                ),
              ),
            ),
            body: ListView(
              controller: _scrollController,
              physics: ClampingScrollPhysics(),
              children: [
                Container(
                  width: size.width,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                        child: CupertinoSearchTextField(
                          backgroundColor: Colors.grey[300],
                          padding: EdgeInsets.all(15),
                        ),
                      ),
                      // Container(
                      //   height: 200,
                      //   child: Image.asset('assets/home-page-heading.png'),
                      // ),
                      // Container(
                      //     padding: EdgeInsets.symmetric(horizontal: 15),
                      //     child:
                      //         CupertinoSearchTextField(padding: EdgeInsets.all(15))
                      //     // FloatingSearchBar(
                      //     //   backdropColor: Colors.grey.withOpacity(0.8),
                      //     //   queryStyle: kSmallContentStyle,
                      //     //   controller: searchBarController,
                      //     //   borderRadius: BorderRadius.circular(10),
                      //     //   automaticallyImplyBackButton: false,
                      //     //   implicitCurve: Curves.bounceOut,
                      //     //   onFocusChanged: (value) {
                      //     //     if (value == true) {
                      //     //       leadingIcon.value = Icons.arrow_back;
                      //     //       actionsIcon.value = Icons.close;
                      //     //       actionsIconColor.value = Colors.black;
                      //     //     } else {
                      //     //       leadingIcon.value = Icons.search;
                      //     //       actionsIconColor.value = Colors.white;
                      //     //     }
                      //     //     return value;
                      //     //   },
                      //     //   leadingActions: [
                      //     //     IconButton(
                      //     //       icon: Icon(leadingIcon.value),
                      //     //       onPressed: () {
                      //     //         searchBarController.close();
                      //     //       },
                      //     //     ),
                      //     //   ],
                      //     //   actions: [
                      //     //     IconButton(
                      //     //       icon: Icon(
                      //     //         actionsIcon.value,
                      //     //         color: actionsIconColor.value,
                      //     //       ),
                      //     //       onPressed: () {
                      //     //         searchBarController.clear();
                      //     //       },
                      //     //     ),
                      //     //   ],
                      //     //   transitionCurve: Curves.easeInOutCubic,
                      //     //   transition: CircularFloatingSearchBarTransition(),
                      //     //   physics: const BouncingScrollPhysics(),
                      //     //   onQueryChanged: (String query) {
                      //     //     final modifiedFirstCharacter =
                      //     //         query.isNotEmpty ? query[0].toUpperCase() : null;
                      //     //     final modifiedQuery = query.isNotEmpty
                      //     //         ? query.replaceFirst(
                      //     //             query[0], modifiedFirstCharacter, 0)
                      //     //         : null;

                      //     //     suggestionList.value = query.isEmpty
                      //     //         ? recentCities
                      //     //         : cities
                      //     //             .where((element) =>
                      //     //                 element.contains(modifiedQuery))
                      //     //             .toList();
                      //     //   },
                      //     //   builder: (context, _) {
                      //     //     return Padding(
                      //     //       padding: const EdgeInsets.only(top: 10),
                      //     //       child: ClipRRect(
                      //     //         borderRadius: BorderRadius.circular(8),
                      //     //         child: Column(
                      //     //           children: List.generate(
                      //     //               suggestionList.value.length, (index) {
                      //     //             return ListTile(
                      //     //               leading: Icon(Icons.restore),
                      //     //               title: Text(suggestionList.value[index]),
                      //     //             );
                      //     //           }).toList(),
                      //     //         ),
                      //     //       ),
                      //     //     );
                      //     //   },
                      //     ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 25, right: 25, top: 10, bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Nearby',
                              style: kSubHeadingStyle.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .color),
                            ),
                            TextButton(
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => GymListPage(),
                                //   ),
                                // );
                              },
                              child: Text(
                                'Available',
                                style: kSmallContentStyle.copyWith(
                                    color: Colors.redAccent),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 350,
                        width: double.infinity,
                        margin: EdgeInsets.only(left: 5),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GymPage(
                                      gymName: data['gname'],
                                      gymPhoto: data['gphoto'],
                                      gymphotos: data['gymphotos'],
                                      gymratings: data['gratings'],
                                      gymopen: data['open'],
                                      gymaddress: data['gaddress'],
                                      trainername: data['gtrainername'],
                                      trainerphoto: data['gtrainerphoto'],
                                      trainerrating: data['gtrainerrating'],
                                      traineravailable:
                                          data['gtraineravailable'],
                                      gymId: document.id,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                child: Container(
                                  child: GymCard(
                                    gymName: data['gname'],
                                    gymPhoto: data['gphoto'],
                                    gymphotos: data['gymphotos'],
                                    gymratings: data['gratings'],
                                    gymopen: data['open'],
                                    gymaddress: data['gaddress'],
                                    trainername: data['gtrainername'],
                                    trainerphoto: data['gtrainerphoto'],
                                    trainerrating: data['gtrainerrating'],
                                    traineravailable: data['gtraineravailable'],
                                    gymId: document.id,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: 15, right: 15, bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Popular Cities',
                              style: kSubHeadingStyle.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .color),
                            ),
                            Text(
                                'Coming Soon',
                                style: kSmallContentStyle.copyWith(
                                    color: Colors.redAccent),
                              ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 30, right: 30),
                        height: 220,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage("https://i.pinimg.com/originals/1e/2b/09/1e2b0958e83b682ee976afb3aeb77c47.jpg"),
                                      backgroundColor: Colors.redAccent,
                                      radius: 40,
                                    ),
                                    Text("Lukhnow"),
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage("https://www.hospitalitynet.org/picture/xxl_153116922.jpg?t=20200803125617"),
                                      backgroundColor: Colors.redAccent,
                                      radius: 40,
                                    ),
                                    Text("Delhi"),
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage("https://spiderimg.amarujala.com/assets/images/2019/10/03/moradabad-railway-station_1570048208.jpeg"),
                                      backgroundColor: Colors.redAccent,
                                      radius: 40,
                                    ),
                                    Text("Ramnagar"),
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage("https://pbs.twimg.com/profile_images/458286447670202368/xcHOodM-.jpeg"),
                                      backgroundColor: Colors.redAccent,
                                      radius: 40,
                                    ),
                                    Text("Kolkata"),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage("https://spiderimg.amarujala.com/assets/images/2019/10/03/moradabad-railway-station_1570048208.jpeg"),
                                      radius: 40,
                                    ),
                                    Text("Chennai"),
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.redAccent,
                                      backgroundImage: NetworkImage("https://pbs.twimg.com/profile_images/458286447670202368/xcHOodM-.jpeg"),
                                      radius: 40,
                                    ),
                                    Text("Noida"),
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage("https://i.pinimg.com/originals/1e/2b/09/1e2b0958e83b682ee976afb3aeb77c47.jpg"),
                                      backgroundColor: Colors.redAccent,
                                      radius: 40,
                                    ),
                                    Text("Almorah"),
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage("https://www.hospitalitynet.org/picture/xxl_153116922.jpg?t=20200803125617"),
                                      backgroundColor: Colors.redAccent,
                                      radius: 40,
                                    ),
                                    Text("Mumbai"),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


// Container(
//                         ////
//                         margin: EdgeInsets.symmetric(horizontal: 15),
//                         height: 400,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 children: [
//                                   Flexible(
//                                     child: GestureDetector(
//                                       onTap: () async {
//                                         await Future.delayed(
//                                             Duration(seconds: 1));
//                                         aShowToast(
//                                           msg: "We're Coming to your City Soon",
//                                         );
//                                       },
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.only(
//                                             topLeft: Radius.circular(24),
//                                             topRight: Radius.circular(24),
//                                             bottomLeft: Radius.circular(24),
//                                             bottomRight: Radius.circular(24),
//                                           ),
//                                           image: DecorationImage(
//                                             image: NetworkImage(
//                                                 'https://spiderimg.amarujala.com/assets/images/2019/10/03/moradabad-railway-station_1570048208.jpeg'),
//                                           ),
//                                         ),
//                                         child: Container(
//                                           alignment: Alignment.topCenter,
//                                           color: Colors.transparent,
//                                           child: Padding(
//                                             padding:
//                                                 const EdgeInsets.only(top: 8),
//                                             child: Text(
//                                               'Moradabad',
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 20.0,
//                                                 color: Colors.white,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Flexible(
//                                     flex: 2,
//                                     child: GestureDetector(
//                                       onTap: () async {
//                                         await Future.delayed(
//                                             Duration(seconds: 1));
//                                         aShowToast(
//                                           msg: "We're Coming to your City Soon",
//                                         );
//                                       },
//                                       child: Container(
//                                         //height: 1200,
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.only(
//                                             topLeft: Radius.circular(24),
//                                             topRight: Radius.circular(24),
//                                             bottomLeft: Radius.circular(24),
//                                             bottomRight: Radius.circular(24),
//                                           ),
//                                           image: DecorationImage(
//                                             image: NetworkImage(
//                                                 'https://pbs.twimg.com/profile_images/458286447670202368/xcHOodM-.jpeg'),
//                                           ),
//                                         ),
//                                         child: Container(
//                                           alignment: Alignment.topCenter,
//                                           color: Colors.transparent,
//                                           child: Padding(
//                                             padding:
//                                                 const EdgeInsets.only(top: 8),
//                                             child: Text(
//                                               'Shahjahanpur',
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 24.0,
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(width: 10),
//                             Expanded(
//                               child: Column(
//                                 children: [
//                                   Flexible(
//                                     flex: 2,
//                                     child: GestureDetector(
//                                       onTap: () async {
//                                         await Future.delayed(
//                                             Duration(seconds: 1));
//                                         aShowToast(
//                                           msg: "We're Coming to your City Soon",
//                                         );
//                                       },
//                                       child: Container(
//                                         height: 1200,
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.only(
//                                             topLeft: Radius.circular(24),
//                                             topRight: Radius.circular(24),
//                                             bottomLeft: Radius.circular(24),
//                                             bottomRight: Radius.circular(24),
//                                           ),
//                                           image: DecorationImage(
//                                             image: NetworkImage(
//                                                 'https://i.pinimg.com/originals/1e/2b/09/1e2b0958e83b682ee976afb3aeb77c47.jpg'),
//                                           ),
//                                         ),
//                                         child: Container(
//                                           alignment: Alignment.topCenter,
//                                           color: Colors.transparent,
//                                           child: Padding(
//                                             padding:
//                                                 const EdgeInsets.only(top: 14),
//                                             child: Text(
//                                               'Rampur',
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 24.0,
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Flexible(
//                                     child: GestureDetector(
//                                       onTap: () async {
//                                         await Future.delayed(
//                                             Duration(seconds: 1));
//                                         aShowToast(
//                                           msg: "We're Coming to your City Soon",
//                                         );
//                                       },
//                                       child: Container(
//                                         height: 1200,
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.only(
//                                             topLeft: Radius.circular(24),
//                                             topRight: Radius.circular(24),
//                                             bottomLeft: Radius.circular(24),
//                                             bottomRight: Radius.circular(24),
//                                           ),
//                                           image: DecorationImage(
//                                             image: NetworkImage(
//                                                 'https://www.hospitalitynet.org/picture/xxl_153116922.jpg?t=20200803125617'),
//                                           ),
//                                         ),
//                                         child: Container(
//                                           alignment: Alignment.topCenter,
//                                           color: Colors.transparent,
//                                           child: Padding(
//                                             padding:
//                                                 const EdgeInsets.only(top: 16),
//                                             child: Text(
//                                               'Lucknow',
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 22.0,
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),