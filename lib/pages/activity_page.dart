import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/widgets/activity_card.dart';

class ActivityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                                  )),
                            ],
                          ),
                        ),
                        ClipOval(
                          child: Image.network(
                            "https://img.icons8.com/cute-clipart/2x/user-male.png",
                            fit: BoxFit.cover,
                            width: 90,
                            height: 90,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ),
                        Text('Yash Lathar',
                            style:
                                kHeadingTextStyle.copyWith(color: Colors.white))
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
                                Text('21', style: kHeadingTextStyle),
                                Text('Age', style: kSmallContentStyle),
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
                                    '7',
                                    style: kHeadingTextStyle.copyWith(
                                        color: Colors.white),
                                  ),
                                  Text(
                                    'Activities',
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
                                        style:
                                            kLoginPageHeadingTextStyle.copyWith(
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
                                        style:
                                            kLoginPageHeadingTextStyle.copyWith(
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.local_drink,
                                    color: Colors.cyan, size: 50),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('Water', style: kSmallContentStyle),
                                    Text('6',
                                        style:
                                            kLoginPageHeadingTextStyle.copyWith(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w600)),
                                    Text('Glasses', style: kSmallContentStyle),
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
  }
}

class InfoCircle extends StatelessWidget {
  InfoCircle({
    required this.child,
    required this.colors,
  });

  final Widget child;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: (Colors.grey[400])!,
            offset: Offset(
              0,
              10,
            ),
            blurRadius: 10.0,
            spreadRadius: -5.0,
          ), //BoxShadow
        ],
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        color: Colors.white,
      ),
      child: child,
    );
  }
}
