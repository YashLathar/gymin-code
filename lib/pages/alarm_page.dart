import 'package:flutter/material.dart';
import 'package:gym_in/models/radial_progress.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({ Key? key }) : super(key: key);

  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RadialProgress(),
    );
  }
}