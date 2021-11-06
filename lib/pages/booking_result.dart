import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/widgets/toast_msg.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:dotted_line/dotted_line.dart';

class QrResultScreen extends HookWidget {
  const QrResultScreen({
    required this.gymName,
    required this.userName,
    required this.docId,
    required this.fromDate,
    required this.fromTime,
    required this.planSelected,
    required this.userImage,
    Key? key,
  }) : super(key: key);

  final String gymName;
  final String? userName;
  final String docId;
  final String fromDate;
  final String fromTime;
  final String planSelected;
  final String? userImage;

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
                    child: Image.asset("assets/img/splashlogo.png")),
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
                          "Powered By: $gymName",
                          style:
                              kSmallContentStyle.copyWith(color: Colors.grey),
                        ),
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(left: 20, right: 20),
                    //   child: Row(
                    //     children: [
                    //       ClipRRect(
                    //         borderRadius: BorderRadius.circular(30),
                    //         child: Container(
                    //           width: 50,
                    //           height: 50,
                    //           color: Colors.white,
                    //           child: Image.network(
                    //             gymsData[dataIndex].gymPhotoUrl[0],
                    //             fit: BoxFit.cover,
                    //             filterQuality: FilterQuality.high,
                    //             loadingBuilder: (BuildContext context,
                    //                 Widget child,
                    //                 ImageChunkEvent? loadingProgress) {
                    //               if (loadingProgress == null) return child;
                    //               return Center(
                    //                 child: CircularProgressIndicator(),
                    //               );
                    //             },
                    //           ),
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: 15,
                    //       ),
                    //       Text(
                    //         gymsData[dataIndex].gymName,
                    //         style: kSmallContentStyle,
                    //       ),
                    //     ],
                    //   ),
                    // ),
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
                        backgroundImage: NetworkImage(userImage!),
                        radius: 25,
                      ),
                      title: Text(
                        userName!,
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
                            data: docId,
                            size: 160,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fromDate,
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
                              fromTime,
                              style: kSmallContentStyle.copyWith(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "IST",
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
                              "https://gymin.co.in",
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
              Expanded(
                child: SizedBox(),
              ),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width / 1.5,
                child: Container(
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
