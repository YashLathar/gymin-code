import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/controllers/theme_controller.dart';
import 'package:gym_in/pages/activity_page.dart';
import 'package:gym_in/pages/authenticate_ticket.dart';
import 'package:gym_in/pages/contact_page.dart';
import 'package:gym_in/pages/feedback_form.dart';
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
  

  //   void authenticateTicketByAdminOnly() async {
  //   final user = context.read(authControllerProvider);
  //   final userFromUsersCollection =
  //       await _firestore.collection('users').doc(user.uid).get();
  //   if (userFromUsersCollection.data()["authorization"]) {
  //     Navigator.of(context).push(MaterialPageRoute(
  //       builder: (_) => TrainerZone(),
  //     ));
  //   } else {
  //     Fluttertoast.showToast(msg: "Only Admin can Perform this Action");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final authControllerState = useProvider(authControllerProvider);
    final _pageIndex = useState(0);
    // FirebaseFirestore _firestore = FirebaseFirestore.instance;
    // bool thisUserAdmin = false;

    if (authControllerState != null) {
      return Scaffold(
        drawer: Drawer(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
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
                        // onTap: () {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => UserPage()));
                        // },
                        // trailing: Icon(
                        //   Icons.chevron_right,
                        //   color: Colors.white,
                        //   size: 30,
                        // ),
                        title: Text(
                          authControllerState.email ?? 'example@email.com',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      currentAccountPicture: CircleAvatar(
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: authControllerState.photoURL ??
                                "https://img.icons8.com/cute-clipart/2x/user-male.png",
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.cover,
                            width: 90,
                            height: 90,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
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

                // ListTile(
                //   leading: Icon(
                //     Icons.home,
                //     color: Theme.of(context).textTheme.bodyText2!.color,
                //   ),
                //   title: Text(
                //     'Gym Owner',
                //     style: TextStyle(
                //         color: Theme.of(context).textTheme.bodyText2!.color),
                //   ),
                //   onTap: () => Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => GymOwnerPage())),
                // ),
                ListTile(
                  leading: Icon(
                    Icons.verified,
                    color: Theme.of(context).textTheme.bodyText2!.color,
                  ),
                  title: Text(
                    'Authenticate',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText2!.color),
                  ),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AuthenticateTicket())),
                ),
                ListTile(
                  leading: Icon(Icons.verified_user,
                  color: Theme.of(context).textTheme.bodyText2!.color,
                  ),
                  title: Text('Trainer Zone',
                  style: TextStyle(color: Theme.of(context).textTheme.bodyText2!.color),
                  ),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TrainerZone())),
                ),
                // ListTile(
                //     leading: Icon(
                //       Icons.image,
                //       color: Theme.of(context).textTheme.bodyText2!.color,
                //     ),
                //     title: Text(
                //       'Social',
                //       style: TextStyle(
                //           color: Theme.of(context).textTheme.bodyText2!.color),
                //     ),
                //     onTap: () {
                //       aShowToast(msg: "Coming soon");
                //       // Navigator.push(context,
                //       // MaterialPageRoute(builder: (context) => FeedsPage()));
                //     }),
                ListTile(
                  leading: Icon(
                      context.read(themeControllerProvider).theme
                          ? FontAwesomeIcons.moon
                          : Icons.light_mode,
                      color: Theme.of(context).textTheme.bodyText2!.color),
                  title: Text(
                    'Theme',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText2!.color),
                  ),
                  trailing: Switch(
                    value: context.read(themeControllerProvider).theme,
                    onChanged: (enabled) {},
                  ),
                  onTap: () {
                    final currentTheme =
                        context.read(themeControllerProvider).theme;
                    if (!currentTheme) {
                      context.read(themeControllerProvider).setTheme(true);
                    } else {
                      context.read(themeControllerProvider).setTheme(false);
                    }

                    // final ThemePreferences preferences = ThemePreferences();

                    // preferences.setTheme(context.read(appThemeProvider).state);
                  },
                ),
                ListTile(
                  leading: FaIcon(
                    FontAwesomeIcons.list,
                    color: Theme.of(context).textTheme.bodyText2!.color,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "/ordersPage");
                  },
                  title: Text(
                    "Your Orders",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText2!.color),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.favorite,
                    color: Theme.of(context).textTheme.bodyText2!.color,
                  ),
                  title: Text(
                    'Favorites',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText2!.color),
                  ),
                  onTap: () => Navigator.pushNamed(context, '/favorites'),
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Theme.of(context).textTheme.bodyText2!.color,
                  ),
                  title: Text(
                    'Settings',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText2!.color),
                  ),
                  onTap: () => Navigator.pushNamed(context, '/settingPage'),
                ),
                ListTile(
                  leading: Icon(
                    Icons.contact_mail,
                    color: Theme.of(context).textTheme.bodyText2!.color,
                  ),
                  title: Text(
                    'Contact Us',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText2!.color),
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactScreen(),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.feedback,
                    color: Theme.of(context).textTheme.bodyText2!.color,
                  ),
                  title: Text(
                    'Give Feedback',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText2!.color),
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FeedbackFormPage(),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.description,
                    color: Theme.of(context).textTheme.bodyText2!.color,
                  ),
                  title: Text(
                    'Policies',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText2!.color),
                  ),
                  onTap: () => null,
                ),
                ListTile(
                    title: Text(
                      'Sign-Out',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText2!.color),
                    ),
                    leading: Icon(
                      Icons.logout,
                      color: Theme.of(context).textTheme.bodyText2!.color,
                    ),
                    onTap: () {
                      context.read(authControllerProvider.notifier).signOut();
                    }),
              ],
            ),
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
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
