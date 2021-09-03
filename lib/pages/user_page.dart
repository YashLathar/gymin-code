import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_in/controllers/auth_controller.dart';
// import 'package:gym_in/dumy-data/gyms_info.dart';
import 'package:gym_in/models/post.dart';
import 'package:gym_in/pages/setting_page.dart';
// import 'package:gym_in/widgets/gym_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  // final String currentUserid = currentUserid?.id;
  bool isLoading = false;
  int postCount = 0;
  List<Post> posts = [];

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

  @override
  Widget build(BuildContext context) {
    // final _tabController = useTabController(initialLength: 2);
    return Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ProfileHeader(),
              // Divider(
              //   height: 0.0,
              // ),
              ProfilePostsView(),
            ],
          ),
        ));
  }
}

class ProfileHeader extends HookWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  Column buildCountColumn(String label, int count) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          count.toString(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
        ),
        Container(
            margin: EdgeInsets.only(top: 4.0),
            child: Text(
              label,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
              ),
            )
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final authControllerState = useProvider(authControllerProvider);
    
    return 
    // Container(
    //   width: size.width,
    //   height: size.height,
    //   child: 
      Column(children: [
        Container(
          padding: EdgeInsets.only(top: 40, bottom: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35)),
          ),
          child: Column(children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingPage()));
                      // showModalBottomSheet(
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.vertical(
                      //           top: Radius.circular(25)),
                      //     ),
                      //     clipBehavior: Clip.antiAliasWithSaveLayer,
                      //     context: context,
                      //     builder: (BuildContext buildContext) {
                      //       return UserEditBottomSheet();
                      //     });
                    },
                    child: Icon(Icons.settings),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             SettingPage()));
                            },
                            child: Text(
                              authControllerState!.displayName ?? 'UserName',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            authControllerState.email ?? 'example@email.com',
                          ),
                          Text(//authControllerState.Bio ?? 
                          'Whatever_it_takes!!')
                        ],
                      ),
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
              child: Column(children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildCountColumn("posts", 0 //postCount
                    ),
                    buildCountColumn("followers", 0),
                    buildCountColumn("following", 0),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Edit Profile")
                    //profileButton(),
                  ],
                ),
              ]),
            ),
            
          ]),
        ),
      ]);
  }
}


// profilePostsView() {
//   if (isLoading) {
//     return CircularProgressIndicator();
//   }
//     return Column(children: posts,);
// }

class ProfilePostsView extends StatelessWidget {
  const ProfilePostsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return 
    Container(
      width: size.width,
       height: size.height,
      child: Column(
        children: [
          Text("data"),
          Text("data"),
          Text("data"),
          Text("data"),
          Text("data"),
          Text("data"),
          Text("data"),
        ],
      ),
    );
  }
}
