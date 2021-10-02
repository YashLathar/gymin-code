import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/dumy-data/gyms_info.dart';
import 'package:gym_in/widgets/toast_msg.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:dotted_line/dotted_line.dart';

class QrResultScreen extends HookWidget {
  const QrResultScreen({
    Key? key,
    required this.dataIndex,
  }) : super(key: key);

  final dynamic dataIndex;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          height: 606,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topCenter,
                child: Container(
                    margin: EdgeInsets.all(15),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset("assets/img/splashlogo.png")
                    // Text(
                    //   "Gymin - Your TrustWorthy Partner",
                    //   style: kLoginPageSubHeadingTextStyle.copyWith(fontSize: 28),
                    // ),
                    ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 15),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 19, bottom: 12),
                        child: Text(
                          "Powered By:",
                          style:
                              kSmallContentStyle.copyWith(color: Colors.grey),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              width: 50,
                              height: 50,
                              color: Colors.white,
                              child: Image.network(
                                gymsData[dataIndex].gymPhotoUrl[0],
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            gymsData[dataIndex].gymName,
                            style: kSmallContentStyle,
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 19, top: 15, bottom: 12),
                        child: Text(
                          "For:",
                          style:
                              kSmallContentStyle.copyWith(color: Colors.grey),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://m.media-amazon.com/images/I/91I48aFAZDL._AC_SL1500_.jpg",
                        ),
                        radius: 25,
                      ),
                      title: Text(
                        "Wade Wilson",
                        style: kSmallContentStyle,
                      ),
                    ),
                  ],
                ),
              ),
              DottedLine(),
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(12, 12, 12, 15),
                          child: QrImage(
                            data: "Steve 'Steven' Rogers",
                            size: 160,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "October 16",
                              style: kSmallContentStyle.copyWith(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "Date",
                              style: kSmallContentStyle.copyWith(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "14:00",
                              style: kSmallContentStyle.copyWith(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "GMT +5:30",
                              style: kSmallContentStyle.copyWith(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "Time",
                              style: kSmallContentStyle.copyWith(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(22, 12, 12, 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "lu.ma/gymin.co.in",
                              style: kSmallContentStyle.copyWith(
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "OR SCAN ABOVE CODE",
                              style: kSmallContentStyle.copyWith(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width / 1.5,
                child: Container(
                  // hedight: 40,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                     borderRadius: BorderRadius.circular(20),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      aShowToast(msg: "Saved to Your Orders");
                    },
                    child: Text(
                      "Save Ticket",
                      style: kSubHeadingStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


// Scaffold(
//        body: 
//       SafeArea(
//         child: Column(
//           children: [
//             Container(
//               color: Colors.white,
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 50,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(25),
//                       color: Colors.white,
//                     ),
//                     child: Center(
//                       child: IconButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         icon: Icon(
//                           Icons.arrow_back_ios,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Center(
//                       child: Text(
//                         "ID 69368698",
//                         style: kSubHeadingStyle,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: 50,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(25),
//                       color: Colors.white,
//                     ),
//                     child: Center(
//                       child: IconButton(
//                         onPressed: () {
//                           aShowToast(msg: "You'll soon be able to Share tickets");
//                         },
//                         icon: Icon(
//                           Icons.send,
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Divider(
//               thickness: 1.0,
//               height: 0.0,
//             ),
//             Container(
//               // height: 630,
//               width: MediaQuery.of(context).size.width,
//               child: Column(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         bottomRight: Radius.circular(15),
//                         bottomLeft: Radius.circular(15),
//                       ),
//                       color: Colors.redAccent,
//                     ),
//                     alignment: Alignment.center,
//                     child: Container(
//                       margin: EdgeInsets.all(15),
//                       height: 80,
//                       width: MediaQuery.of(context).size.width,
//                       child: Text(
//                         "Gymin - Your TrustWorthy Partner",
//                         style: kLoginPageSubHeadingTextStyle.copyWith(
//                             fontSize: 28),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(top: 20, bottom: 20),
//                     child: Column(
//                       children: [
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Padding(
//                             padding:
//                                 const EdgeInsets.only(left: 22, bottom: 12),
//                             child: Text(
//                               "Powered By",
//                               style: kSmallContentStyle.copyWith(
//                                   color: Colors.grey),
//                             ),
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(left: 20, right: 20),
//                           child: Row(
//                             children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(30),
//                                 child: Container(
//                                   width: 50,
//                                   height: 50,
//                                   color: Colors.white,
//                                   child: Image.network(
//                                     gymsData[dataIndex].gymPhotoUrl[0],
//                                     fit: BoxFit.cover,
//                                     filterQuality: FilterQuality.high,
//                                     loadingBuilder: (BuildContext context,
//                                         Widget child,
//                                         ImageChunkEvent? loadingProgress) {
//                                       if (loadingProgress == null) return child;
//                                       return Center(
//                                         child: CircularProgressIndicator(),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 15,
//                               ),
//                               Text(
//                                 gymsData[dataIndex].gymName,
//                                 style: kSmallContentStyle,
//                               ),
//                             ],
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Padding(
//                             padding: const EdgeInsets.only(
//                                 left: 22, top: 15, bottom: 12),
//                             child: Text(
//                               "For",
//                               style: kSmallContentStyle.copyWith(
//                                   color: Colors.grey),
//                             ),
//                           ),
//                         ),
//                         ListTile(
//                           leading: CircleAvatar(
//                             backgroundImage: NetworkImage(
//                               "https://m.media-amazon.com/images/I/91I48aFAZDL._AC_SL1500_.jpg",
//                             ),
//                             radius: 25,
//                           ),
//                           title: Text(
//                             "Wade Wilson",
//                             style: kSmallContentStyle,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   DottedLine(),
//                   Container(
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             Container(
//                               margin: EdgeInsets.fromLTRB(12, 12, 12, 15),
//                               child: QrImage(
//                                 data: "Steve 'Steven' Rogers",
//                                 size: 180,
//                               ),
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "October 16",
//                                   style: kSmallContentStyle.copyWith(
//                                     fontSize: 20,
//                                   ),
//                                 ),
//                                 Text(
//                                   "Date",
//                                   style: kSmallContentStyle.copyWith(
//                                     fontSize: 14,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 15,
//                                 ),
//                                 Text(
//                                   "14:00",
//                                   style: kSmallContentStyle.copyWith(
//                                     fontSize: 20,
//                                   ),
//                                 ),
//                                 Text(
//                                   "GMT +5:30",
//                                   style: kSmallContentStyle.copyWith(
//                                     fontSize: 20,
//                                   ),
//                                 ),
//                                 Text(
//                                   "Time",
//                                   style: kSmallContentStyle.copyWith(
//                                     fontSize: 14,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                         Container(
//                           margin: EdgeInsets.fromLTRB(22, 12, 12, 15),
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "lu.ma/gymin.co.in",
//                                   style: kSmallContentStyle.copyWith(
//                                     fontSize: 15,
//                                   ),
//                                 ),
//                                 Text(
//                                   "OR SCAN ABOVE CODE",
//                                   style: kSmallContentStyle.copyWith(
//                                     fontSize: 12,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Container(
//                     height: 65,
//                   ),
//                   Container(
//                     color: Colors.white,
//                     width: MediaQuery.of(context).size.width,
//                     child: Container(
//                        height: 60.8,
//                       decoration: BoxDecoration(
//                         color: Colors.redAccent,
//                       ),
//                       child: MaterialButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                           Navigator.pop(context);
//                           aShowToast(msg: "Saved to Your Orders");
//                         },
//                         child: Text(
//                           "Save Ticket",
//                           style: kSubHeadingStyle.copyWith(
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     )

