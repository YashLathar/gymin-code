import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/pages/setting_page.dart';
import 'package:gym_in/widgets/toast_msg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final _tabController = useTabController(initialLength: 2);
    final authControllerState = useProvider(authControllerProvider);
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25),
                        ),
                      ),
                      context: context,
                      builder: (context) {
                        return logOutSheet(context);
                      },
                    );
                  },
                  child: Text(
                    authControllerState!.displayName ?? 'UserName',
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    "You don't have Gymin Rights",
                                    style: kSmallContentStyle.copyWith(
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          await Future.delayed(
                                              Duration(seconds: 1));
                                          Navigator.pop(context);
                                          aShowToast(
                                            msg:
                                                "Your Request has been Accepted !",
                                          );
                                        },
                                        child: Text(
                                          "Request",
                                        ),
                                      ),
                                      SimpleDialogOption(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Cancel"),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(
                    Icons.check_circle,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return SimpleDialog(
                            title: Text(
                              "Create a Post",
                              style: kSmallContentStyle,
                            ),
                            children: [
                              SimpleDialogOption(
                                child: Text(
                                  'Photo with Camera',
                                  style:
                                      kSmallContentStyle.copyWith(fontSize: 13),
                                ),
                                onPressed: () {}, //handleTakePhoto
                              ),
                              SimpleDialogOption(
                                child: Text(
                                  'Image with Gallery',
                                  style:
                                      kSmallContentStyle.copyWith(fontSize: 13),
                                ),
                                onPressed: () {}, //handleChooseFromGallery
                              ),
                              SimpleDialogOption(
                                child: Text(
                                  'Cancel',
                                  style:
                                      kSmallContentStyle.copyWith(fontSize: 13),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        });
                  },
                  icon: Icon(
                    Icons.add_box_rounded,
                    color: Colors.redAccent,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    //  showMenu(
                    //    context: context,
                    //    position: ,
                    //    items:
                    //  [
                    //         PopupMenuItem<int>(
                    //           value: 0,
                    //           child: Text('Edit Profile'),
                    //         ),
                    //         PopupMenuItem<int>(
                    //           value: 1,
                    //           child: Text('Dark Mode'),
                    //         ),
                    //         PopupMenuItem<int>(
                    //           value: 1,
                    //           child: Text('Settings'),
                    //         ),
                    //       ]
                    //  ); // throw PopupMenuButton;
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SettingPage()));
                  },
                  icon: Icon(
                    Icons.more_vert,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              ProfileHeader1(),
              ProfileHeader2(),
              Divider(
                thickness: 3.0,
                height: 0.0,
              ),
              ProfilePostsView(),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileHeader1 extends HookWidget {
  const ProfileHeader1({Key? key}) : super(key: key);

  Column buildCountColumn(String label, int count) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          count.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: Colors.black,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 4.0, left: 5,),
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
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
      ),
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    //margin: EdgeInsets.only(left: 15),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: 18,
                          ),
                          child: Row(
                            // mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              buildCountColumn("posts", 0), //postCount
                              SizedBox(
                                width: 10,
                              ),
                              buildCountColumn("followers", 0),
                              SizedBox(
                                width: 10,
                              ),
                              buildCountColumn("following", 0),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Taurus ♉",
                          style: kSmallContentStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "Programmer 👨‍💻",
                          style: kSmallContentStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "Forex Trader 📈",
                          style: kSmallContentStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "Coach 🧑",
                          style: kSmallContentStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "Sigma ✨",
                          style: kSmallContentStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "Autophile🔥",
                          style: kSmallContentStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "Nyctophile ✔️",
                          style: kSmallContentStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        InkWell(
                          onTap:
                              // _launchURLApp,
                              _launchURLBrowser,
                          // () async {

                          //   await Future.delayed(Duration(seconds: 1));
                          //   aShowToast(msg: "Gymin WebView");
                          // },
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
                  )
                ],
              ),
              SizedBox(
                width: 13,
              ),
              Column(
                children: [
                  Container(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundImage: NetworkImage(
                            authControllerState!.photoURL ??
                                "https://fanfest.com/wp-content/uploads/2021/02/Loki.jpg",
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          authControllerState.displayName ?? 'UserName',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // Row(
                        //   children: [
                        //     Column(
                        //       children: [
                        //         Text(
                        //           "Height:",
                        //           style: TextStyle(
                        //             fontWeight: FontWeight.w600,
                        //             fontSize: 12,
                        //           ),
                        //         ),
                        //         Text(
                        //           "Weight:",
                        //           style: TextStyle(
                        //             fontWeight: FontWeight.w600,
                        //             fontSize: 12,
                        //           ),
                        //         ),
                        //         Text(
                        //           "Age:",
                        //           style: TextStyle(
                        //             fontWeight: FontWeight.w600,
                        //             fontSize: 12,
                        //           ),
                        //         ),
                        //         Text(
                        //           "Activity:",
                        //           style: TextStyle(
                        //             fontWeight: FontWeight.w600,
                        //             fontSize: 12,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //     Column(
                        //       children: [
                        //         Text(
                        //           "5'11\"",
                        //           style: TextStyle(
                        //             fontWeight: FontWeight.w600,
                        //             fontSize: 12,
                        //           ),
                        //         ),
                        //         Text(
                        //           "81 Kg\"",
                        //           style: TextStyle(
                        //             fontWeight: FontWeight.w600,
                        //             fontSize: 12,
                        //           ),
                        //         ),
                        //         Text(
                        //           "21\"",
                        //           style: TextStyle(
                        //             fontWeight: FontWeight.w600,
                        //             fontSize: 12,
                        //           ),
                        //         ),
                        //         Text(
                        //           "7.9⭐️",
                        //           style: TextStyle(
                        //             fontWeight: FontWeight.w600,
                        //             fontSize: 12,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          // ButtonTheme(
          //   height: 35,
          //   minWidth: 300,
          //   buttonColor: Colors.redAccent,
          //   child: RaisedButton(
          //     onPressed: () {},
          //     child: Text("Edit Profile",
          //     ),),
          // ),
        ],
      ),
    );
  }
}

