import 'package:flutter/material.dart';
import 'package:gym_in/constants.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Container(
            color: Colors.redAccent,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.redAccent,
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Your Favourites",
                      style: kSubHeadingStyle,
                    ),
                  ),
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.redAccent,
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add_circle,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          // Container(
          //   child: Column(
          //     children: [
          //       Expanded(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text(
          //         "Light",
          //         style: Theme.of(context).textTheme.bodyText2,
          //       ),
          //       // DarkModeSwitch(),
          //       Text(
          //         "Dark",
          //         style: Theme.of(context).textTheme.bodyText2,
          //       ),
          //     ],
          //   ),
          // ),
          //     ],
          //   ),
          // )
        ],
      ),
    ));
  }
}

// class DarkModeSwitch extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final appThemeState = context.read(appThemeStateNotifier);
//     return Switch(
//       value: appThemeState.isDarkModeEnabled,
//       onChanged: (enabled) {
//         if (enabled) {
//           appThemeState.setDarkTheme();
//         } else {
//           appThemeState.setLightTheme();
//         }
//       },
//     );
//   }
// }