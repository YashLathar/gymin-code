import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/pages/setting_page.dart';
import 'package:gym_in/widgets/toast_msg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class UserPage extends HookWidget {
  const UserPage({Key? key}) : super(key: key);

  Widget logOutSheet(BuildContext context) {
    return Container(
      height: 170,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(6),
            child: Icon(Icons.drag_handle),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTile(
                    trailing: Icon(
                      Icons.check_circle,
                      color: Colors.redAccent,
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSH2whDJ2XZINbounqZuhGrvEIGpPDnuwmIcQ&usqp=CAU",
                      ),
                      radius: 20,
                    ),
                    title: Text(
                      "Wade Wilson",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Log Out Confirm ?",
                                      style: kSmallContentStyle,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          child: Text("Log Out"),
                                          onPressed: () async {
                                            await Future.delayed(
                                                Duration(seconds: 0));
                                            Navigator.pop(context);
                                            aShowToast(
                                                msg: "Log Out Initiated");
                                            Navigator.pop(context);
                                          },
                                        ),
                                        SimpleDialogOption(
                                          child: Text("Cancel"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            );
                          });
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        child: Icon(
                          Icons.add,
                        ),
                      ),
                      title: Text(
                        "Add Account",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final _tabController = useTabController(initialLength: 2);
    // final authControllerState = useProvider(authControllerProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  // onTap: () {
                  //   showModalBottomSheet(
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.vertical(
                  //         top: Radius.circular(25),
                  //       ),
                  //     ),
                  //     context: context,
                  //     builder: (context) {
                  //       return logOutSheet(context);
                  //     },
                  //   );
                  // },
                  child: Text(
                    'Gymin',
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyText2!.color,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  //   showDialog(
                  //     context: context,
                  //     builder: (context) {
                  //       return SimpleDialog(
                  //         children: [
                  //           Center(
                  //             child: Column(
                  //               children: [
                  //                 Text(
                  //                   "You don't have Gymin Rights",
                  //                   style: kSmallContentStyle.copyWith(
                  //                     fontSize: 14,
                  //                   ),
                  //                 ),
                  //                 SizedBox(
                  //                   height: 15,
                  //                 ),
                  //                 Row(
                  //                   mainAxisAlignment: MainAxisAlignment.center,
                  //                   children: [
                  //                     ElevatedButton(
                  //                       onPressed: () async {
                  //                         await Future.delayed(
                  //                             Duration(seconds: 1));
                  //                         Navigator.pop(context);
                  //                         aShowToast(
                  //                             msg:
                  //                                 "Your Request has been Accepted !");
                  //                       },
                  //                       child: Text(
                  //                         "Request",
                  //                       ),
                  //                     ),
                  //                     SimpleDialogOption(
                  //                       onPressed: () {
                  //                         Navigator.pop(context);
                  //                       },
                  //                       child: Text("Cancel"),
                  //                     )
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ],
                  //       );
                  //     },
                  //   );
                  // },
                  icon: Icon(
                    Icons.check_circle,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                // IconButton(
                //   onPressed: () {
                //     showDialog(
                //       context: context,
                //       builder: (context) {
                //         return SimpleDialog(
                //           title: Text(
                //             "Create a Post",
                //             style: kSmallContentStyle,
                //           ),
                //           children: [
                //             SimpleDialogOption(
                //               child: Text(
                //                 'Photo with Camera',
                //                 style:
                //                     kSmallContentStyle.copyWith(fontSize: 13),
                //               ),
                //               onPressed: () {},
                //             ),
                //             SimpleDialogOption(
                //               child: Text(
                //                 'Image with Gallery',
                //                 style:
                //                     kSmallContentStyle.copyWith(fontSize: 13),
                //               ),
                //               onPressed: () {},
                //             ),
                //             SimpleDialogOption(
                //               child: Text(
                //                 'Cancel',
                //                 style:
                //                     kSmallContentStyle.copyWith(fontSize: 13),
                //               ),
                //               onPressed: () {
                //                 Navigator.pop(context);
                //               },
                //             ),
                //           ],
                //         );
                //       },
                //     );
                //   },
                //   icon: Icon(
                //     Icons.add_box_rounded,
                //     color: Colors.redAccent,
                //   ),
                // ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SettingPage()));
                  },
                  icon: Icon(
                    Icons.settings,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: [
              ProfileHeader1(),
              Divider(
                color: Theme.of(context).scaffoldBackgroundColor,
                thickness: 2.0,
                height: 0.0,
              ),
              // ProfileFooter1(), //or
              ProfileFooter2(),
              // ProfileHeader2(),
              // Divider(
              //   thickness: 3.0,
              //   height: 0.0,
              // ),
              // ProfilePostsView(),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileHeader1 extends HookWidget {
  const ProfileHeader1({Key? key}) : super(key: key);

  Column buildCountColumn(String label, int count, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          count.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: Theme.of(context).textTheme.bodyText2!.color,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 4.0,
            left: 5,
          ),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final authControllerState = useProvider(authControllerProvider);
    final size = MediaQuery.of(context).size;
    Future<void> _launchURLBrowser() async {
      const url = 'https://gymin.co.in';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

//  Future<void> _launchURLApp() async {
//   var url = 'https://gymin.co.in';
//     if (await canLaunch(url)) {
//     await launch(url, forceSafariVC: true, forceWebView: true);
//   } else {
//     throw 'Could not launch $url';
//   }
//   }
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        bottom: 14,
      ),
      decoration: BoxDecoration(
        // color: Theme.of(context).textTheme.bodyText2!.color,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
      ),
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  backgroundImage: NetworkImage(
                    authControllerState!.photoURL ??
                        "https://fanfest.com/wp-content/uploads/2021/02/Loki.jpg",
                  ),
                ),
                SizedBox(
                  width: size.width / 19,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          authControllerState.displayName ?? 'UserName',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_pin,
                              color: Colors.grey,
                              size: 16,
                            ),
                            Text(
                              "Line Par, Moradabad",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.grey),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: size.width / 6.6,
                ),
                PopupMenuButton<int>(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  offset: Offset(50, -100),
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(
                      value: 0,
                      child: PopUpMenuTile(
                        icon: FontAwesomeIcons.firstOrder,
                        title: 'Your Orders',
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 1,
                      child: PopUpMenuTile(
                        icon: Icons.edit,
                        title: 'Edit profile',
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 2,
                      child: PopUpMenuTile(
                        icon: Icons.change_circle,
                        title: 'Change Theme',
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 3,
                      child: PopUpMenuTile(
                        icon: Icons.favorite,
                        title: 'favourites',
                      ),
                    ),
                  ],
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.more_vert,
                        color: Colors.redAccent,
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 12),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 5),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "23 | 5'7\" | 140 lbs",
                        style: kSmallContentStyle.copyWith(
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Flutter developer | Gym Freak",
                        style: kSmallContentStyle.copyWith(
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Whatever_it_takes!!",
                        style: kSmallContentStyle.copyWith(
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      InkWell(
                        highlightColor: Colors.redAccent,
                        onTap:
                            // _launchURLApp,
                            _launchURLBrowser,
                        child: Text(
                          "https://www.gymin.co.in",
                          style: kSmallContentStyle.copyWith(
                            color: Colors.blue,
                            fontSize: 13,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            ButtonTheme(
              height: 35,
              minWidth: 300,
              buttonColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              // ignore: deprecated_member_use
              child: RaisedButton(
                onPressed: () {
                  aShowToast(msg: "Work in Progress");
                },
                child: Text(
                  "Edit Profile",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PopUpMenuTile extends StatelessWidget {
  const PopUpMenuTile({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Theme.of(context).textTheme.bodyText2!.color,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          title,
          style: kSmallContentStyle.copyWith(
            color: Theme.of(context).textTheme.bodyText2!.color,
          ),
        ),
      ],
    );
  }
}

class ProfileFooter1 extends HookWidget {
  const ProfileFooter1({Key? key}) : super(key: key);

  final bool isCompleted = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return isCompleted
        ? Container(
            height: size.height / 1.95,
            width: size.width,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              children: [
                CircularPercentIndicator(
                  radius: 110,
                  lineWidth: 5.0,
                  percent: 0.6,
                  center: Text("60%"),
                  progressColor: Colors.redAccent,
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Text(
                    "Complete Your Profile",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Column(
            children: [
              Container(
                height: size.height / 1.95,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              "Height:",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "Weight:",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "Age:",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "Activity:",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "5'11\"",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "81 Kg\"",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "21\"",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "7.9⭐️",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}

class ProfileFooter2 extends HookWidget {
  const ProfileFooter2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [],
    );
  }
}

// class ProfileHeader2 extends HookWidget {
//   const ProfileHeader2({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       shrinkWrap: true,
//       children: [
//         Container(
//           margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   showDialog(
//                     context: context,
//                     builder: (context) {
//                       return SimpleDialog(
//                         children: [
//                           Column(
//                             children: [
//                               Text(
//                                 "Earn New Badge",
//                                 style: kSmallContentStyle,
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   ElevatedButton(
//                                     child: Text("Earn"),
//                                     onPressed: () async {
//                                       await Future.delayed(
//                                           Duration(seconds: 0));
//                                       Navigator.pop(context);
//                                       aShowToast(msg: "Work in Progress !");
//                                     },
//                                   ),
//                                   SimpleDialogOption(
//                                     child: Text("Cancel"),
//                                     onPressed: () {
//                                       Navigator.pop(context);
//                                     },
//                                   )
//                                 ],
//                               )
//                             ],
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 },
//                 child: CircleAvatar(
//                   radius: 30,
//                   child: Icon(
//                     Icons.add,
//                   ),
//                   backgroundColor: Colors.redAccent,
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {},
//                 child: CircleAvatar(
//                   radius: 30,
//                   backgroundImage: NetworkImage(
//                     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvL5s8yPVen34OJG08FHgZPrSIDBWyrheg3Q&usqp=CAU",
//                   ),
//                 ),
//               ),
//               CircleAvatar(
//                 radius: 30,
//                 backgroundImage: NetworkImage(
//                   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSH2whDJ2XZINbounqZuhGrvEIGpPDnuwmIcQ&usqp=CAU",
//                 ),
//               ),
//               CircleAvatar(
//                 radius: 30,
//                 backgroundImage: NetworkImage(
//                   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEkhRG2Ms5RS6xQoQhRsdJnAIsU5TSARY_fg&usqp=CAU",
//                 ),
//               ),
//               CircleAvatar(
//                 radius: 30,
//                 backgroundImage: NetworkImage(
//                   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSI8CvywojT7GQZsNDU-U54aZhFGb1SvZnD1Q&usqp=CAU",
//                 ),
//               ),
//               CircleAvatar(
//                 radius: 30,
//                 backgroundImage: NetworkImage(
//                   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8PcN8hh6ZroeG92qoCAJXK76EjMYZQ0bvJg&usqp=CAU",
//                 ),
//               ),
//               // CircleAvatar(
//               //   radius: 30,
//               //   backgroundColor: Colors.green,
//               // ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class ProfilePostsView extends HookWidget {
//   const ProfilePostsView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     // Size size = MediaQuery.of(context).size;
//     return Container(
//       margin: EdgeInsets.fromLTRB(15, 15, 10, 15),
//       // height: 200,
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(24),
//                         topRight: Radius.circular(24),
//                         bottomLeft: Radius.circular(24),
//                         bottomRight: Radius.circular(24),
//                       ),
//                       image: DecorationImage(
//                         image: NetworkImage(
//                           "https://m.media-amazon.com/images/I/91I48aFAZDL._AC_SL1500_.jpg",
//                         ),
//                       ),
//                     ),
//                     height: 280,
//                     width: 195,
//                     // color: Colors.redAccent,
//                     child: Center(
//                       child: Text(
//                         "data",
//                         style: TextStyle(
//                           color: Colors.transparent,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Column(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(24),
//                         topRight: Radius.circular(24),
//                         bottomLeft: Radius.circular(24),
//                         bottomRight: Radius.circular(24),
//                       ),
//                       image: DecorationImage(
//                         image: NetworkImage(
//                           "https://cdn.vox-cdn.com/thumbor/8ye9Zy39nTLGx51sDcGrHreR4yw=/265x0:1878x1075/1200x800/filters:focal(265x0:1878x1075)/cdn.vox-cdn.com/uploads/chorus_image/image/49183577/deadpool-fox-marvel_03.0.0.jpg",
//                         ),
//                       ),
//                     ),
//                     height: 128,
//                     width: 180,
//                     child: Center(
//                       child: Text(
//                         "data",
//                         style: TextStyle(
//                           color: Colors.transparent,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(28),
//                         topRight: Radius.circular(28),
//                         bottomLeft: Radius.circular(28),
//                         bottomRight: Radius.circular(28),
//                       ),
//                       image: DecorationImage(
//                         image: NetworkImage(
//                           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqt8A5IlFetK5N6sbot3_13cI9k_jcXnj9VQ&usqp=CAU",
//                         ),
//                       ),
//                     ),
//                     height: 128,
//                     width: 180,
//                     // color: Colors.redAccent,
//                     child: Center(
//                       child: Text(
//                         "data",
//                         style: TextStyle(
//                           color: Colors.transparent,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(24),
//                         topRight: Radius.circular(24),
//                         bottomLeft: Radius.circular(24),
//                         bottomRight: Radius.circular(24),
//                       ),
//                       image: DecorationImage(
//                         image: NetworkImage(
//                           "https://cdn.vox-cdn.com/thumbor/8ye9Zy39nTLGx51sDcGrHreR4yw=/265x0:1878x1075/1200x800/filters:focal(265x0:1878x1075)/cdn.vox-cdn.com/uploads/chorus_image/image/49183577/deadpool-fox-marvel_03.0.0.jpg",
//                         ),
//                       ),
//                     ),
//                     height: 128,
//                     width: 180,
//                     child: Center(
//                       child: Text(
//                         "data",
//                         style: TextStyle(
//                           color: Colors.transparent,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(28),
//                         topRight: Radius.circular(28),
//                         bottomLeft: Radius.circular(28),
//                         bottomRight: Radius.circular(28),
//                       ),
//                       image: DecorationImage(
//                         image: NetworkImage(
//                           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqt8A5IlFetK5N6sbot3_13cI9k_jcXnj9VQ&usqp=CAU",
//                         ),
//                       ),
//                     ),
//                     height: 128,
//                     width: 180,
//                     // color: Colors.redAccent,
//                     child: Center(
//                       child: Text(
//                         "data",
//                         style: TextStyle(
//                           color: Colors.transparent,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Column(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(24),
//                         topRight: Radius.circular(24),
//                         bottomLeft: Radius.circular(24),
//                         bottomRight: Radius.circular(24),
//                       ),
//                       image: DecorationImage(
//                         image: NetworkImage(
//                           "https://m.media-amazon.com/images/I/91I48aFAZDL._AC_SL1500_.jpg",
//                         ),
//                       ),
//                     ),
//                     height: 280,
//                     width: 195,
//                     // color: Colors.redAccent,
//                     child: Center(
//                       child: Text(
//                         "data",
//                         style: TextStyle(
//                           color: Colors.transparent,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(24),
//                         topRight: Radius.circular(24),
//                         bottomLeft: Radius.circular(24),
//                         bottomRight: Radius.circular(24),
//                       ),
//                       image: DecorationImage(
//                         image: NetworkImage(
//                           "https://m.media-amazon.com/images/I/91I48aFAZDL._AC_SL1500_.jpg",
//                         ),
//                       ),
//                     ),
//                     height: 280,
//                     width: 195,
//                     // color: Colors.redAccent,
//                     child: Center(
//                       child: Text(
//                         "data",
//                         style: TextStyle(
//                           color: Colors.transparent,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Column(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(24),
//                         topRight: Radius.circular(24),
//                         bottomLeft: Radius.circular(24),
//                         bottomRight: Radius.circular(24),
//                       ),
//                       image: DecorationImage(
//                         image: NetworkImage(
//                           "https://cdn.vox-cdn.com/thumbor/8ye9Zy39nTLGx51sDcGrHreR4yw=/265x0:1878x1075/1200x800/filters:focal(265x0:1878x1075)/cdn.vox-cdn.com/uploads/chorus_image/image/49183577/deadpool-fox-marvel_03.0.0.jpg",
//                         ),
//                       ),
//                     ),
//                     height: 128,
//                     width: 180,
//                     child: Center(
//                       child: Text(
//                         "data",
//                         style: TextStyle(
//                           color: Colors.transparent,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(28),
//                         topRight: Radius.circular(28),
//                         bottomLeft: Radius.circular(28),
//                         bottomRight: Radius.circular(28),
//                       ),
//                       image: DecorationImage(
//                         image: NetworkImage(
//                           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqt8A5IlFetK5N6sbot3_13cI9k_jcXnj9VQ&usqp=CAU",
//                         ),
//                       ),
//                     ),
//                     height: 128,
//                     width: 180,
//                     // color: Colors.redAccent,
//                     child: Center(
//                       child: Text(
//                         "data",
//                         style: TextStyle(
//                           color: Colors.transparent,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
