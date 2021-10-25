// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/pages/gym_checkout_page.dart';
import 'package:gym_in/pages/reviews_sheet.dart';
import 'package:gym_in/widgets/facility_card.dart';
import 'package:gym_in/widgets/toast_msg.dart';
import 'package:like_button/like_button.dart';

class GymPage extends HookWidget {
  final bool gymopen, traineravailable;
  final String gymId,
      gymName,
      gymPhoto,
      gymratings,
      gymaddress,
      trainername,
      trainerphoto,
      trainerrating;
  const GymPage({
    required this.gymId,
    required this.gymName,
    required this.gymPhoto,
    required this.gymratings,
    required this.gymopen,
    required this.gymaddress,
    required this.trainername,
    required this.trainerphoto,
    required this.trainerrating,
    required this.traineravailable,
  });

  @override
  Widget build(BuildContext context) {
    // final List<String> _urlData = gymPhoto;
    // final _current = useState(0);
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
                          // Container(
                          //   child: CarouselSlider(
                          //     options: CarouselOptions(
                          //         height: 400,
                          //         autoPlay: true,
                          //         viewportFraction: 1,
                          //         onPageChanged: (index, reason) {
                          //           _current.value = index;
                          //         }),
                          //     items: _urlData
                          //         .map((item) => Container(
                          //               child: ClipRRect(
                          //                 borderRadius:
                          //                     BorderRadius.circular(20),
                          //                 child: Image.network(
                          //                   item,
                          //                   fit: BoxFit.cover,
                          //                   loadingBuilder:
                          //                       (BuildContext context,
                          //                           Widget child,
                          //                           ImageChunkEvent?
                          //                               loadingProgress) {
                          //                     if (loadingProgress == null)
                          //                       return child;
                          //                     return Center(
                          //                       child:
                          //                           CircularProgressIndicator(),
                          //                     );
                          //                   },
                          //                 ),
                          //               ),
                          //             ))
                          //         .toList(),
                          //   ),
                          // ),
                          Container(
                            child: Image.network(
                              gymPhoto,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 15,
                            ),
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
                                      borderRadius: BorderRadius.circular(35),
                                      border: Border.all(
                                        width: 2.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.arrow_back_ios_new,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(35),
                                        border: Border.all(
                                          width: 2.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      child: Center(
                                        child: LikeButton(
                                          onTap: onLikeButtonTapped,
                                          size: 25,
                                          bubblesSize: 500,
                                          animationDuration:
                                              Duration(milliseconds: 1500),
                                          circleColor: CircleColor(
                                              start: Color(0xff00ddff),
                                              end: Color(0xff0099cc)),
                                          bubblesColor: BubblesColor(
                                            dotPrimaryColor: Color(0xff33b5e5),
                                            dotSecondaryColor:
                                                Color(0xff0099cc),
                                          ),
                                          likeBuilder: (bool isLiked) {
                                            return Icon(
                                              isLiked
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: isLiked
                                                  ? Colors.redAccent
                                                  : Colors.white,
                                              size: 25,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(35),
                                        border: Border.all(
                                          width: 2.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      child: Center(
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            FontAwesomeIcons.share,
                                            color: Colors.white,
                                          ),
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
                      // Container(
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                          // children: _urlData.map((url) {
                          //   int index = _urlData.indexOf(url);
                      //       return Container(
                      //         width: 8.0,
                      //         height: 8.0,
                      //         margin: EdgeInsets.symmetric(
                      //             vertical: 10.0, horizontal: 3.0),
                      //         decoration: BoxDecoration(
                      //           shape: BoxShape.circle,
                      //           color: _current.value == index
                      //               ? Colors.redAccent
                      //               : Color.fromRGBO(0, 0, 0, 0.4),
                      //         ),
                      //       );
                      //     }).toList(),
                      //   ),
                      // ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              gymName,
                              style: kSubHeadingStyle.copyWith(fontSize: 40),
                            ),
                            Text(
                              gymopen ? "Open" : "Closed",
                              style: TextStyle(
                                  color: gymopen
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
                                  gymaddress,
                                  style: kLoginPageSubHeadingTextStyle.copyWith(
                                      fontSize: 18),
                                ),
                                Icon(
                                  Icons.location_pin,
                                  color: Colors.redAccent,
                                ),
                              ],
                            ),
                            IconButton(
                              icon: Icon(Icons.directions),
                              onPressed: () {},
                              color: Colors.lightBlueAccent,
                            ),
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
                            TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return FacilitySheet();
                                    });
                              },
                              child: Text(
                                'View all',
                                style: kSmallContentStyle.copyWith(
                                    color: Colors.redAccent),
                              ),
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
                              isfacilityavailable: true,
                              onpressed: () {},
                            ),
                            FacilityCard(
                              icon: FontAwesomeIcons.shower,
                              text: "Shower",
                              isfacilityavailable: true,
                              onpressed: () {},
                            ),
                            FacilityCard(
                              icon: FontAwesomeIcons.running,
                              text: "Trainer",
                              isfacilityavailable: true,
                              onpressed: () {},
                            ),
                            FacilityCard(
                              icon: FontAwesomeIcons.nutritionix,
                              text: "Diet",
                              isfacilityavailable: true,
                              onpressed: () {},
                            ),
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
                        child: Text(
                          "Trainers",
                          style: kSubHeadingStyle,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 15, right: 15, top: 20, bottom: 0),
                        height: 130,
                        child: Container(
                          width: 270,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Container(
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Container(
                                        width: 75,
                                        height: 75,
                                        color: Colors.white,
                                        child: Image.network(
                                          trainerphoto,
                                          fit: BoxFit.cover,
                                          filterQuality: FilterQuality.high,
                                          loadingBuilder: (BuildContext context,
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
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 87, top: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            trainername,
                                            style: kSubHeadingStyle,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  traineravailable
                                                      ? "Available"
                                                      : "Not Available",
                                                  style: TextStyle(
                                                      color: traineravailable
                                                          ? Colors.green
                                                          : Colors.redAccent),
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.star,
                                                          color: Color(
                                                              0xffFFD700)),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Container(
                                                        width: 20,
                                                        height: 20,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color:
                                                              Color(0xffFFD700),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            trainerrating
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15),
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
                                  ],
                                ),
                              ),
                              // SizedBox(
                              //   height: 15,
                              // ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 2,
                        indent: 30,
                        endIndent: 30,
                      ),
                      Container(
                        //height: 200,
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Reviews",
                              style: kSubHeadingStyle,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "View all",
                                style: kSmallHeadingTextStyle.copyWith(
                                    color: Colors.redAccent),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 5,
                        ),
                        child: Container(
                          height: 260,
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 0, right: 10, top: 20, bottom: 0),
                            height: 180,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "⭐️" + "  " + gymratings.toString(),
                                      style: kLoginPageSubHeadingTextStyle
                                          .copyWith(fontSize: 18),
                                    ),
                                    Text(
                                      "(7.9k reviews)",
                                      style: kSmallContentStyle,
                                    ),
                                    SizedBox(
                                      width: size.width / 6.2,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                            context: context,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                top: Radius.circular(25),
                                              ),
                                            ),
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            builder: (BuildContext context) {
                                              return RatingsSheet();
                                            });
                                      },
                                      child: Text(
                                        "Rate us?",
                                        style: kSmallContentStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                // ReviewCard(
                                //   userPhotoUrl:
                                //       reviewsData[dataIndex].userPhotoUrl[0],
                                //   userName: reviewsData[dataIndex].userName,
                                //   index: 0,
                                //   button: reviewsData[dataIndex].editButton,
                                //   height: 30,
                                //   width: 30,
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "don't remove this container",
                            ), // courtesy: mayank yadav
                          ],
                        ),
                      )
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
                  borderRadius: BorderRadius.circular(20),
                ),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GymCheckoutPage(
                      gymcheckName:  gymName,
     gymcheckPhoto: gymPhoto,
                      gymcheckId: gymId,
                      gymcheckAddress: gymaddress,
                    ),),);
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

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    await Future.delayed(Duration(seconds: 0));
    aShowToast(
      msg: "Added to your Favourites",
    );
    return !isLiked;
  }
}

class FacilitySheet extends StatelessWidget {
  const FacilitySheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.4,
      child: Center(
        child: Text("Facility in detail here"),
      ),
    );
  }
}
