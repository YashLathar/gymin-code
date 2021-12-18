import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_in/constants.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class StopWatchPage extends HookWidget {
  final _isHours = true;
  final _scrollController = ScrollController();

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
    onChange: (value) => print('onChange $value'),
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
  );
  final StopWatchTimer _stopWatchTimerdown = StopWatchTimer(
    mode: StopWatchMode.countDown,
    presetMillisecond: StopWatchTimer.getMilliSecFromSecond(3),
    onChange: (value) => print('onChange $value'),
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
    onEnded: () {
      print('onEnded');
    },
  );

  // @override
  // void initState() {
  //   super.initState();
  //   _stopWatchTimer.rawTime.listen((value) =>
  //       print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
  //   _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
  //   _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
  //   _stopWatchTimer.records.listen((value) => print('records $value'));
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _stopWatchTimer.rawTime.listen((value) =>
  //       print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
  //   _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
  //   _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
  //   _stopWatchTimer.records.listen((value) => print('records $value'));
  //   /// Can be set preset time. This case is "00:01.23".
  //   // _stopWatchTimer.setPresetTime(mSec: 1234);
  // }

  // @override
  // void dispose() async {
  //   super.dispose();
  //   await _stopWatchTimer.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 2);
    final size = MediaQuery.of(context).size;

    useEffect(() {
      _stopWatchTimer.rawTime.listen((value) =>
          print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
      _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
      _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
      _stopWatchTimer.records.listen((value) => print('records $value'));

      _stopWatchTimer.rawTime.listen((value) =>
          print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
      _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
      _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
      _stopWatchTimer.records.listen((value) => print('records $value'));
      return () {
        _stopWatchTimer.dispose();
      };
    });

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(
                          width: 2.0, color: Theme.of(context).backgroundColor),
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Theme.of(context).textTheme.bodyText2!.color,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Timer",
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
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.timer,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: size.width,
              height: 75,
              child: TabBar(
                controller: tabController,
                indicatorColor: Colors.redAccent,
                tabs: [
                  Tab(
                    child: Text(
                      "Time",
                      style: TextStyle(
                          fontSize: 22,
                          color: Theme.of(context).textTheme.bodyText2!.color),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "StopWatch",
                      style: TextStyle(
                          fontSize: 22,
                          color: Theme.of(context).textTheme.bodyText2!.color),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  ListView(
                    children: [
                      Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              /// Display stop watch time
                              Padding(
                                padding: const EdgeInsets.only(bottom: 0),
                                child: StreamBuilder<int>(
                                  stream: _stopWatchTimer.rawTime,
                                  initialData: _stopWatchTimer.rawTime.value,
                                  builder: (context, snap) {
                                    final value = snap.data!;
                                    final displayTime =
                                        StopWatchTimer.getDisplayTime(value,
                                            hours: _isHours);
                                    return Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Text(
                                            displayTime,
                                            style: const TextStyle(
                                                fontSize: 40,
                                                fontFamily: 'Helvetica',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Text(
                                            value.toString(),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Helvetica',
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),

                              /// Display every minute.
                              Padding(
                                padding: const EdgeInsets.only(bottom: 0),
                                child: StreamBuilder<int>(
                                  stream: _stopWatchTimer.minuteTime,
                                  initialData: _stopWatchTimer.minuteTime.value,
                                  builder: (context, snap) {
                                    final value = snap.data;
                                    print('Listen every minute. $value');
                                    return Column(
                                      children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 4),
                                                  child: Text(
                                                    'minute',
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                      fontFamily: 'Helvetica',
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 4),
                                                  child: Text(
                                                    value.toString(),
                                                    style: const TextStyle(
                                                        fontSize: 30,
                                                        fontFamily: 'Helvetica',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ],
                                    );
                                  },
                                ),
                              ),

                              /// Display every second.
                              Padding(
                                padding: const EdgeInsets.only(bottom: 0),
                                child: StreamBuilder<int>(
                                  stream: _stopWatchTimer.secondTime,
                                  initialData: _stopWatchTimer.secondTime.value,
                                  builder: (context, snap) {
                                    final value = snap.data;
                                    print('Listen every second. $value');
                                    return Column(
                                      children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 4),
                                                  child: Text(
                                                    'second',
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                      fontFamily: 'Helvetica',
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 4),
                                                  child: Text(
                                                    value.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 30,
                                                      fontFamily: 'Helvetica',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ],
                                    );
                                  },
                                ),
                              ),

                              /// Lap time.
                              Container(
                                height: 120,
                                margin: const EdgeInsets.all(8),
                                child: StreamBuilder<List<StopWatchRecord>>(
                                  stream: _stopWatchTimer.records,
                                  initialData: _stopWatchTimer.records.value,
                                  builder: (context, snap) {
                                    final value = snap.data!;
                                    if (value.isEmpty) {
                                      return Container();
                                    }
                                    Future.delayed(
                                        const Duration(milliseconds: 100), () {
                                      _scrollController.animateTo(
                                          _scrollController
                                              .position.maxScrollExtent,
                                          duration:
                                              const Duration(milliseconds: 200),
                                          curve: Curves.easeOut);
                                    });
                                    print('Listen records. $value');
                                    return ListView.builder(
                                      controller: _scrollController,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final data = value[index];
                                        return Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Text(
                                                '${index + 1} ${data.displayTime}',
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontFamily: 'Helvetica',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            const Divider(
                                              height: 1,
                                            )
                                          ],
                                        );
                                      },
                                      itemCount: value.length,
                                    );
                                  },
                                ),
                              ),

                              /// Button
                              Padding(
                                padding: const EdgeInsets.all(2),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            // ignore: deprecated_member_use
                                            child: RaisedButton(
                                              padding: const EdgeInsets.all(4),
                                              color: Colors.lightBlue,
                                              shape: const StadiumBorder(),
                                              onPressed: () async {
                                                _stopWatchTimer.onExecute.add(
                                                    StopWatchExecute.start);
                                              },
                                              child: const Text(
                                                'Start',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            // ignore: deprecated_member_use
                                            child: RaisedButton(
                                              padding: const EdgeInsets.all(4),
                                              color: Colors.green,
                                              shape: const StadiumBorder(),
                                              onPressed: () async {
                                                _stopWatchTimer.onExecute
                                                    .add(StopWatchExecute.stop);
                                              },
                                              child: const Text(
                                                'Stop',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            // ignore: deprecated_member_use
                                            child: RaisedButton(
                                              padding: const EdgeInsets.all(4),
                                              color: Colors.red,
                                              shape: const StadiumBorder(),
                                              onPressed: () async {
                                                _stopWatchTimer.onExecute.add(
                                                    StopWatchExecute.reset);
                                              },
                                              child: const Text(
                                                'Reset',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(0)
                                                .copyWith(right: 8),
                                            // ignore: deprecated_member_use
                                            child: RaisedButton(
                                              padding: const EdgeInsets.all(4),
                                              color: Colors.deepPurpleAccent,
                                              shape: const StadiumBorder(),
                                              onPressed: () async {
                                                _stopWatchTimer.onExecute
                                                    .add(StopWatchExecute.lap);
                                              },
                                              child: const Text(
                                                'Lap',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListView(
                    children: [
                      Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              /// Display stop watch time
                              Padding(
                                padding: const EdgeInsets.only(bottom: 0),
                                child: StreamBuilder<int>(
                                  stream: _stopWatchTimerdown.rawTime,
                                  initialData: _stopWatchTimerdown.rawTime.value,
                                  builder: (context, snap) {
                                    final value = snap.data!;
                                    final displayTime =
                                        StopWatchTimer.getDisplayTime(value,
                                            hours: _isHours);
                                    return Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Text(
                                            displayTime,
                                            style: const TextStyle(
                                                fontSize: 40,
                                                fontFamily: 'Helvetica',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Text(
                                            value.toString(),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Helvetica',
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),

                              /// Display every minute.
                              Padding(
                                padding: const EdgeInsets.only(bottom: 0),
                                child: StreamBuilder<int>(
                                  stream: _stopWatchTimerdown.minuteTime,
                                  initialData: _stopWatchTimerdown.minuteTime.value,
                                  builder: (context, snap) {
                                    final value = snap.data;
                                    print('Listen every minute. $value');
                                    return Column(
                                      children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 4),
                                                  child: Text(
                                                    'minute',
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                      fontFamily: 'Helvetica',
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 4),
                                                  child: Text(
                                                    value.toString(),
                                                    style: const TextStyle(
                                                        fontSize: 30,
                                                        fontFamily: 'Helvetica',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ],
                                    );
                                  },
                                ),
                              ),

                              /// Display every second.
                              Padding(
                                padding: const EdgeInsets.only(bottom: 0),
                                child: StreamBuilder<int>(
                                  stream: _stopWatchTimerdown.secondTime,
                                  initialData: _stopWatchTimerdown.secondTime.value,
                                  builder: (context, snap) {
                                    final value = snap.data;
                                    print('Listen every second. $value');
                                    return Column(
                                      children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 4),
                                                  child: Text(
                                                    'second',
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                      fontFamily: 'Helvetica',
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 4),
                                                  child: Text(
                                                    value.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 30,
                                                      fontFamily: 'Helvetica',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ],
                                    );
                                  },
                                ),
                              ),

                              /// Lap time.
                              Container(
                                height: 120,
                                margin: const EdgeInsets.all(8),
                                child: StreamBuilder<List<StopWatchRecord>>(
                                  stream: _stopWatchTimerdown.records,
                                  initialData: _stopWatchTimerdown.records.value,
                                  builder: (context, snap) {
                                    final value = snap.data!;
                                    if (value.isEmpty) {
                                      return Container();
                                    }
                                    Future.delayed(
                                        const Duration(milliseconds: 100), () {
                                      _scrollController.animateTo(
                                          _scrollController
                                              .position.maxScrollExtent,
                                          duration:
                                              const Duration(milliseconds: 200),
                                          curve: Curves.easeOut);
                                    });
                                    print('Listen records. $value');
                                    return ListView.builder(
                                      controller: _scrollController,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final data = value[index];
                                        return Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Text(
                                                '${index + 1} ${data.displayTime}',
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontFamily: 'Helvetica',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            const Divider(
                                              height: 1,
                                            )
                                          ],
                                        );
                                      },
                                      itemCount: value.length,
                                    );
                                  },
                                ),
                              ),

                              /// Button
                              Padding(
                                padding: const EdgeInsets.all(2),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.lightBlue,
                                                onPrimary: Colors.white,
                                                shape: const StadiumBorder(),
                                              ),
                                              onPressed: () async {
                                                _stopWatchTimerdown.onExecute.add(
                                                    StopWatchExecute.start);
                                              },
                                              child: const Text(
                                                'Start',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.green,
                                                onPrimary: Colors.white,
                                                shape: const StadiumBorder(),
                                              ),
                                              onPressed: () async {
                                                _stopWatchTimerdown.onExecute
                                                    .add(StopWatchExecute.stop);
                                              },
                                              child: const Text(
                                                'Stop',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.red,
                                                onPrimary: Colors.white,
                                                shape: const StadiumBorder(),
                                              ),
                                              onPressed: () async {
                                                _stopWatchTimerdown.onExecute.add(
                                                    StopWatchExecute.reset);
                                              },
                                              child: const Text(
                                                'Reset',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(0)
                                                .copyWith(right: 8),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary:
                                                    Colors.deepPurpleAccent,
                                                onPrimary: Colors.white,
                                                shape: const StadiumBorder(),
                                              ),
                                              onPressed: () async {
                                                _stopWatchTimerdown.onExecute
                                                    .add(StopWatchExecute.lap);
                                              },
                                              child: const Text(
                                                'Lap',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.pinkAccent,
                                                onPrimary: Colors.white,
                                                shape: const StadiumBorder(),
                                              ),
                                              onPressed: () async {
                                                _stopWatchTimerdown
                                                    .setPresetHoursTime(1);
                                              },
                                              child: const Text(
                                                'Set Hours',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.pinkAccent,
                                                onPrimary: Colors.white,
                                                shape: const StadiumBorder(),
                                              ),
                                              onPressed: () async {
                                                _stopWatchTimerdown
                                                    .setPresetMinuteTime(5);
                                              },
                                              child: const Text(
                                                'Set Minute',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.pinkAccent,
                                                onPrimary: Colors.white,
                                                shape: const StadiumBorder(),
                                              ),
                                              onPressed: () async {
                                                _stopWatchTimerdown
                                                    .setPresetSecondTime(10);
                                              },
                                              child: const Text(
                                                'Set Second',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(
                                    //       horizontal: 4),
                                    //   child: ElevatedButton(
                                    //     style: ElevatedButton.styleFrom(
                                    //       primary: Colors.pinkAccent,
                                    //       onPrimary: Colors.white,
                                    //       shape: const StadiumBorder(),
                                    //     ),
                                    //     onPressed: () async {
                                    //       _stopWatchTimerdown.setPresetTime(
                                    //           mSec: 3599 * 1000);
                                    //     },
                                    //     child: const Text(
                                    //       'Set PresetTime',
                                    //       style: TextStyle(color: Colors.white),
                                    //     ),
                                    //   ),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.pinkAccent,
                                          onPrimary: Colors.white,
                                          shape: const StadiumBorder(),
                                        ),
                                        onPressed: () async {
                                          _stopWatchTimerdown.clearPresetTime();
                                        },
                                        child: const Text(
                                          'Clear PresetTime',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}