// profilePostsView() {
//   if (isLoading) {
//     return CircularProgressIndicator();
//   }
//     return Column(children: posts,);
// }

class ProfileHeader2 extends HookWidget {
  const ProfileHeader2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                                "Earn New Badge",
                                style: kSmallContentStyle,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    child: Text("Earn"),
                                    onPressed: () async {
                                      await Future.delayed(
                                          Duration(seconds: 0));
                                      Navigator.pop(context);
                                      aShowToast(msg: "Work in Progress !");
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
                    },
                  );
                },
                child: CircleAvatar(
                  radius: 30,
                  child: Icon(
                    Icons.add,
                  ),
                  backgroundColor: Colors.redAccent,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvL5s8yPVen34OJG08FHgZPrSIDBWyrheg3Q&usqp=CAU",
                  ),
                ),
              ),
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSH2whDJ2XZINbounqZuhGrvEIGpPDnuwmIcQ&usqp=CAU",
                ),
              ),
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEkhRG2Ms5RS6xQoQhRsdJnAIsU5TSARY_fg&usqp=CAU",
                ),
              ),
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSI8CvywojT7GQZsNDU-U54aZhFGb1SvZnD1Q&usqp=CAU",
                ),
              ),
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8PcN8hh6ZroeG92qoCAJXK76EjMYZQ0bvJg&usqp=CAU",
                ),
              ),
              // CircleAvatar(
              //   radius: 30,
              //   backgroundColor: Colors.green,
              // ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProfilePostsView extends HookWidget {
  const ProfilePostsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.fromLTRB(15, 15, 10, 15),
      // height: 200,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://m.media-amazon.com/images/I/91I48aFAZDL._AC_SL1500_.jpg",
                        ),
                      ),
                    ),
                    height: 280,
                    width: 195,
                    // color: Colors.redAccent,
                    child: Center(
                      child: Text(
                        "data",
                        style: TextStyle(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://cdn.vox-cdn.com/thumbor/8ye9Zy39nTLGx51sDcGrHreR4yw=/265x0:1878x1075/1200x800/filters:focal(265x0:1878x1075)/cdn.vox-cdn.com/uploads/chorus_image/image/49183577/deadpool-fox-marvel_03.0.0.jpg",
                        ),
                      ),
                    ),
                    height: 128,
                    width: 180,
                    child: Center(
                      child: Text(
                        "data",
                        style: TextStyle(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28),
                        bottomLeft: Radius.circular(28),
                        bottomRight: Radius.circular(28),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqt8A5IlFetK5N6sbot3_13cI9k_jcXnj9VQ&usqp=CAU",
                        ),
                      ),
                    ),
                    height: 128,
                    width: 180,
                    // color: Colors.redAccent,
                    child: Center(
                      child: Text(
                        "data",
                        style: TextStyle(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://cdn.vox-cdn.com/thumbor/8ye9Zy39nTLGx51sDcGrHreR4yw=/265x0:1878x1075/1200x800/filters:focal(265x0:1878x1075)/cdn.vox-cdn.com/uploads/chorus_image/image/49183577/deadpool-fox-marvel_03.0.0.jpg",
                        ),
                      ),
                    ),
                    height: 128,
                    width: 180,
                    child: Center(
                      child: Text(
                        "data",
                        style: TextStyle(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28),
                        bottomLeft: Radius.circular(28),
                        bottomRight: Radius.circular(28),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqt8A5IlFetK5N6sbot3_13cI9k_jcXnj9VQ&usqp=CAU",
                        ),
                      ),
                    ),
                    height: 128,
                    width: 180,
                    // color: Colors.redAccent,
                    child: Center(
                      child: Text(
                        "data",
                        style: TextStyle(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://m.media-amazon.com/images/I/91I48aFAZDL._AC_SL1500_.jpg",
                        ),
                      ),
                    ),
                    height: 280,
                    width: 195,
                    // color: Colors.redAccent,
                    child: Center(
                      child: Text(
                        "data",
                        style: TextStyle(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://m.media-amazon.com/images/I/91I48aFAZDL._AC_SL1500_.jpg",
                        ),
                      ),
                    ),
                    height: 280,
                    width: 195,
                    // color: Colors.redAccent,
                    child: Center(
                      child: Text(
                        "data",
                        style: TextStyle(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://cdn.vox-cdn.com/thumbor/8ye9Zy39nTLGx51sDcGrHreR4yw=/265x0:1878x1075/1200x800/filters:focal(265x0:1878x1075)/cdn.vox-cdn.com/uploads/chorus_image/image/49183577/deadpool-fox-marvel_03.0.0.jpg",
                        ),
                      ),
                    ),
                    height: 128,
                    width: 180,
                    child: Center(
                      child: Text(
                        "data",
                        style: TextStyle(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28),
                        bottomLeft: Radius.circular(28),
                        bottomRight: Radius.circular(28),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqt8A5IlFetK5N6sbot3_13cI9k_jcXnj9VQ&usqp=CAU",
                        ),
                      ),
                    ),
                    height: 128,
                    width: 180,
                    // color: Colors.redAccent,
                    child: Center(
                      child: Text(
                        "data",
                        style: TextStyle(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

// final String currentUserid = currentUserid?.id;
// bool isLoading = false;
// int postCount = 0;
// List<Post> posts = [];

// @override
// void initState() {
//   super.initState();
//   getProfilePosts();
// }

// getProfilePosts() async {
//   setState(() {
//     isLoading = true;
//   });
//   QuerySnapshot snapshot = await postsRef
//         .ducument(widget.profileId)
//         .collection('userPosts')
//         .orderBy('timestamp', descending: true)
//         .getDocuments();
//     setState(() {
//       isLoading = false;
//       postCount = snapshot.documents.length;
//       posts = snapshot.documents.map((doc) => Post.fromDocument(doc)).toList();
//     });
// }
