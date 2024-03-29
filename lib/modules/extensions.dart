import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:jtpack/modules/utils.dart';
import 'package:flutter/material.dart';

import '../config.dart';

final _moneyFormat = NumberFormat("#,##0.00", "en_US");

extension ExString on String {
  /// Capitalize Text
  String get capitalize {
    List<String> strArr = trim().split(" ");

    strArr = strArr.map((e) {
      if (e == "") return "";
      final String index = e[0];
      return e.replaceFirst(index, index.toUpperCase());
    }).toList();

    return strArr.join(" ");
  }

  /// Capitalize Text
  String get fromCamelToCapitalize {
    List<String> strArr = trim().split(" ");

    strArr = strArr.map((e) {
      if (e == "") return "";
      final String index = e[0];
      return e.replaceFirst(index, ' ${index.toUpperCase()}');
    }).toList();

    return strArr.join(" ");
  }

  /// Generate Random String
  String get generateID {
    return generateId(null, 16);
  }

  String get short {
    return "${[...trim().split("").take(6)].join("")}...";
  }

  String get shortDescription {
    return "${[...trim().split("").take(120)].join("")}...";
  }

  /// Mask Email Address
  String get maskedEmail {
    try {
      final emailId = split("@");
      final length = emailId[0].length;

      return "${emailId[0].substring((length ~/ 1.7).toInt())}@${emailId[1]}";
    } catch (err) {
      return "";
    }
  }
}

extension MyContext on BuildContext {
  NavigatorState get navigator => Navigator.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension NumToMoneyFormatExtension on num {
  String toMoney({String? symbol}) {
    symbol ??= "\$";
    return '$symbol ${_moneyFormat.format(this)}';
  }

  double get height =>
      getHeight(navigatorGlobalKey.currentState!.context, toInt());
  double get width =>
      getWidth(navigatorGlobalKey.currentState!.context, toInt());

  Widget get spaceVertical => SizedBox(height: toDouble());
  Widget get spaceHorizontal => SizedBox(width: toDouble());
}

extension MyStateWidget on StatelessWidget {
  BuildContext? get globalContext => navigatorGlobalKey.currentState!.context;
}

extension MyStatefulWidget on StatefulElement {
  BuildContext? get globalContext => navigatorGlobalKey.currentState!.context;
}

extension MyConsumerWidget on ConsumerWidget {
  BuildContext? get globalContext => navigatorGlobalKey.currentState!.context;
}

extension DateTimeExtension on DateTime {
  String get monthInString {
    final dateTime = DateTime.now();
    final month = dateTime.month;

    if (month == 1) return "Jan";
    if (month == 2) return "Feb";
    if (month == 3) return "Mar";
    if (month == 4) return "Apr";
    if (month == 5) return "May";
    if (month == 6) return "Jun";
    if (month == 7) return "Jul";
    if (month == 8) return "Aug";
    if (month == 9) return "Sep";
    if (month == 10) return "Oct";
    if (month == 11) return "Nov";
    if (month == 12) return "Dec";
    return "";
  }

  String get getDateTime {
    final dateTime = this;
    final day = dateTime.day;
    final month = dateTime.monthInString;
    final year = dateTime.year;
    final time = dateTime.hour;
    final min = dateTime.minute;
    return "$month $day, $year | $time:$min";
  }
}
