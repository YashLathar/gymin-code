import 'dart:ui';

import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(BuildContext context) {
    return ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.white,
        backgroundColor: const Color(0xffF1F5FB),
        indicatorColor: const Color(0xffCBDCF8),
        buttonColor: const Color(0xffF1F5FB),
        hintColor: const Color(0xffEECED3),
        highlightColor: const Color(0xffFCE192),
        hoverColor: const Color(0xff4285F4),
        focusColor: const Color(0xffA8DAB5),
        disabledColor: Colors.grey,
        cardColor: Colors.white,
        canvasColor: Colors.grey[50],
        brightness: Brightness.light,
        buttonTheme: Theme.of(context)
            .buttonTheme
            .copyWith(colorScheme: ColorScheme.light()),
        appBarTheme: AppBarTheme(
          elevation: 0.0,
        ),
        iconTheme: Theme.of(context).iconTheme.copyWith(size: 25));
  }
}
