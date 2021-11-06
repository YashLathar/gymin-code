import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/pages/activity_page.dart';
import 'package:gym_in/pages/feeds_page.dart';
import 'package:gym_in/pages/gym_owner_page.dart';
import 'package:gym_in/pages/login_page.dart';
import 'package:gym_in/pages/products_page.dart';
import 'package:gym_in/pages/home_page.dart';
import 'package:gym_in/pages/trainers_page.dart';
import 'package:gym_in/pages/user_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:io';

class HomeScreen extends HookWidget {
  final GlobalKey _bottomNavigationKey = GlobalKey();

  final List<Widget> pages = [
    HomePage(),
    ActivityPage(),
    // FeedsPage(),
    GymProductsPage(),
    UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final authControllerState = useProvider(authControllerProvider);
    final _pageIndex = useState(0);

    if (authControllerState != null) {
      return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Stack(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(
                      authControllerState.displayName ?? 'Username',
                      style: TextStyle(color: Colors.white),
                    ),
                    accountEmail: ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserPage()));
                      },
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                        size: 30,
                      ),
                      title: Text(
                        authControllerState.email ?? 'example@email.com',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    currentAccountPicture: CircleAvatar(
                      child: ClipOval(
                        child: //ImageProfile(),
                            Image.network(
                          authControllerState.photoURL ??
                              "https://img.icons8.com/cute-clipart/2x/user-male.png",
                          fit: BoxFit.cover,
                          width: 90,
                          height: 90,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          'https://images.pexels.com/photos/416717/pexels-photo-416717.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Gym Owner'),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GymOwnerPage())),
              ),
              ListTile(
                leading: Icon(Icons.verified_user),
                title: Text('Trainer Zone'),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TrainerZone())),
              ),
              ListTile(
                  leading: Icon(Icons.post_add),
                  title: Text('Social'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FeedsPage()));
                  }),
              // ListTile(
              //   leading: Icon(
              //     Icons.play_circle_fill,
              //   ),
              //   title: Text('Tutorials'),
              //   onTap: () =>
              //     Navigator.pushNamed(context, '/videosPage'),
              // ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.firstOrder),
                title: Text("Your Orders"),
                onTap: () {
                  Navigator.pushNamed(context, "/ordersPage");
                },
              ),

              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Favorites'),
                onTap: () => Navigator.pushNamed(context, '/favorites'),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () => Navigator.pushNamed(context, '/settingPage'),
              ),
              ListTile(
                leading: Icon(Icons.description),
                title: Text('Policies'),
                onTap: () => null,
              ),
              ListTile(
                  title: Text('Sign-Out'),
                  leading: Icon(Icons.logout),
                  onTap: () {
                    context.read(authControllerProvider.notifier).signOut();
                  }),
            ],
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          height: Platform.isIOS ? 60 : 54,
          key: _bottomNavigationKey,
          index: 0,
          items: [
            Icon(Icons.home_rounded),
            // Icon(Icons.image),
            Icon(Icons.run_circle),
            Icon(FontAwesomeIcons.shoppingBag),
            Icon(Icons.account_circle),
          ],
          color: Colors.redAccent,
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.redAccent,
          animationCurve: Curves.easeInOutCirc,
          animationDuration: Duration(milliseconds: 400),
          onTap: (index) {
            _pageIndex.value = index;
          },
        ),
        body: pages[_pageIndex.value],
        drawerEnableOpenDragGesture: true,
      );
    } else {
      return LoginPage();
    }
  }
}
