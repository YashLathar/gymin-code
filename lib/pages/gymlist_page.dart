// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:gym_in/pages/gym_page.dart';
// import 'package:gym_in/widgets/gymlist_card.dart';

// class GymListPage extends StatefulWidget {
//   const GymListPage({Key? key}) : super(key: key);

//   @override
//   _GymListPageState createState() => _GymListPageState();
// }

// class _GymListPageState extends State<GymListPage> {
//   final Stream<QuerySnapshot> _gymStream =
//       FirebaseFirestore.instance.collection('gymdata').snapshots();
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _gymStream,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Scaffold(
//             appBar: AppBar(
//               backgroundColor: Colors.redAccent,
//               title: CupertinoSearchTextField(),
//             ),
//             body: Center(
//               child: Container(
//                 height: 50,
//                 width: 50,
//                 child: Center(
//                   child: Text("Something Went Wrong"),
//                 ),
//               ),
//             ),
//           );
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Scaffold(
//             appBar: AppBar(
//               backgroundColor: Colors.redAccent,
//               title: CupertinoSearchTextField(),
//             ),
//             body: Center(
//               child: Container(
//                 height: 50,
//                 width: 50,
//                 child: Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               ),
//             ),
//           );
//         }

//         return Scaffold(
//           appBar: AppBar(
//               backgroundColor: Colors.redAccent,
//               title: CupertinoSearchTextField(),
//             ),
//           body: Container(
//             padding: EdgeInsets.all(8),
//             child: ListView(
//               children: snapshot.data!.docs.map((DocumentSnapshot document) {
//                 Map<String, dynamic> data =
//                     document.data()! as Map<String, dynamic>;
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => GymPage(

//                           gymName: data['gname'],
//                           gymphotos: data['gymphotos'],
//                           gymPhoto: data['gphoto'],
//                           gymratings: data['gratings'],
//                           gymopen: data['open'],
//                           gymaddress: data['gaddress'],
//                           trainername: data['gtrainername'],
//                           trainerphoto: data['gtrainerphoto'],
//                           trainerrating: data['gtrainerrating'],
//                           traineravailable: data['gtraineravailable'],
//                           gymId: document.id,
//                         ),
//                       ),
//                     );
//                   },
//                   child: GymListCard(
//                     gname: data['gname'],
//                     gPhoto: data['gphoto'],
//                     gratings: data['gratings'],
//                     open: data['open'],
//                     gaddress: data['gaddress'],
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
