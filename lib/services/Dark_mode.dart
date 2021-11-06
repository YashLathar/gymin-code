import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter_riverpod/src/provider.dart';
import 'package:gym_in/general_providers.dart';

class DarkModeSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appThemeState = context.read(appThemeStateNotifier);
    return Switch(
      value: appThemeState.isDarkModeEnabled,
      onChanged: (enabled) {
        if (enabled) {
          appThemeState.setDarkTheme();
        } else {
          appThemeState.setLightTheme();
        }
      },
    );
  }
}

class DarkModeWidget extends StatelessWidget {
  const DarkModeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dark Mode"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Light",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  DarkModeSwitch(),
                  Text(
                    "Dark",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
