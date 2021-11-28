import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_in/constants.dart';
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
        body: SafeArea(
          child: Column(
            children: [
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        border: Border.all(
                            width: 2.0,
                            color: Theme.of(context).backgroundColor),
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Theme.of(context).backgroundColor,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Edit Profile",
                          style: kSubHeadingStyle.copyWith(
                              color:
                                  Theme.of(context).textTheme.bodyText2!.color),
                        ),
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        border: Border.all(
                          width: 2.0,
                          color: Colors.transparent,
                        ),
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .color,
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
                              isDismissible: true,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
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
                        icon: Icon(
                          Icons.edit,
                          color: Theme.of(context).textTheme.bodyText2!.color,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.phone,
                        color: Theme.of(context).textTheme.bodyText2!.color,
                      ),
                      title: Text(
                        'Phone Number',
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyText2!.color),
                      ),
                      onTap: () {
                        showModalBottomSheet(
                            isDismissible: true,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25)),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            context: context,
                            builder: (BuildContext buildContext) {
                              return PhoneNumber();
                            });
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.birthdayCake,
                        color: Theme.of(context).textTheme.bodyText2!.color,
                      ),
                      title: Text(
                        'Age',
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyText2!.color),
                      ),
                      onTap: () {
                        showModalBottomSheet(
                            isDismissible: true,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25)),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            context: context,
                            builder: (BuildContext buildContext) {
                              return Container();
                            });
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.height,
                        color: Theme.of(context).textTheme.bodyText2!.color,
                      ),
                      title: Text(
                        'Height',
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyText2!.color),
                      ),
                      onTap: () {
                        showModalBottomSheet(
                            isDismissible: true,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25)),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            context: context,
                            builder: (BuildContext buildContext) {
                              return Container();
                            });
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.line_weight,
                        color: Theme.of(context).textTheme.bodyText2!.color,
                      ),
                      title: Text(
                        'Weight',
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyText2!.color),
                      ),
                      onTap: () {
                        showModalBottomSheet(
                            isDismissible: true,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25)),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            context: context,
                            builder: (BuildContext buildContext) {
                              return Container();
                            });
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.laptop,
                        color: Theme.of(context).textTheme.bodyText2!.color,
                      ),
                      title: Text(
                        'About',
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyText2!.color),
                      ),
                      onTap: () {
                        showModalBottomSheet(
                            isDismissible: true,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25)),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            context: context,
                            builder: (BuildContext buildContext) {
                              return Container();
                            });
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.edit,
                        color: Theme.of(context).textTheme.bodyText2!.color,
                      ),
                      title: Text(
                        'Bio',
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyText2!.color),
                      ),
                      onTap: () {
                        showModalBottomSheet(
                            isDismissible: true,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25)),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            context: context,
                            builder: (BuildContext buildContext) {
                              return Container();
                            });
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.alarm,
                        color: Theme.of(context).textTheme.bodyText2!.color,
                      ),
                      title: Text(
                        'Reminder',
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyText2!.color),
                      ),
                      onTap: () {
                        showModalBottomSheet(
                            isDismissible: true,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25)),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            context: context,
                            builder: (BuildContext buildContext) {
                              return Container();
                            });
                      },
                    ),
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

class PhoneNumber extends StatelessWidget {
  const PhoneNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Icon(Icons.drag_handle,
                color: Theme.of(context).backgroundColor),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Update Your Profile',
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText2!.color),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.cancel),
                color: Theme.of(context).textTheme.bodyText2!.color,
                iconSize: 25,
                //label: Text("Cancel")
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: 15.0,
                  ),
                  child: TextField(
                    // controller: usernameController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Theme.of(context).backgroundColor,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.redAccent, //0xffF14C37
                          width: 2,
                        ),
                      ),
                      hintText: "Enter Your Phone Number",
                      hintStyle: TextStyle(
                          color: Theme.of(context).textTheme.bodyText2!.color),
                      helperText: 'How Should we contact you?',
                      helperStyle: TextStyle(
                          color: Theme.of(context).textTheme.bodyText2!.color),
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                    30, 30, 30, MediaQuery.of(context).viewInsets.bottom),
                child: MaterialButton(
                  color: Colors.redAccent,
                  child: Text(
                    "Update",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText2!.color),
                  ),
                  onPressed: () {},
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class AgeUpdate extends StatelessWidget {
  const AgeUpdate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [],
    ));
  }
}
