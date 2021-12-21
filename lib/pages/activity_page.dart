import 'dart:io';
import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/pages/stopwatch_page.dart';
import 'package:gym_in/widgets/topbar.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class ActivityPage extends StatefulWidget {
  final double goalCompleted = 0.7;
  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage>
    with SingleTickerProviderStateMixin {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = 'unknown';
  int _steps = 0;
  double calories = 0;
  late Stream<ActivityEvent> activityStream;
  ActivityEvent latestActivity = ActivityEvent.empty();
  final List<ActivityEvent> _events = [];
  ActivityRecognition activityRecognition = ActivityRecognition.instance;
  final _isHours = true;
  final Duration fadeInDuration = Duration(milliseconds: 500);
  double progressDegrees = 0;
  late AnimationController _radialProgressAnimationController;
  late Animation<double> _progressAnimation;
  final Duration fillDuration = Duration(seconds: 2);

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
    onChange: (value) => print('onChange $value'),
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
  );

  var count = 0;

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.rawTime.listen((value) =>
        print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
    _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
    _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
    _stopWatchTimer.records.listen((value) => print('records $value'));
    _radialProgressAnimationController =
        AnimationController(vsync: this, duration: fillDuration);
    _progressAnimation = Tween(begin: 0.0, end: 360.0).animate(CurvedAnimation(
        parent: _radialProgressAnimationController, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {
          progressDegrees = widget.goalCompleted * _progressAnimation.value;
        });
      });

    _radialProgressAnimationController.forward();

    initPlatformState();
    _init();

    /// Can be set preset time. This case is "00:01.23".
    // _stopWatchTimer.setPresetTime(mSec: 1234);
  }

  @override
  void dispose() async {
    await _stopWatchTimer.dispose();
    _radialProgressAnimationController.dispose();
    super.dispose();
  }

  void _init() async {
    /// Android requires explicitly asking permission
    if (Platform.isAndroid) {
      if (await Permission.activityRecognition.request().isGranted) {
        _startTracking();
      }
    }

    /// iOS does not
    else {
      _startTracking();
    }
  }

  void _startTracking() {
    activityStream =
        activityRecognition.startStream(runForegroundService: true);
    activityStream.listen(onData);
  }

  void onData(ActivityEvent activityEvent) {
    // ignore: avoid_print
    print(activityEvent.toString());
    setState(() {
      _events.add(activityEvent);
      latestActivity = activityEvent;
    });
  }

  void onStepCount(StepCount event) {
    print(event);
    //  calories = event.steps*0.6;
    setState(() {
      _steps = event.steps;
      calories = _steps * 0.063;
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
      _status = '404 error';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 404;
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final entry = _events;

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
                          Text(
                            "-2021",
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
            Expanded(
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: ListView(
                  children: [
                    // GestureDetector(
                    //   onTap: () {
                    //     showDialog(
                    //         context: context,
                    //         builder: (context) {
                    //           return SimpleDialog(
                    //             children: [
                    //               Center(
                    //                 child:
                    // ListView.builder(
                    //   itemCount: _events.length,
                    //   reverse: true,
                    //   itemBuilder: (BuildContext context, int idx) {
                    //     final entry = _events[idx];
                    //     return ListTile(
                    //       leading: Text(
                    //         entry.timeStamp.toString().substring(0, 19),
                    //       ),
                    //       trailing: Text(entry.type.toString().split('.').last),
                    //     );
                    //   },
                    // ),
                    //                   Container(
                    //                 height: size.width,
                    //                 child: Text(
                    //                   entry.toString(),
                    //                   style: TextStyle(
                    //                       color: Theme.of(context)
                    //                           .scaffoldBackgroundColor),
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         );
                    //       });
                    // },
                    // child: Container(
                    //     margin: EdgeInsets.symmetric(horizontal: 15),
                    //     height: 80,
                    //     width: 20,
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.only(
                    //           topLeft: Radius.circular(20),
                    //           topRight: Radius.circular(20),
                    //           bottomLeft: Radius.circular(20),
                    //           bottomRight: Radius.circular(20),
                    //         ),
                    //         color: Colors.redAccent[400]),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //       children: [
                    //         _status == 'walking'
                    //             ? Image.asset("assets/img/animation_50.gif")
                    //             : _status == 'stopped'
                    //                 ? Image.asset("assets/img/start_50.gif")
                    //                 : Image.asset("assets/img/error_50.gif"),
                    //         _status == 'walking'
                    //             ? Text("Walking", style: kSmallContentStyle)
                    //             : _status == 'stopped'
                    //                 ? Text("Start Walking",
                    //                     style: kSmallContentStyle)
                    //                 : Text("404 Error",
                    //                     style: kSmallContentStyle),
                    //       ],
                    //     ),
                    //    ),
                    // ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      height: 448,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Flexible(
                                  flex: 1,
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
                                                      color: Colors.grey[600]),
                                                ),
                                                Icon(FontAwesomeIcons.clock)
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.only(left: 8, top: 15),
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              Text(
                                                "0",
                                                style:
                                                    kSmallContentStyle.copyWith(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 8),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Hours",
                                            style: kSmallContentStyle.copyWith(
                                              color: Colors.grey[600],
                                              fontSize: 18,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Flexible(
                                  flex: 2,
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
                                                      color: Colors.grey[600]),
                                                ),
                                                Icon(FontAwesomeIcons.walking)
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        CustomPaint(
                                          child: Container(
                                            height: 150,
                                            width: 130,
                                            child: AnimatedOpacity(
                                              opacity: progressDegrees > 30
                                                  ? 1.0
                                                  : 0.0,
                                              duration: fadeInDuration,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    _steps.toString(),
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Text(
                                                    "steps",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          painter:
                                              RadialPainter(progressDegrees),
                                        ),
                                        // Container(
                                        //   padding: EdgeInsets.only(top: 15),
                                        //   child: CircularPercentIndicator(
                                        //     radius: 140,
                                        //     lineWidth: 9.0,
                                        //     percent: 0.6,
                                        //     center: Column(
                                        //       mainAxisAlignment:
                                        //           MainAxisAlignment.center,
                                        //       children: [
                                        //         Text(
                                        //           _steps.toString(),
                                        //           style: TextStyle(
                                        //             color: Colors.black,
                                        //           ),
                                        //         ),
                                        //         Text(
                                        //           "steps",
                                        //           style: TextStyle(
                                        //             color: Colors.black,
                                        //           ),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //     progressColor: Colors.redAccent,
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Flexible(
                                  flex: 1,
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
                                                top: 5, right: 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Water',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20.0,
                                                      color: Colors.grey[600]),
                                                ),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(Icons.add))
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.only(left: 8, top: 0),
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              Text(
                                                "0",
                                                style:
                                                    kSmallContentStyle.copyWith(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 8),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Glasses",
                                            style: kSmallContentStyle.copyWith(
                                              color: Colors.grey[600],
                                              fontSize: 18,
                                            ),
                                          ),
                                        )
                                      ],
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
                                                      color: Colors.grey[600]),
                                                ),
                                                Icon(FontAwesomeIcons.chartLine)
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        CustomPaint(
                                          child: Container(
                                            height: 150,
                                            width: 130,
                                            child: AnimatedOpacity(
                                              opacity: progressDegrees > 30
                                                  ? 1.0
                                                  : 0.0,
                                              duration: fadeInDuration,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    calories.toString(),
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Text(
                                                    "calories",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          painter:
                                              RadialPainter(progressDegrees),
                                        )
                                        // Container(
                                        //   padding: EdgeInsets.only(top: 15),
                                        //   child: CircularPercentIndicator(
                                        //     radius: 140,
                                        //     lineWidth: 9.0,
                                        //     percent: 0.4,
                                        //     center: Column(
                                        //       mainAxisAlignment:
                                        //           MainAxisAlignment.center,
                                        //       children: [
                                        //         Text(
                                        //           calories.toString(),
                                        //           style: TextStyle(
                                        //             color: Colors.black,
                                        //           ),
                                        //         ),
                                        //         Text(
                                        //           "calories",
                                        //           style: TextStyle(
                                        //             color: Colors.black,
                                        //           ),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //     progressColor: Colors.redAccent,
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Flexible(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => StopWatchPage(),
                                        ),
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
                                                  top: 0, right: 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  TextButton(
                                                    child: Text(
                                                      'Timer',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 22.0,
                                                          color:
                                                              Colors.grey[600]),
                                                    ),
                                                    onPressed: () async {
                                                      _stopWatchTimer.onExecute
                                                          .add(StopWatchExecute
                                                              .start);
                                                    },
                                                  ),
                                                  // IconButton(
                                                  //   icon: Icon(Icons.play_arrow,
                                                  //       size: 10),
                                                  //   onPressed: () async {
                                                  //     _stopWatchTimer.onExecute
                                                  //         .add(StopWatchExecute
                                                  //             .start);
                                                  //   },
                                                  // ),
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.pause,
                                                    ),
                                                    onPressed: () async {
                                                      _stopWatchTimer.onExecute
                                                          .add(StopWatchExecute
                                                              .stop);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 15, top: 0),
                                            alignment: Alignment.centerLeft,
                                            child: StreamBuilder<int>(
                                              stream: _stopWatchTimer.rawTime,
                                              initialData:
                                                  _stopWatchTimer.rawTime.value,
                                              builder: (context, snap) {
                                                final value = snap.data!;
                                                final displayTime =
                                                    StopWatchTimer
                                                        .getDisplayTime(value,
                                                            hours: _isHours);
                                                return Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      child: Text(
                                                        displayTime,
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 18,
                                                            fontFamily:
                                                                'Helvetica',
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      child: Text(
                                                        value.toString(),
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontFamily:
                                                                'Helvetica',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                            // Row(
                                            //   children: [
                                            //     Icon(
                                            //       Icons.directions_walk,
                                            //       size: 18,
                                            //     ),
                                            //     SizedBox(width: 8),
                                            //     Text(
                                            //       _status,
                                            //       style: TextStyle(
                                            //           fontSize: 20,
                                            //           color: Colors.black),
                                            //     ),
                                            //   ],
                                            // ),
                                          ),
                                          // Container(
                                          //   padding: EdgeInsets.only(left: 8),
                                          //   alignment: Alignment.centerLeft,
                                          //   child: Row(
                                          //     children: [
                                          //       Text(
                                          //         "reminder",
                                          //         style:
                                          //             kSmallContentStyle.copyWith(
                                          //           color: Colors.grey[300],
                                          //           fontSize: 15,
                                          //         ),
                                          //       ),
                                          //       Icon(
                                          //         Icons.alarm,
                                          //         color: Colors.grey[300],
                                          //         size: 18,
                                          //       )
                                          //     ],
                                          //   ),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Flexible(
                                  flex: 1,
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
                                                      color: Colors.grey[600]),
                                                ),
                                                Icon(FontAwesomeIcons.moon),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.only(left: 8, top: 15),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "10:15 PM",
                                            style: kSmallContentStyle.copyWith(
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
                                                style:
                                                    kSmallContentStyle.copyWith(
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ), //listview continues

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

class RadialPainter extends CustomPainter {
  double progressInDegrees;

  RadialPainter(this.progressInDegrees);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black12
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, size.width / 2, paint);

    Paint progressPaint = Paint()
      ..shader = LinearGradient(
              colors: [Colors.red, Colors.purple, Colors.purpleAccent])
          .createShader(Rect.fromCircle(center: center, radius: size.width / 2))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: size.width / 2),
        math.radians(-90),
        math.radians(progressInDegrees),
        false,
        progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}


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