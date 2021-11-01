import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/pages/login_page.dart';
import 'package:gym_in/widgets/activity_card.dart';
import 'package:gym_in/widgets/info_circle.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ActivityPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final authControllerState = useProvider(authControllerProvider);
    Size size = MediaQuery.of(context).size;
    if (authControllerState != null) {
      return Scaffold(
        body: Container(
          width: size.width,
          child: Column(
            children: [
              Container(
                height: 350,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(100),
                            bottomRight: Radius.circular(100)),
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue,
                            Colors.purple,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      height: 300,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                              authControllerState.photoURL ??
                                  "https://fanfest.com/wp-content/uploads/2021/02/Loki.jpg",
                            ),
                          ),
                          Text(
                            authControllerState.displayName ?? 'UserName',
                            style:
                                kHeadingTextStyle.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Transform.translate(
                        offset: Offset(0, 250),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InfoCircle(
                              colors: [Colors.blue, Colors.deepPurple],
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("5'7\"", style: kHeadingTextStyle),
                                  Text('Height', style: kSmallContentStyle),
                                ],
                              ),
                            ),
                            Transform.scale(
                              scale: 1.2,
                              origin: Offset(0, -100),
                              child: InfoCircle(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '23',
                                      style: kHeadingTextStyle.copyWith(
                                          color: Colors.white),
                                    ),
                                    Text(
                                      'Age',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ],
                                ),
                                colors: [
                                  Colors.cyan,
                                  Colors.lightBlue,
                                  Colors.blue
                                ],
                              ),
                            ),
                            InfoCircle(
                              colors: [Colors.blue, Colors.deepPurple],
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('85', style: kHeadingTextStyle),
                                  Text('Weight', style: kSmallContentStyle),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 40,
                  ),
                  child: ListView(
                    children: [
                      ActivityCard(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Icon(Icons.directions_run,
                                      color: Colors.cyan, size: 50),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('Walk', style: kSmallContentStyle),
                                      Text('4023',
                                          style: kLoginPageHeadingTextStyle
                                              .copyWith(
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w600)),
                                      Text('Steps', style: kSmallContentStyle),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.bar_chart,
                                size: 100, color: Colors.lightBlue)
                          ],
                        ),
                      ),
                      ActivityCard(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Icon(FontAwesomeIcons.fire,
                                      color: Colors.cyan, size: 50),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('Kcal.', style: kSmallContentStyle),
                                      Text('8.6k',
                                          style: kLoginPageHeadingTextStyle
                                              .copyWith(
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w600)),
                                      Text('Calories Burned',
                                          style: kSmallContentStyle),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Icon(
                                FontAwesomeIcons.chartLine,
                                size: 70,
                                color: Colors.orange,
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ActivityCard(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.local_drink,
                                      color: Colors.cyan, size: 50),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('Water', style: kSmallContentStyle),
                                      Text('6',
                                          style: kLoginPageHeadingTextStyle
                                              .copyWith(
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w600)),
                                      Text('Glasses',
                                          style: kSmallContentStyle),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                              child: ActivityCard(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(FontAwesomeIcons.bed,
                                    color: Colors.cyan, size: 50),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('Sleep', style: kSmallContentStyle),
                                    Text('7.5',
                                        style:
                                            kLoginPageHeadingTextStyle.copyWith(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w600)),
                                    Text('Hours', style: kSmallContentStyle),
                                  ],
                                ),
                              ],
                            ),
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return LoginPage();
    }
  }
}
