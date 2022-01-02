import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_in/constants.dart';
import 'package:gym_in/pages/booking_result.dart';
import 'package:gym_in/services/orders_service.dart';
import 'package:gym_in/widgets/toast_msg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthenticateTicket extends StatefulWidget {
  const AuthenticateTicket({Key? key}) : super(key: key);

  @override
  State<AuthenticateTicket> createState() => _AuthenticateTicketState();
}

class _AuthenticateTicketState extends State<AuthenticateTicket> {
  String barcodeResult = "";

  Future<void> scan() async {
    try {
      final barcode = await BarcodeScanner.scan();
      final order = await context
          .read(ordersServiceProvider)
          .authenticateGymOrder(barcode.rawContent);

      if (order.gymName != "unknown") {
        showDialog(
          context: context,
          builder: (context) {
            return QrResultScreen(
              gymName: order.gymName,
              gymPhoto: order.gymPhoto,
              userImage: order.userImage,
              userName: order.userName,
              fromDate: order.fromDate,
              fromTime: order.fromTime,
              planSelected: order.planSelected,
              docId: order.docId,
            );
          },
        );
      } else {
        aShowToast(msg: "Ticket not verified");
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          barcodeResult = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => barcodeResult = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => barcodeResult =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => barcodeResult = 'Unknown error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                          width: 2.0, color: Theme.of(context).backgroundColor),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Theme.of(context).textTheme.bodyText2!.color,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Authenticate User",
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
                          FontAwesomeIcons.share,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    splashColor: Colors.blueGrey,
                    onPressed: scan,
                    child: const Text('Verify User'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Container(
                    height: 150,
                    child: Text(
                      barcodeResult,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
