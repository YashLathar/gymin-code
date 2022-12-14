import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/pages/editprofile_page.dart';
import 'package:gym_in/pages/user_page.dart';
import 'package:gym_in/services/user_detail_service.dart';
import 'package:gym_in/widgets/toast_msg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingPage extends HookConsumerWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authControllerState = ref.watch(authControllerProvider);
    final userDetailProvider = ref.watch(userDetailServiceProvider);

    final phoneController = useTextEditingController();
    final aboutController = useTextEditingController();
    final bioController = useTextEditingController();
    final ageController = useTextEditingController();
    final heightController = useTextEditingController();
    final weightController = useTextEditingController();
    final addressController = useTextEditingController();

    //final _tabController = useTabController(initialLength: 2);
    if (authControllerState != null) {
      return Scaffold(
        body: SafeArea(
          child: ListView(
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
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6.0),
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
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(authControllerState
                                    .photoURL ??
                                "https://fanfest.com/wp-content/uploads/2021/02/Loki.jpg"),
                          ),
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
                              color:
                                  Theme.of(context).textTheme.bodyText2!.color,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.verified,
                        color: Theme.of(context).textTheme.bodyText2!.color,
                      ),
                      title: Text(
                        'Verify Your Email',
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyText2!.color),
                      ),
                      onTap: () async {
                        final actionCodeSettings = ActionCodeSettings(
                            url: 'https://www.gymin.co.in',
                            handleCodeInApp: true,
                            androidInstallApp: true,
                            androidMinimumVersion: '12');

                        if (!authControllerState.emailVerified) {
                          await authControllerState
                              .sendEmailVerification(actionCodeSettings)
                              .then((value) async {
                            aShowToast(
                                msg: "Verification Link sent to you email");

                            await authControllerState.reload();
                          });
                        } else {
                          aShowToast(msg: "Email already verified");
                        }

                        await authControllerState.reload();
                      },
                    ),
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
                              return CustomBottomSheet(
                                isNumPad: true,
                                lable: "Phone",
                                bottomLable: "How should we contact you?",
                                controller: phoneController,
                                onTap: () async {
                                  if (phoneController.text.length == 10) {
                                    final intPhone =
                                        int.parse(phoneController.text);

                                    await userDetailProvider
                                        .updateUserPhoneNumber(
                                            intPhone, authControllerState.uid);

                                    ref.refresh(userDetailFutureShowProvider.future);
                                    Navigator.pop(context);
                                  } else {
                                    aShowToast(msg: "Invalid Number");
                                  }
                                },
                              );
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
                              return CustomBottomSheet(
                                isNumPad: true,
                                lable: "Age",
                                bottomLable: "What's your age?",
                                controller: ageController,
                                onTap: () async {
                                  final intAge = int.parse(ageController.text);
                                  await userDetailProvider.updateUserAge(
                                      intAge, authControllerState.uid);
                                  ref.refresh(userDetailFutureShowProvider.future);
                                  Navigator.pop(context);
                                },
                              );
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
                              return CustomBottomSheet(
                                isNumPad: true,
                                controller: heightController,
                                lable: "Height",
                                bottomLable: "What's your height?",
                                onTap: () async {
                                  final intHeight =
                                      int.parse(heightController.text);
                                  await userDetailProvider.updateUserHeight(
                                      intHeight, authControllerState.uid);
                                  ref.refresh(userDetailFutureShowProvider.future);
                                  Navigator.pop(context);
                                },
                              );
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
                              return CustomBottomSheet(
                                isNumPad: true,
                                controller: weightController,
                                lable: "Weight",
                                bottomLable: "How fat are you?",
                                onTap: () async {
                                  final intWeight =
                                      int.parse(weightController.text);
                                  await userDetailProvider.updateUserWeight(
                                      intWeight, authControllerState.uid);
                                  ref.refresh(userDetailFutureShowProvider.future);
                                  Navigator.pop(context);
                                },
                              );
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
                              return CustomBottomSheet(
                                isNumPad: false,
                                controller: aboutController,
                                lable: "About",
                                bottomLable: "Something about yourself",
                                onTap: () async {
                                  await userDetailProvider.updateUserAbout(
                                      aboutController.text,
                                      authControllerState.uid);
                                  ref.refresh(userDetailFutureShowProvider.future);
                                  Navigator.pop(context);
                                },
                              );
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
                              return CustomBottomSheet(
                                isNumPad: false,
                                controller: bioController,
                                lable: "Bio",
                                bottomLable: "Your Bio",
                                onTap: () async {
                                  await userDetailProvider.updateUserBio(
                                      bioController.text,
                                      authControllerState.uid);
                                  ref.refresh(userDetailFutureShowProvider.future);
                                  Navigator.pop(context);
                                },
                              );
                            });
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.locationArrow,
                        color: Theme.of(context).textTheme.bodyText2!.color,
                      ),
                      title: Text(
                        'Address',
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
                              return CustomBottomSheet(
                                isNumPad: false,
                                controller: addressController,
                                lable: "Address",
                                bottomLable: "Your Address",
                                onTap: () async {
                                  await userDetailProvider.updateUserAddress(
                                      addressController.text,
                                      authControllerState.uid);
                                  ref.refresh(userDetailFutureShowProvider.future);
                                  Navigator.pop(context);
                                },
                              );
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
                        aShowToast(msg: "Coming Soon");
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

class CustomBottomSheet extends HookWidget {
  const CustomBottomSheet({
    Key? key,
    required this.onTap,
    required this.lable,
    required this.bottomLable,
    required this.controller,
    required this.isNumPad,
  }) : super(key: key);

  final Function onTap;
  final String lable;
  final TextEditingController controller;
  final String bottomLable;
  final bool isNumPad;

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: isLoading.value
          ? Center(
              child: Container(
                width: 85,
                height: 85,
                child: CircularProgressIndicator(),
              ),
            )
          : ListView(
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
                          controller: controller,
                          keyboardType: isNumPad
                              ? TextInputType.phone
                              : TextInputType.text,
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText2!.color),
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
                            hintText: "Enter Your $lable",
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .color),
                            helperText: '$bottomLable',
                            helperStyle: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .color),
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
                              color:
                                  Theme.of(context).textTheme.bodyText2!.color),
                        ),
                        onPressed: () async {
                          await onTap();
                          aShowToast(msg: "Updated");
                        },
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
