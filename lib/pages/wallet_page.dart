import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/pages/setting_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WalletPage extends HookWidget {
  final ScrollController controller = ScrollController();

  Column checkCountAmount(String label, int count) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          count.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22.0,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          margin: EdgeInsets.only(top: 4.0),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    final authControllerState = useProvider(authControllerProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Wallet',
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingPage()));
              },
              icon: Icon(
                FontAwesomeIcons.cog,
                color: Colors.black,
              ))
        ],
        backgroundColor: Colors.redAccent,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              // width: size.width,
              // height: size.height / 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(
                            authControllerState!.photoURL ??
                                "https://fanfest.com/wp-content/uploads/2021/02/Loki.jpg",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        authControllerState.displayName ?? 'UserName',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  checkCountAmount("USD", 0),
                  // Text(
                  //   "679.5",
                  //   style: kMainHeadingStyle,
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Text(
                  //   "USD",
                  //   style: kSubHeadingStyle,
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return PayBottomSheet();
                      },
                    );
                  },
                  child: ActionsCard(
                    text: "Pay",
                    textColor: Colors.green,
                    icon: Icon(
                      FontAwesomeIcons.paperPlane,
                      color: Colors.green,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return RecieveBottomSheet();
                      },
                    );
                  },
                  child: ActionsCard(
                    text: "Recieve",
                    textColor: Colors.blue,
                    icon: Icon(
                      FontAwesomeIcons.handHoldingUsd,
                      color: Colors.blue,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return AddBottomSheet();
                      },
                    );
                  },
                  child: ActionsCard(
                    text: "Add",
                    icon: Icon(FontAwesomeIcons.wallet),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return RequestBottomSheet();
                      },
                    );
                  },
                  child: ActionsCard(
                    text: "Request",
                    icon: Icon(
                      FontAwesomeIcons.mobileAlt,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  physics: PageScrollPhysics(),
                  controller: controller,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return TransitionCard(
                      child: ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        leading: ClipOval(
                          child: Image.network(
                            data[index].photoURL,
                            width: 50,
                            height: 50,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return CircularProgressIndicator();
                            },
                          ),
                        ),
                        title: Text(data[index].name),
                        subtitle: Text(data[index].date),
                        trailing: Text(
                          data[index].amount.toString(),
                          style: TextStyle(
                              color: data[index].recieved
                                  ? Colors.green
                                  : Colors.redAccent),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

final List<TranstionData> data = [
  TranstionData(
    amount: "200",
    recieved: true,
    photoURL:
        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
    name: "Vince McMahon",
    date: "23rd Aprl 2021, 10:52",
  ),
  TranstionData(
    amount: "300",
    recieved: true,
    photoURL:
        "https://images.unsplash.com/photo-1517530094915-500495b15ade?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80",
    name: "Paul Heyman",
    date: "23rd Aprl 2021, 16:24",
  ),
  TranstionData(
    amount: "457",
    recieved: false,
    photoURL:
        "https://images.unsplash.com/photo-1572631382901-cf1a0a6087cb?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=929&q=80",
    name: "Sheldon Cooper",
    date: "23rd Aprl 2021, 9:21",
  ),
  TranstionData(
    amount: "872",
    recieved: true,
    photoURL:
        "https://images.unsplash.com/photo-1601582589907-f92af5ed9db8?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cG9ydHJhaXRzfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=900&q=60",
    name: "Leonerd Hoffstader",
    date: "23rd Aprl 2021, 10:25",
  ),
  TranstionData(
    amount: "213",
    recieved: false,
    photoURL:
        "https://images.unsplash.com/photo-1517883074437-df05bd218272?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzV8fHBvcnRyYWl0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=900&q=60",
    name: "Phil Brooks",
    date: "23rd Aprl 2021, 19:52",
  ),
  TranstionData(
    amount: "842",
    recieved: false,
    photoURL:
        "https://images.unsplash.com/photo-1614077280383-2e55afa2a2e5?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDN8fHBvcnRyYWl0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=900&q=60",
    name: "Eric Bischoff",
    date: "23rd Aprl 2021, 17:43",
  ),
  TranstionData(
    amount: "267",
    recieved: true,
    photoURL:
        "https://images.unsplash.com/photo-1611609054267-e89cfcc5a53d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NjR8fHBvcnRyYWl0c3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=900&q=60",
    name: "Rick Jobs",
    date: "23rd Aprl 2021, 13:27",
  ),
];

class TransitionCard extends StatelessWidget {
  final Widget child;

  const TransitionCard({
    Key? key,
    required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color(
          0xffEAEAEA,
        ),
      ),
      child: child,
    );
  }
}

class ActionsCard extends StatelessWidget {
  final Widget icon;
  final String text;
  final Color? textColor;

  const ActionsCard({
    Key? key,
    required this.icon,
    required this.text,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 95,
      decoration: BoxDecoration(
        color: Color(
          0xffEAEAEA,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          SizedBox(
            height: 10,
          ),
          Text(
            text,
            style: TextStyle(color: textColor, fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class TranstionData {
  final String photoURL;
  final String name;
  final String date;
  final bool recieved;
  final String amount;

  TranstionData(
      {required this.photoURL,
      required this.name,
      required this.date,
      required this.amount,
      required this.recieved});
}

class PayBottomSheet extends StatelessWidget {
  const PayBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Hello Pay Here"),
      ),
    );
  }
}

class RecieveBottomSheet extends StatelessWidget {
  const RecieveBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Hello Recieve Here"),
      ),
    );
  }
}

class AddBottomSheet extends StatelessWidget {
  const AddBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Hello Add Here"),
      ),
    );
  }
}

class RequestBottomSheet extends StatelessWidget {
  const RequestBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Hello Request Here"),
      ),
    );
  }
}
