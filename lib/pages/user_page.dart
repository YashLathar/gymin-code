import 'dart:async';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/models/user.dart';
import 'package:gym_in/pages/editprofile_page.dart';
import 'package:gym_in/pages/setting_page.dart';
import 'package:gym_in/services/user_detail_service.dart';
import 'package:gym_in/widgets/toast_msg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

final userDetailFutureShowProvider =
    FutureProvider.autoDispose<UserInApp>((ref) async {
  ref.maintainState = false;
  final userFromFirebaseAuth = ref.read(authControllerProvider);

  final user = ref
      .read(userDetailServiceProvider)
      .getYourInfo(userFromFirebaseAuth!.uid);
  return user;
});

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
                    showModalBottomSheet(
                        isDismissible: true,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(25)),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        context: context,
                        builder: (BuildContext buildContext) {
                          return UserEditBottomSheet();
                        });
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.redAccent,
                  ),
                )
                // PopupMenuButton<int>(
                //   color: Theme.of(context).scaffoldBackgroundColor,
                //   offset: Offset(50, -100),
                //   itemBuilder: (context) => [
                //     PopupMenuItem<int>(
                //       value: 0,
                //       onTap: () {
                //         aShowToast(msg: "Coming soon");
                //       },
                //       child: PopUpMenuTile(
                //         icon: FontAwesomeIcons.list,
                //         title: 'Your Orders',
                //       ),
                //     ),
                //     PopupMenuItem<int>(
                //       value: 1,
                //       onTap: () {
                //         aShowToast(msg: "Coming soon");
                //       },
                //       child: PopUpMenuTile(
                //         icon: Icons.edit,
                //         title: 'Edit profile',
                //       ),
                //     ),
                //     PopupMenuItem(
                //       value: 3,
                //       onTap: () {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => FavoritesPage(),
                //           ),
                //         );
                //       },
                //       child: PopUpMenuTile(
                //         icon: Icons.favorite,
                //         title: 'favourites',
                //       ),
                //     ),
                //   ],
                //   child: Column(
                //     mainAxisSize: MainAxisSize.min,
                //     children: <Widget>[
                //       Icon(
                //         Icons.more_vert,
                //         color: Colors.redAccent,
                //       ),
                //     ],
                //   ),
                // ),
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

  // Column buildCountColumn(String label, int count, BuildContext context) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       Text(
  //         count.toString(),
  //         style: TextStyle(
  //           fontWeight: FontWeight.bold,
  //           fontSize: 18.0,
  //           color: Theme.of(context).textTheme.bodyText2!.color,
  //         ),
  //       ),
  //       Container(
  //         margin: EdgeInsets.only(
  //           top: 4.0,
  //           left: 5,
  //         ),
  //         child: Text(
  //           label,
  //           style: TextStyle(
  //             color: Colors.grey,
  //             fontSize: 16.0,
  //             fontWeight: FontWeight.w400,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final authControllerState = useProvider(authControllerProvider);
    final userDetailProvider = useProvider(userDetailFutureShowProvider);

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 5,
            ),
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.redAccent,
              backgroundImage: CachedNetworkImageProvider(
                authControllerState!.photoURL ??
                    "https://img.icons8.com/cute-clipart/2x/user-male.png",
              ),
            ),
            SizedBox(
              height: 5,
            ),
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
              mainAxisAlignment: MainAxisAlignment.center,
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
            ),
            SizedBox(height: 5),
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
            ),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingPage(),
                    ),
                  );
                },
                child: Text(
                  "Edit Profile",
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              height: 340,
              child: userDetailProvider.when(
                  data: (data) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                      color: Colors.grey[300]),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 8),
                                        alignment: Alignment.topLeft,
                                        color: Colors.transparent,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8, right: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Height',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0,
                                                    color: Colors.grey[600]),
                                              ),
                                              Icon(Icons.games_outlined)
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.only(left: 8, top: 15),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${data.height} cm",
                                          style: kSmallContentStyle.copyWith(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Flexible(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    aShowToast(
                                      msg:
                                          "Modification feature will be provided soon",
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                        color: Colors.grey[300]),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 8),
                                          alignment: Alignment.topLeft,
                                          color: Colors.transparent,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8, right: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Weight',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20.0,
                                                      color: Colors.grey[600]),
                                                ),
                                                Icon(FontAwesomeIcons.weight)
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.only(left: 8, top: 15),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${data.weight} kg",
                                            style: kSmallContentStyle.copyWith(
                                              color: Colors.black,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Flexible(
                                child: GestureDetector(
                                  onTap: () {
                                    aShowToast(
                                      msg:
                                          "Modification feature will be provided soon",
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                        color: Colors.grey[300]),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 8),
                                          alignment: Alignment.topLeft,
                                          color: Colors.transparent,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 16, right: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'About',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 22.0,
                                                      color: Colors.grey[600]),
                                                ),
                                                Icon(FontAwesomeIcons.toolbox),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.only(left: 8, top: 10),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${data.about}",
                                            style: kSmallContentStyle.copyWith(
                                              color: Colors.black,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            children: [
                              Flexible(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    aShowToast(
                                        msg:
                                            "Modification feature will be provided soon");
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                        color: Colors.grey[300]),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 8),
                                          alignment: Alignment.topLeft,
                                          color: Colors.transparent,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 14, right: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Age',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20.0,
                                                      color: Colors.grey[600]),
                                                ),
                                                Icon(Icons.format_list_numbered)
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.only(left: 8, top: 15),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${data.age} years",
                                            style: kSmallContentStyle.copyWith(
                                              color: Colors.black,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Flexible(
                                child: GestureDetector(
                                  onTap: () {
                                    aShowToast(
                                      msg:
                                          "Modification feature will be provided soon",
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                        color: Colors.grey[300]),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 8),
                                          alignment: Alignment.topLeft,
                                          color: Colors.transparent,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 16, right: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Reminder',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 22.0,
                                                      color: Colors.grey[600]),
                                                ),
                                                Icon(FontAwesomeIcons.moon),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.only(left: 8, top: 15),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "06:15 AM",
                                            style: kSmallContentStyle.copyWith(
                                              color: Colors.black,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 8),
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              Text(
                                                "Set",
                                                style:
                                                    kSmallContentStyle.copyWith(
                                                  color: Colors.grey[600],
                                                  fontSize: 15,
                                                ),
                                              ),
                                              Icon(
                                                Icons.alarm,
                                                size: 18,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Flexible(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    aShowToast(
                                      msg:
                                          "Modification feature will be provided soon",
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                        color: Colors.grey[300]),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 8),
                                          alignment: Alignment.topLeft,
                                          color: Colors.transparent,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 14, right: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Bio',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20.0,
                                                      color: Colors.grey[600]),
                                                ),
                                                Icon(FontAwesomeIcons.book)
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.only(left: 8, top: 15),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${data.bio}",
                                            style: kSmallContentStyle.copyWith(
                                              color: Colors.black,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                  loading: () => Container(
                        height: 55,
                        width: 55,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  error: (e, s) {
                    return Center(child: Text("No Data"));
                  }),
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
