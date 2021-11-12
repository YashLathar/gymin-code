import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/widgets/toast_msg.dart';
import 'package:gym_in/widgets/topbar.dart';
import 'package:pedometer/pedometer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ActivityPage extends StatefulWidget {
  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  // ignore: unused_field
  String _status = '?', _steps = '?';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    print("working step counting");
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen((value) => print("working"))
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream
        .listen(
          onStepCount,
          onError: onStepCountError,
          onDone: _onDone,
          cancelOnError: true,
        )
        .onError(onStepCountError);

    if (!mounted) return;
  }

  void _onDone() => print("Finished pedometer tracking");

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // if (authControllerState != null) {
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                TopBar(),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 40.0, right: 10, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_back_ios_rounded),
                      ),
                      Row(
                        children: [
                          Text(
                            DateTime.now().day.toString() + "-",
                            style: kSmallContentStyle.copyWith(
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            DateTime.now().month.toString(),
                            style: kSmallContentStyle.copyWith(
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    ],
                  ),
                )
              ],
            ),
            // Container(
            //   height: 350,
            //   child: Stack(
            //     children: [
            //       Container(
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.only(
            //               bottomLeft: Radius.circular(100),
            //               bottomRight: Radius.circular(100)),
            //           gradient: LinearGradient(
            //             colors: [
            //               Colors.blue,
            //               Colors.purple,
            //             ],
            //             begin: Alignment.topLeft,
            //             end: Alignment.bottomRight,
            //           ),
            //         ),
            //         height: 300,
            //         child: Column(
            //           children: [
            //             Padding(
            //               padding: const EdgeInsets.only(top: 40),
            //               child: Row(
            //                 children: [
            //                   IconButton(
            //                     onPressed: () {},
            //                     icon: Icon(
            //                       Icons.arrow_back_ios,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             CircleAvatar(
            //               radius: 50,
            //               backgroundImage: NetworkImage(
            //                 // authControllerState.photoURL ??
            //                 "https://fanfest.com/wp-content/uploads/2021/02/Loki.jpg",
            //               ),
            //             ),
            //             Text(
            //               // authControllerState.displayName ??
            //               'UserName',
            //               style:
            //                   kHeadingTextStyle.copyWith(color: Colors.white),
            //             ),
            //           ],
            //         ),
            //       ),
            //       Container(
            //         child: Transform.translate(
            //           offset: Offset(0, 250),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               InfoCircle(
            //                 colors: [Colors.blue, Colors.deepPurple],
            //                 child: Column(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [
            //                     Text("5'7\"", style: kHeadingTextStyle),
            //                     Text('Height', style: kSmallContentStyle),
            //                   ],
            //                 ),
            //               ),
            //               Transform.scale(
            //                 scale: 1.2,
            //                 origin: Offset(0, -100),
            //                 child: InfoCircle(
            //                   child: Column(
            //                     mainAxisAlignment: MainAxisAlignment.center,
            //                     children: [
            //                       Text(
            //                         '23',
            //                         style: kHeadingTextStyle.copyWith(
            //                             color: Colors.white),
            //                       ),
            //                       Text(
            //                         'Age',
            //                         style: TextStyle(
            //                             color: Colors.white, fontSize: 15),
            //                       ),
            //                     ],
            //                   ),
            //                   colors: [
            //                     Colors.cyan,
            //                     Colors.lightBlue,
            //                     Colors.blue
            //                   ],
            //                 ),
            //               ),
            //               InfoCircle(
            //                 colors: [Colors.blue, Colors.deepPurple],
            //                 child: Column(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [
            //                     Text('85', style: kHeadingTextStyle),
            //                     Text('Weight', style: kSmallContentStyle),
            //                   ],
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Expanded(
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                margin: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 40,
                ),
                child: ListView(
                  children: [
                    // ActivityCard(
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Padding(
                    //         padding: EdgeInsets.only(left: 10),
                    //         child: Row(
                    //           children: [
                    //             Icon(Icons.directions_run,
                    //                 color: Colors.cyan, size: 50),
                    //             SizedBox(width: 10),
                    //             Column(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceEvenly,
                    //               children: [
                    //                 Text(
                    //                   'Walk',
                    //                   style: kSmallContentStyle.copyWith(
                    //                       color: Theme.of(context)
                    //                           .textTheme
                    //                           .bodyText2!
                    //                           .color),
                    //                 ),
                    //                 Text(_steps.toString(),
                    //                     style:
                    //                         kLoginPageHeadingTextStyle.copyWith(
                    //                             fontFamily: 'Montserrat',
                    //                             fontWeight: FontWeight.w600,
                    //                             color: Theme.of(context)
                    //                                 .textTheme
                    //                                 .bodyText2!
                    //                                 .color)),
                    //                 Text('Steps', style: kSmallContentStyle),
                    //               ],
                    //             ),
                    //             SizedBox(
                    //               width: 15,
                    //             ),
                    //             Column(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceEvenly,
                    //               children: [
                    //                 Text('Status', style: kSmallContentStyle),
                    //                 Icon(
                    //                   _status == 'walking'
                    //                       ? Icons.directions_walk
                    //                       : _status == 'stopped'
                    //                           ? Icons.accessibility_new
                    //                           : Icons.error,
                    //                   size: 60,
                    //                   color: Theme.of(context)
                    //                       .textTheme
                    //                       .bodyText2!
                    //                       .color,
                    //                 ),
                    //                 Text(
                    //                   _status,
                    //                   style: _status == 'walking' ||
                    //                           _status == 'stopped'
                    //                       ? TextStyle(fontSize: 30)
                    //                       : TextStyle(
                    //                           fontSize: 20,
                    //                           color: Theme.of(context)
                    //                               .textTheme
                    //                               .bodyText2!
                    //                               .color,
                    //                         ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       Icon(Icons.bar_chart,
                    //           size: 100, color: Colors.lightBlue)
                    //     ],
                    //   ),
                    // ),
                    // ActivityCard(
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Padding(
                    //         padding: EdgeInsets.only(left: 10),
                    //         child: Row(
                    //           children: [
                    //             Icon(FontAwesomeIcons.fire,
                    //                 color: Colors.cyan, size: 50),
                    //             SizedBox(width: 10),
                    //             Column(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceEvenly,
                    //               children: [
                    //                 Text('Kcal.', style: kSmallContentStyle),
                    //                 Text(
                    //                   '8.6k',
                    //                   style:
                    //                       kLoginPageHeadingTextStyle.copyWith(
                    //                     fontFamily: 'Montserrat',
                    //                     fontWeight: FontWeight.w600,
                    //                     color: Theme.of(context)
                    //                         .textTheme
                    //                         .bodyText2!
                    //                         .color,
                    //                   ),
                    //                 ),
                    //                 Text('Calories Burned',
                    //                     style: kSmallContentStyle),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: EdgeInsets.only(right: 20),
                    //         child: Icon(
                    //           FontAwesomeIcons.chartLine,
                    //           size: 70,
                    //           color: Colors.orange,
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    //////
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      height: 340,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                                    'Gym',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20.0,
                                                        color:
                                                            Colors.grey[600]),
                                                  ),
                                                  Icon(FontAwesomeIcons.clock)
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 8, top: 15),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "0",
                                              style:
                                                  kSmallContentStyle.copyWith(
                                                color: Colors.black,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 8),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "minutes",
                                              style:
                                                  kSmallContentStyle.copyWith(
                                                color: Colors.grey[600],
                                                fontSize: 18,
                                              ),
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
                                  flex: 2,
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
                                                    'Walk',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20.0,
                                                        color:
                                                            Colors.grey[600]),
                                                  ),
                                                  Icon(FontAwesomeIcons.walking)
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(top: 15),
                                            child: CircularPercentIndicator(
                                              radius: 140,
                                              lineWidth: 9.0,
                                              percent: 0.6,
                                              center: Text(
                                                "5275\nsteps",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              progressColor: Colors.redAccent,
                                            ),
                                          )
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
                                  flex: 2,
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
                                                    'Calories',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20.0,
                                                        color:
                                                            Colors.grey[600]),
                                                  ),
                                                  Icon(FontAwesomeIcons
                                                      .chartLine)
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(top: 15),
                                            child: CircularPercentIndicator(
                                              radius: 140,
                                              lineWidth: 9.0,
                                              percent: 0.4,
                                              center: Text(
                                                "345\nkcal",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              progressColor: Colors.redAccent,
                                            ),
                                          )
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
                                                    'Sleep',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 22.0,
                                                        color:
                                                            Colors.grey[600]),
                                                  ),
                                                  Icon(FontAwesomeIcons.moon),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 8, top: 15),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "06:15 AM",
                                              style:
                                                  kSmallContentStyle.copyWith(
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
                                                  "reminder",
                                                  style: kSmallContentStyle
                                                      .copyWith(
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20, left: 20),
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20)
                      ),
                    )
                    // Expanded(
                    //   child: ActivityCard(
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //       children: [
                    //         Icon(Icons.local_drink,
                    //             color: Colors.cyan, size: 50),
                    //         Column(
                    //           mainAxisAlignment:
                    //               MainAxisAlignment.spaceEvenly,
                    //           children: [
                    //             Text('Water', style: kSmallContentStyle),
                    //             Text('6',
                    //                 style:
                    //                     kLoginPageHeadingTextStyle.copyWith(
                    //                         fontFamily: 'Montserrat',
                    //                         fontWeight: FontWeight.w600,
                    //                         color: Theme.of(context)
                    //                             .textTheme
                    //                             .bodyText2!
                    //                             .color)),
                    //             Text('Glasses', style: kSmallContentStyle),
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    ,
                    SizedBox(width: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // else {
  // return LoginPage();
  // }
  // }
}
