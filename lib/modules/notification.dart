import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Alert {
  Alert(this.context);

  final BuildContext context;

  showSnackbar(String message,
      {toast = Toast.LENGTH_LONG,
      gravity = ToastGravity.TOP,
      Color backgroundColor = Colors.black87,
      Color textColor = Colors.white,
      double fontSize = 16.0}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: toast,
      gravity: gravity, // This makes it appear at the top
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
    );
  }

  // showSnackbar(String message) {
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(SnackBar(content: Text(message)));
  // }

  // static showAlert(String title, String desc, showProgressBar) {
  //   if (navigatorState.context == null) return;
  //   showDialog(
  //       context: navigatorState.context!,
  //       builder: (context) {
  //         return AlertWidget(
  //           title: title,
  //           desc: desc,
  //         );
  //       });
  // }
}
