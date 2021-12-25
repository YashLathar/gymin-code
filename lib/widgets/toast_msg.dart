import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future aShowToast({required String msg}) {
  return Fluttertoast.showToast(
    msg: msg,
    backgroundColor: Colors.black54,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT
    );
}