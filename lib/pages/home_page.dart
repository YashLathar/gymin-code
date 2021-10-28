import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/dumy-data/gyms_info.dart';
import 'package:gym_in/pages/citylist_page.dart';
import 'package:gym_in/pages/gymlist_page.dart';
import 'package:gym_in/widgets/gym_card.dart';
import 'package:gym_in/widgets/toast_msg.dart';

final cities = [
  "New Delhi",
  "Moradabad",
  "Bangalore",
  "Kanpur",
  "Lucknow",
  "Nagpur",
  "Agra",
  "Muzaffarnagar",
  "Rampur",
  "Mathura",
];

final recentCities = [
  "Moradabad",
  "Lucknow",
  "Mathura",
];

class HomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // final FloatingSearchBarController searchBarController =
    //     FloatingSearchBarController();
    // final leadingIcon = useState(Icons.search);
    // final actionsIcon = useState(Icons.close);
    // final actionsIconColor = useState(Colors.white);
    // final suggestionList = useState([]);
    final ScrollController _scrollController = ScrollController();
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 50,
          leading: GestureDetector(
            child: Image.asset('assets/Burger-menu.png'),
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/chatPage');
                  },
                  child: Icon(
                    FontAwesomeIcons.envelope,
                    color: Colors.black,
                    size: 30,
                  )),
            )
          ],
          title: GestureDetector(
            onTap: () {
              _scrollController.animateTo(
                0.0,
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 200),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Center(
                child: Image.asset(
                  'assets/img/splashlogo.png',
                  height: 90,
                  width: 150,
                ),
              ),
            ),
          ),
        ),
        body: ListView(
          controller: _scrollController,
          physics: ClampingScrollPhysics(),
          children: [
            Container(
              width: size.width,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                    child: CupertinoSearchTextField(
                      padding: EdgeInsets.all(15),
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.fromLTRB(5, 10, 10, 10),
                  //   child: ListTile(
                  //     leading: CircleAvatar(
                  //       radius: 40,
                  //       child: Icon(Icons.gps_fixed),
                  //       backgroundColor: Colors.redAccent,
                  //     ),
                  //   ),
                  // ),
                  Container(
                    height: 200,
                    child: Image.asset('assets/home-page-heading.png'),
                  ),
                  // Container(
                  //     padding: EdgeInsets.symmetric(horizontal: 15),
                  //     child:
                  //         CupertinoSearchTextField(padding: EdgeInsets.all(15))
                  //     // FloatingSearchBar(
                  //     //   backdropColor: Colors.grey.withOpacity(0.8),
                  //     //   queryStyle: kSmallContentStyle,
                  //     //   controller: searchBarController,
                  //     //   borderRadius: BorderRadius.circular(10),
                  //     //   automaticallyImplyBackButton: false,
                  //     //   implicitCurve: Curves.bounceOut,
                  //     //   onFocusChanged: (value) {
                  //     //     if (value == true) {
                  //     //       leadingIcon.value = Icons.arrow_back;
                  //     //       actionsIcon.value = Icons.close;
                  //     //       actionsIconColor.value = Colors.black;
                  //     //     } else {
                  //     //       leadingIcon.value = Icons.search;
                  //     //       actionsIconColor.value = Colors.white;
                  //     //     }
                  //     //     return value;
                  //     //   },
                  //     //   leadingActions: [
                  //     //     IconButton(
                  //     //       icon: Icon(leadingIcon.value),
                  //     //       onPressed: () {
                  //     //         searchBarController.close();
                  //     //       },
                  //     //     ),
                  //     //   ],
                  //     //   actions: [
                  //     //     IconButton(
                  //     //       icon: Icon(
                  //     //         actionsIcon.value,
                  //     //         color: actionsIconColor.value,
                  //     //       ),
                  //     //       onPressed: () {
                  //     //         searchBarController.clear();
                  //     //       },
                  //     //     ),
                  //     //   ],
                  //     //   transitionCurve: Curves.easeInOutCubic,
                  //     //   transition: CircularFloatingSearchBarTransition(),
                  //     //   physics: const BouncingScrollPhysics(),
                  //     //   onQueryChanged: (String query) {
                  //     //     final modifiedFirstCharacter =
                  //     //         query.isNotEmpty ? query[0].toUpperCase() : null;
                  //     //     final modifiedQuery = query.isNotEmpty
                  //     //         ? query.replaceFirst(
                  //     //             query[0], modifiedFirstCharacter, 0)
                  //     //         : null;

                  //     //     suggestionList.value = query.isEmpty
                  //     //         ? recentCities
                  //     //         : cities
                  //     //             .where((element) =>
                  //     //                 element.contains(modifiedQuery))
                  //     //             .toList();
                  //     //   },
                  //     //   builder: (context, _) {
                  //     //     return Padding(
                  //     //       padding: const EdgeInsets.only(top: 10),
                  //     //       child: ClipRRect(
                  //     //         borderRadius: BorderRadius.circular(8),
                  //     //         child: Column(
                  //     //           children: List.generate(
                  //     //               suggestionList.value.length, (index) {
                  //     //             return ListTile(
                  //     //               leading: Icon(Icons.restore),
                  //     //               title: Text(suggestionList.value[index]),
                  //     //             );
                  //     //           }).toList(),
                  //     //         ),
                  //     //       ),
                  //     //     );
                  //     //   },
                  //     ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 25, right: 25, top: 50, bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Nearby',
                          style: kSubHeadingStyle,
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigator.pushReplacementNamed(
                            //     context, "/gymListPage");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GymListPage(
                                          dataIndex: 0,
                                        )));
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
                    height: 350,
                    margin: EdgeInsets.only(left: 5),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: gymsData.length,
                      itemBuilder: (context, index) {
                        return GymCard(
                          gymName: gymsData[index].gymName,
                          gymPhotoUrl: gymsData[index].gymPhotoUrl[0],
                          index: index,
                          ratings: gymsData[index].ratings,
                          isCurrentlyOpen: gymsData[index].isOpen,
                          address: gymsData[index].address,
                          width: 270,
                          height: 220,
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15, bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Popular Cities',
                          style: kSubHeadingStyle,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CityListPage(
                                          dataIndex: 0,
                                        )));
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
                    ////
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    height: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Flexible(
                                child: GestureDetector(
                                  onTap: () async {
                                    await Future.delayed(Duration(seconds: 1));
                                    aShowToast(
                                      msg: "We're Coming to your City Soon",
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(24),
                                        topRight: Radius.circular(24),
                                        bottomLeft: Radius.circular(24),
                                        bottomRight: Radius.circular(24),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'https://cdn.s3waas.gov.in/s382161242827b703e6acf9c726942a1e4/uploads/bfi_thumb/2018080755-olw9wu1n6fuxala3g4kn7b1bndsegqa94qi5wvcm3k.jpg'),
                                      ),
                                    ),
                                    child: Container(
                                      alignment: Alignment.topCenter,
                                      color: Colors.transparent,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Text(
                                          'Moradabad',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: GestureDetector(
                                  onTap: () async {
                                    await Future.delayed(Duration(seconds: 1));
                                    aShowToast(
                                      msg: "We're Coming to your City Soon",
                                    );
                                  },
                                  child: Container(
                                    //height: 1200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(24),
                                        topRight: Radius.circular(24),
                                        bottomLeft: Radius.circular(24),
                                        bottomRight: Radius.circular(24),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'https://pbs.twimg.com/profile_images/458286447670202368/xcHOodM-.jpeg'),
                                      ),
                                    ),
                                    child: Container(
                                      alignment: Alignment.topCenter,
                                      color: Colors.transparent,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Text(
                                          'Shahjahanpur',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24.0,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
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
                                  onTap: () async {
                                    await Future.delayed(Duration(seconds: 1));
                                    aShowToast(
                                      msg: "We're Coming to your City Soon",
                                    );
                                  },
                                  child: Container(
                                    height: 1200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(24),
                                        topRight: Radius.circular(24),
                                        bottomLeft: Radius.circular(24),
                                        bottomRight: Radius.circular(24),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'https://i.pinimg.com/originals/1e/2b/09/1e2b0958e83b682ee976afb3aeb77c47.jpg'),
                                      ),
                                    ),
                                    child: Container(
                                      alignment: Alignment.topCenter,
                                      color: Colors.transparent,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 14),
                                        child: Text(
                                          'Rampur',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24.0,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: GestureDetector(
                                  onTap: () async {
                                    await Future.delayed(Duration(seconds: 1));
                                    aShowToast(
                                      msg: "We're Coming to your City Soon",
                                    );
                                  },
                                  child: Container(
                                    height: 1200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(24),
                                        topRight: Radius.circular(24),
                                        bottomLeft: Radius.circular(24),
                                        bottomRight: Radius.circular(24),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'https://www.hospitalitynet.org/picture/xxl_153116922.jpg?t=20200803125617'),
                                      ),
                                    ),
                                    child: Container(
                                      alignment: Alignment.topCenter,
                                      color: Colors.transparent,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: Text(
                                          'Lucknow',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22.0,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
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
                  Container(
                    margin: EdgeInsets.only(
                        left: 15, right: 15, bottom: 30, top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Our Universal Packs',
                          style: kSmallContentStyle,
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
    );
  }
}
