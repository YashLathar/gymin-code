import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/dumy-data/gyms_info.dart';
import 'package:gym_in/widgets/cities_card.dart';
import 'package:gym_in/widgets/facility_card.dart';
import 'package:like_button/like_button.dart';

class GymPage extends HookWidget {
  final dynamic dataIndex;
  const GymPage({required this.dataIndex});
  @override
  Widget build(BuildContext context) {
    final List<String> _urlData = gymsData[dataIndex].gymPhotoUrl;
    final _current = useState(0);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SafeArea(
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: [
                Container(
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            child: CarouselSlider(
                              options: CarouselOptions(
                                  height: 450,
                                  autoPlay: false,
                                  viewportFraction: 1,
                                  onPageChanged: (index, reason) {
                                    _current.value = index;
                                  }),
                              items: _urlData
                                  .map((item) => Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            item,
                                            fit: BoxFit.cover,
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            },
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        width: 2.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      width: 2.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: Center(
                                    child: LikeButton(
                                      size: 25,
                                      bubblesSize: 500,
                                      animationDuration:
                                          Duration(milliseconds: 1500),
                                      circleColor: CircleColor(
                                          start: Color(0xff00ddff),
                                          end: Color(0xff0099cc)),
                                      bubblesColor: BubblesColor(
                                        dotPrimaryColor: Color(0xff33b5e5),
                                        dotSecondaryColor: Color(0xff0099cc),
                                      ),
                                      likeBuilder: (bool isLiked) {
                                        return Icon(
                                          isLiked
                                              ? Icons.bookmark
                                              : Icons.bookmark_border,
                                          color: isLiked
                                              ? Colors.redAccent
                                              : Colors.white,
                                          size: 25,
                                        );
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _urlData.map((url) {
                            int index = _urlData.indexOf(url);
                            return Container(
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 3.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _current.value == index
                                    ? Colors.redAccent
                                    : Color.fromRGBO(0, 0, 0, 0.4),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              gymsData[dataIndex].gymName,
                              style: kSubHeadingStyle.copyWith(fontSize: 40),
                            ),
                            Text(
                              gymsData[dataIndex].isOpen ? "Open" : "Closed",
                              style: TextStyle(
                                  color: gymsData[dataIndex].isOpen
                                      ? Colors.green
                                      : Colors.redAccent),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Moradabad',
                                  style: kLoginPageSubHeadingTextStyle.copyWith(
                                      fontSize: 18),
                                ),
                                Icon(
                                  Icons.location_pin,
                                  color: Colors.redAccent,
                                ),
                              ],
                            ),
                            Icon(
                              Icons.directions,
                              color: Colors.lightBlueAccent,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        child: Row(
                          children: [
                            Text(
                              "⭐️" +
                                  "  " +
                                  gymsData[dataIndex].ratings.toString(),
                              style: kLoginPageSubHeadingTextStyle.copyWith(
                                  fontSize: 18),
                            ),
                            SizedBox(width: 5),
                            Text("(7.9k reviews)"),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 2,
                        indent: 30,
                        endIndent: 30,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Facilities',
                              style: kSubHeadingStyle,
                            ),
                            Text(
                              'View all',
                              style: kSmallContentStyle.copyWith(
                                  color: Colors.redAccent),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FacilityCard(
                              icon: Icons.ac_unit,
                              text: "AC",
                            ),
                            FacilityCard(
                              icon: FontAwesomeIcons.shower,
                              text: "Shower",
                            ),
                            FacilityCard(
                              icon: FontAwesomeIcons.running,
                              text: "Trainer",
                            ),
                            FacilityCard(
                              icon: FontAwesomeIcons.nutritionix,
                              text: "Diet",
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 15, right: 15, top: 20, bottom: 70),
                        height: 500,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(bottom: 60),
                                child: Column(
                                  children: [
                                    Flexible(
                                      flex: 2,
                                      child: CitiesCard(
                                        cityName: 'Trainers',
                                        cityWidget: Text('😎',
                                            style: kMainHeadingStyle),
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                    Flexible(
                                      child: CitiesCard(
                                        cityName: 'Events',
                                        cityWidget: Text('😎',
                                            style: kMainHeadingStyle),
                                        color: Colors.lightBlue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(top: 50),
                                child: Column(
                                  children: [
                                    Flexible(
                                      child: CitiesCard(
                                        cityName: 'Diet Plan',
                                        cityWidget: Text('😎',
                                            style: kMainHeadingStyle),
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: CitiesCard(
                                        cityName: 'Calendar',
                                        cityWidget: Text('😎',
                                            style: kMainHeadingStyle),
                                        color: Colors.indigo,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding:
                  EdgeInsets.only(bottom: 25, left: 15, right: 15, top: 20),
              color: Colors.white,
              width: size.width,
              child: Container(
                height: 65,
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(20)),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/gymCheckoutPage",
                        arguments: dataIndex);
                  },
                  child: Text(
                    "Book Now",
                    style: kSubHeadingStyle.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
