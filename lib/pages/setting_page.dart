import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/pages/editprofile_page.dart';
import 'package:gym_in/pages/user_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingPage extends HookWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authControllerState = useProvider(authControllerProvider);
    //final _tabController = useTabController(initialLength: 2);
    if (authControllerState != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Settings",
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Container(
              //   color: Colors.white,
              //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Container(
              //         width: 50,
              //         height: 50,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(35),
              //           border: Border.all(
              //             width: 2.0,
              //             color: Colors.black,
              //           ),
              //         ),
              //         child: Center(
              //           child: IconButton(
              //             onPressed: () {
              //               Navigator.pop(context);
              //             },
              //             icon: Icon(
              //               Icons.arrow_back_ios,
              //             ),
              //           ),
              //         ),
              //       ),
              //       Expanded(
              //         child: Center(
              //           child: Text(
              //             "Settings",
              //             style: kSubHeadingStyle,
              //           ),
              //         ),
              //       ),

              //     ],
              //   ),
              // ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(authControllerState
                                  .photoURL ??
                              "https://fanfest.com/wp-content/uploads/2021/02/Loki.jpg")),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            authControllerState.displayName ?? 'UserName',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(authControllerState.email ?? 'example@email.com')
                        ],
                      ),
                      Expanded(child: SizedBox()),
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25)),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                context: context,
                                builder: (BuildContext buildContext) {
                                  return UserEditBottomSheet();
                                });
                          },
                          icon: Icon(Icons.edit))
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text('E-mail'),
                      onTap: null,
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Phone Number'),
                      onTap: null,
                    ),
                    ListTile(
                      leading: Icon(Icons.notifications),
                      title: Text('Notification'),
                      onTap: null,
                    ),
                    ListTile(
                      leading: Icon(Icons.security),
                      title: Text('Security'),
                      onTap: null,
                    ),
                    ListTile(
                      leading: Icon(Icons.contact_mail),
                      title: Text('Contact Us'),
                      onTap: null,
                    ),
                    ListTile(
                        title: Text('Sign-Out'),
                        leading: Icon(Icons.logout),
                        onTap: () {
                          // context.read(authControllerProvider.notifier).signOut();
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return UserPage();
    }
  }
}
