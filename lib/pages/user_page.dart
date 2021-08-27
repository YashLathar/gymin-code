import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/dumy-data/gyms_info.dart';
import 'package:gym_in/general_providers.dart';
import 'package:gym_in/pages/login_page.dart';
import 'package:gym_in/pages/setting_page.dart';
import 'package:gym_in/services/error_Handler.dart';
import 'package:gym_in/services/storage_service.dart';
import 'package:gym_in/widgets/gym_card.dart';
import 'package:gym_in/widgets/user_post_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class UserPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final authControllerState = useProvider(authControllerProvider);
    final _tabController = useTabController(initialLength: 2);
    Size size = MediaQuery.of(context).size;

    if (authControllerState != null) {
      return Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: Container(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 40, bottom: 30),
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35)),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
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
                            child: Icon(Icons.settings),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SettingPage()));
                                      // Navigator.pushNamed(context, "/SettingPage");
                                    },
                                    child: Text(
                                      authControllerState.displayName ??
                                          'UserName',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    authControllerState.email ??
                                        'example@email.com',
                                  ),
                                ],
                              ),
                              // to edit username
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(authControllerState
                                      .photoURL ??
                                  "https://fanfest.com/wp-content/uploads/2021/02/Loki.jpg")),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  'Followers',
                                  style: kSmallHeadingTextStyle,
                                ),
                                Text(
                                  '732k',
                                  style: kSmallContentStyle,
                                ),
                              ],
                            ),
                          ),
                          verticalDivider(),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  'Posts',
                                  style: kSmallHeadingTextStyle,
                                ),
                                Text(
                                  '116',
                                  style: kSmallContentStyle,
                                ),
                              ],
                            ),
                          ),
                          verticalDivider(),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  'Following',
                                  style: kSmallHeadingTextStyle,
                                ),
                                Text(
                                  '326',
                                  style: kSmallContentStyle,
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
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: TabBar(
                  indicatorColor: Colors.cyan,
                  controller: _tabController,
                  tabs: [
                    Tab(
                      child: Text(
                        'Posts',
                        style: kSmallHeadingTextStyle,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Gyms visited',
                        style: kSmallHeadingTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    UserPostWidget(images: [
                      "https://images.pexels.com/photos/2294361/pexels-photo-2294361.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
                      "https://images.pexels.com/photos/3490348/pexels-photo-3490348.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
                      "https://images.pexels.com/photos/1865131/pexels-photo-1865131.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
                      "https://images.pexels.com/photos/2294361/pexels-photo-2294361.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
                    ]),
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: gymsData.length,
                        itemBuilder: (context, index) {
                          return GymCard(
                            gymName: gymsData[index].gymName,
                            gymPhotoUrl: gymsData[index].gymPhotoUrl[0],
                            index: index,
                            ratings: gymsData[index].ratings,
                            isCurrentlyOpen: gymsData[index].isOpen,
                            address: gymsData[index].address,
                          );
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return LoginPage();
    }
  }

  Widget verticalDivider() {
    return Container(
      height: 40,
      width: 1.5,
      decoration: BoxDecoration(color: Colors.grey),
    );
  }

  Widget horizontalDivider() {
    return Expanded(
      child: Container(
        height: 2,
        decoration: BoxDecoration(color: Colors.grey),
      ),
    );
  }

  // Widget bottomSheet(BuildContext context, Future<XFile?> imagePicker) {
  //   Size size = MediaQuery.of(context).size;
  //   return Container(
  //     height: size.height,
  //     width: size.width,
  //     margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
  //     child: Column(
  //       children: [
  //         Text('Choose a Profile Pic'),
  //         SizedBox(height: 20),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             TextButton.icon(
  //                 onPressed: () {},
  //                 icon: Icon(Icons.camera),
  //                 label: Text("Camera")),
  //             TextButton.icon(
  //                 onPressed: () {
  //                   imagePicker();
  //                 },
  //                 icon: Icon(Icons.image),
  //                 label: Text("Gallery"))
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }

}

class UserEditBottomSheet extends HookWidget {
  const UserEditBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageProvider = useProvider(imagePickerProvider);
    final usernameController = useTextEditingController();
    final imagePath = useState("");

    Future<XFile?> imagePicker() async {
      final image = await imageProvider.pickImage(source: ImageSource.gallery);

      if (image != null) {
        imagePath.value = image.path;
        return image;
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    radius: 50,
                    backgroundImage: imagePath.value.isEmpty
                        ? null
                        : Image.file(File(imagePath.value)).image),
                InkWell(
                  onTap: () async {
                    final xFile = await imagePicker();
                    final filePath = xFile!.path;
                    final file = File(filePath);
                    await context
                        .read(storageServiceProvider)
                        .uploadProfileImage(file);
                  },
                  child: Center(
                    child: Icon(Icons.camera_alt),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Update Your Profile'),
              Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.cancel),
                color: Colors.redAccent,
                iconSize: 25,
                //label: Text("Cancel")
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      helperText: 'What should we call you?',
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
                padding: EdgeInsets.all(30),
                child: MaterialButton(
                  color: Colors.grey,
                  child: Text("Update"),
                  onPressed: () async {
                    if (usernameController.text == "") {
                      return ErrorHandler.errorDialog(
                          context, ErrorWidget("This field can't be empty"));
                    }

                    final downloadUrl = await context
                        .read(storageServiceProvider)
                        .getDownloadUrl();

                    await context
                        .read(authControllerProvider.notifier)
                        .setUserName(usernameController.text);

                    await context
                        .read(authControllerProvider.notifier)
                        .setProfilePhoto(downloadUrl);

                    usernameController.text = "";
                    Navigator.of(context).pop();
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
