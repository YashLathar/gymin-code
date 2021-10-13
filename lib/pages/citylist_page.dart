import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_in/dumy-data/cities_info.dart';
import 'package:gym_in/widgets/citylist_card.dart';

class CityListPage extends HookWidget {
  final dynamic dataIndex;
  const CityListPage({required this.dataIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.redAccent,
      //   title: CupertinoSearchTextField(
      //     itemColor: Colors.white,
      //   ),
      // ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: 60,
                color: Colors.redAccent,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.redAccent,
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: CupertinoSearchTextField(
                          itemColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      margin: EdgeInsets.only(left: 5),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: citiesData.length,
                        padding: EdgeInsets.fromLTRB(5, 8, 5, 8),
                        itemBuilder: (context, index) {
                          return CityListCard(
                            cityName: citiesData[index].cityName, 
                            cityPhotoUrl: citiesData[index].cityPhotoUrl[0],
                            index: index,
                            availability: citiesData[index].available,
                            height: 80,
                            width: 80,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
