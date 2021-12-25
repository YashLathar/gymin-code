import 'package:flutter/material.dart';

class GymOwnerPage extends StatefulWidget {
  const GymOwnerPage({Key? key}) : super(key: key);

  @override
  _GymOwnerPageState createState() => _GymOwnerPageState();
}


class _GymOwnerPageState extends State<GymOwnerPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Percent indicator'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.file_download),
              onPressed: () {
              },
            )
          ],
        ),
        body: Column(
          children: [
          ],
        ),
    );
  }
}
