import 'package:flutter/material.dart';

class Alert {
  Alert(this.context);

  final BuildContext context;

  showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

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
