import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_in/dumy-data/gyms_info.dart';
import 'package:gym_in/pages/favorites_page.dart';
import 'package:gym_in/widgets/gymlist_card.dart';

class GymListPage extends HookWidget {
  final dynamic dataIndex;
  const GymListPage({required this.dataIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.redAccent,
      //   title: CupertinoSearchTextField(
      //     itemColor: Colors.white,
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.favorite),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => FavoritesPage()));
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                        itemCount: gymsData.length,
                        padding: EdgeInsets.fromLTRB(5, 8, 5, 8),
                        itemBuilder: (context, index) {
                          return GymListCard(
                            gymName: gymsData[index].gymName,
                            gymPhotoUrl: gymsData[index].gymPhotoUrl[0],
                            index: index,
                            ratings: gymsData[index].ratings,
                            isCurrentlyOpen: gymsData[index].isOpen,
                            address: gymsData[index].address,
                            width: 80,
                            height: 80,
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
