import 'dart:ui';
import 'package:flutter/material.dart';

// class Styles {
//   static ThemeData themeData(BuildContext context) {
//     return ThemeData(
//         primarySwatch: Colors.red,
//         primaryColor: Colors.white,
//         backgroundColor: const Color(0xffF1F5FB),
//         indicatorColor: const Color(0xffCBDCF8),
//         hintColor: const Color(0xffEECED3),
//         highlightColor: const Color(0xffFCE192),
//         hoverColor: const Color(0xff4285F4),
//         focusColor: const Color(0xffA8DAB5),
//         disabledColor: Colors.grey,
//         cardColor: Colors.white,
//         canvasColor: Colors.grey[50],
//         brightness: Brightness.light,
//         buttonTheme: Theme.of(context)
//             .buttonTheme
//             .copyWith(colorScheme: ColorScheme.light()),
//         appBarTheme: AppBarTheme(
//           elevation: 0.0,
//         ),
//         iconTheme: Theme.of(context).iconTheme.copyWith(size: 25));
//   }
// }

Color firstColor = Colors.redAccent; // Color(0xFF7A36DC);
Color secondColor = Colors.redAccent.withOpacity(0.5);
Color thirdColor = Colors.redAccent.withOpacity(0.2);

final appTheme = ThemeData(
  primarySwatch: Colors.blue,
);

class AppTheme {
  AppTheme._();
  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        color: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.black,
      textTheme: TextTheme(
        bodyText2: TextStyle(
          color: Colors.black,
        ),
      ),
      buttonTheme: ButtonThemeData(buttonColor: Colors.black));
  static final darkTheme = ThemeData(
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Color(0xFF141221),
      // Colors.black,
      // Color(0xFF192734),
      appBarTheme: AppBarTheme(
        color: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      textTheme: TextTheme(
        bodyText2: TextStyle(
          color: Colors.white,
        ),
      ),
      buttonTheme: ButtonThemeData(buttonColor: Colors.white));
}
