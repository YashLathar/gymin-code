import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_in/widgets/gymlist_card.dart';

class GymListPage extends StatefulWidget {
  const GymListPage({Key? key}) : super(key: key);

  @override
  _GymListPageState createState() => _GymListPageState();
}

class _GymListPageState extends State<GymListPage> {
  final Stream<QuerySnapshot> _gymStream =
      FirebaseFirestore.instance.collection('gymdata').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _gymStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.redAccent,
            title: CupertinoSearchTextField(),
          ),
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.all(8),
              child: ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return GymListCard(
                    // id: data[document].id,
                    gname: data['gname'],
                    gPhoto: data['gphoto'],
                    gratings: data['gratings'],
                    open: data['open'],
                    gaddress: data['gaddress'],
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}



// Scaffold(
//               body: SafeArea(
//                 child: Column(
//                   children: [
//                     Container(
//                     height: 60,
//                     color: Colors.redAccent,
//                     padding: EdgeInsets.symmetric(horizontal: 20),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 50,
//                           height: 50,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(25),
//                             color: Colors.redAccent,
//                           ),
//                           child: Center(
//                             child: IconButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               icon: Icon(
//                                 Icons.arrow_back_ios,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Center(
//                             child: CupertinoSearchTextField(
//                               itemColor: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                     Container(
//                       child: ListView.builder(
//                         padding: EdgeInsets.only(bottom: 50),
//                           // gridDelegate:
//                           //     SliverGridDelegateWithFixedCrossAxisCount(
//                           //         crossAxisCount: 2,
//                           //         mainAxisExtent: 350,
//                           //         crossAxisSpacing: 15),
//                         itemBuilder: (context, index) {
//                          return



// }
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );