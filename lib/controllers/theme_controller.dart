import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter_riverpod/src/provider.dart';
import 'package:gym_in/general_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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


// // @immutable
// class ThemeModeSwitch extends ConsumerWidget {
//   const ThemeModeSwitch({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, ScopedReader ref) {
//     final ThemeMode themeMode = useProvider(appThemeStateNotifier);
//     final List<bool> isSelected = <bool>[
//       themeMode == ThemeMode.light,
//       themeMode == ThemeMode.system,
//       themeMode == ThemeMode.dark,
//     ];
//     return ToggleButtons(
//       isSelected: isSelected,
//       onPressed: (int newIndex) {
//         if (newIndex == 0) {
//           context.read(appThemeStateNotifier).state = ThemeMode.light;
//         } else if (newIndex == 1) {
//           context.read(appThemeStateNotifier).state = ThemeMode.system;
//         } else {
//           context.read(appThemeStateNotifier).state = ThemeMode.dark;
//         }
//       },
//       children: const <Widget>[
//         Icon(Icons.light),
//         Icon(Icons.system_security_update),
//         Icon(Icons.dark_mode),
//       ],
//     );
//   }
// }

