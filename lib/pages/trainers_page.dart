import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_in/constants.dart';

class TrainerZone extends StatefulWidget {
  const TrainerZone({Key? key}) : super(key: key);

  @override
  _TrainerZoneState createState() => _TrainerZoneState();
}

class _TrainerZoneState extends State<TrainerZone> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List adminList = [];
  Future adminListFromFirebase() async {
    final userFromUsersCollection = await _firestore
        .collection('users')
        .where("isTrainer", isEqualTo: true)
        .get();

    if (userFromUsersCollection.docs.isNotEmpty) {
      setState(() {
        adminList = userFromUsersCollection.docs;
      });
    }
  }

  @override
  void initState() {
    adminListFromFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
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
                            width: 2.0,
                            color: Theme.of(context).backgroundColor),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color:
                                  Theme.of(context).textTheme.bodyText2!.color,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Trainers",
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
                            FontAwesomeIcons.plus,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: adminList.map((data) {
                    return ListTile(
                        leading: Container(
                          width: 70,
                          child: Image.network(data['userPhoto']),
                        ),
                        title: Text(
                          data['userName'],
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText2!.color),
                        ),
                        subtitle: Text(
                          data['address'],
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText2!.color),
                        ),
                        trailing: CircleAvatar(
                          child: Image.asset("assets/img/instagram.png"),
                        ));
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
