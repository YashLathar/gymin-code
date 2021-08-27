import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_in/controllers/auth_controller.dart';
import 'package:gym_in/pages/user_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../constants.dart';

class SettingPage extends HookWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authControllerState = useProvider(authControllerProvider);
    //final _tabController = useTabController(initialLength: 2);
    if (authControllerState != null) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              //SizedBox(width: 50.0),
              Text('Settings',
                  style: kRoundedButtonTextStyle.copyWith(
                    color: Colors.black,
                  ))
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    ClipOval(
                      child: //ImageProfile(),
                          Image.network(
                        "https://img.icons8.com/cute-clipart/2x/user-male.png",
                        fit: BoxFit.cover,
                        width: 90,
                        height: 90,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          //authControllerState.email ??
                          'UserName',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(authControllerState.email ?? 'example@email.com')
                      ],
                    ),
                    Expanded(child: SizedBox()),
                    Icon(Icons.edit),
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text('E-mail'),
                    onTap: null,
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('Phone Number'),
                    onTap: null,
                  ),
                  ListTile(
                    leading: Icon(Icons.notifications),
                    title: Text('Notification'),
                    onTap: null,
                  ),
                  ListTile(
                    leading: Icon(Icons.security),
                    title: Text('Security'),
                    onTap: null,
                  ),
                  ListTile(
                    leading: Icon(Icons.contact_mail),
                    title: Text('Contact Us'),
                    onTap: null,
                  )
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return UserPage();
    }
  }
}
