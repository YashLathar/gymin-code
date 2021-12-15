import 'package:flutter/material.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/widgets/toast_msg.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PlacedOrderScreen extends StatelessWidget {
  const PlacedOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          height: 606,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.all(15),
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    "assets/img/splashlogo.png",
                  ),
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
                          "Powered By:", // $gymName",
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
                                "https://images-na.ssl-images-amazon.com/images/I/81mGkr-aYHS.jpg",
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
                          // ClipRRect(
                          //   borderRadius: BorderRadius.circular(30),
                          //   child: Container(
                          //     width: 50,
                          //     height: 50,
                          //     color: Colors.redAccent,
                          //   ),
                          // ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "productname",
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
                            "https://images-na.ssl-images-amazon.com/images/I/81mGkr-aYHS.jpg"), //userimage
                        radius: 25,
                      ),
                      title: Text(
                        "userName!",
                        style: kSmallContentStyle.copyWith(
                          color: Theme.of(context).textTheme.bodyText2!.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // DottedLine(),
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(12, 12, 12, 15),
                          child: QrImage(
                            foregroundColor: Theme.of(context).backgroundColor,
                            data: "docOrderId",
                            size: 160,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "orderdate",
                              style: kSmallContentStyle.copyWith(
                                fontSize: 20,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .color,
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
                              "Expected",
                              style: kSmallContentStyle.copyWith(
                                fontSize: 20,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .color,
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
                      "Saved in Orders",
                      style: kSubHeadingStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
      // title: Text(
      //   "Order Success",
      //   style: TextStyle(color: Theme.of(context).textTheme.bodyText2!.color),
      // ),
    );
  }
}
