import "dart:convert";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:jtpack/config.dart";
import "package:jtpack/jtpack.dart";

import "notification.dart";

enum LogType { network, input, failed, runtime, info, success, warning }

class Log {
  String message;
  int code = 100;
  LogType logType;
  final bool canDebugPrint = kDebugMode;

  Log(this.message, {this.code = 400, this.logType = LogType.info});

  Log log() {
    if (canDebugPrint) {
      debugPrint("Log-$code: $message");
    }
    return this;
  }

  Color color() {
    if (logType == LogType.failed) return Colors.red;
    if (logType == LogType.network) return Colors.green;

    return Colors.yellow;
  }

  IconData icon() {
    if (logType == LogType.failed) return Icons.alarm;
    if (logType == LogType.network) return Icons.cancel;

    return Icons.ac_unit;
  }

  Log show([BuildContext? context]) {
    context ??= navigatorGlobalKey.currentState?.context;
    if (context != null && context.mounted) {
      if (code >= 500) {
        return Alert(context).showSnackbar(message,
            toast: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.red);
      } else if (code == 400) {
        return Alert(context).showSnackbar(message,
            toast: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.amber);
      } else if (code == 200) {
        return Alert(context).showSnackbar(message,
            toast: Toast.LENGTH_LONG,
            textColor: Colors.white,
            backgroundColor: Colors.blue);
      }
      return Alert(context).showSnackbar(message, toast: Toast.LENGTH_LONG);
    }
    return this;
  }

  Log copyWith({
    String? message,
    int? code,
    bool? canDebugPrint,
  }) {
    return Log(message ?? this.message, code: code ?? this.code);
  }

  Map<String, dynamic> toMap() {
    return {
      "message": message,
      "code": code,
      "canDebugPrint": canDebugPrint,
    };
  }

  factory Log.fromMap(Map<String, dynamic> map) {
    return Log(map["message"], code: map["code"]);
  }

  factory Log.fromObject(Object? obj, {code = 400, logType = LogType.info}) {
    // if (obj is Null) return Log("Unknown Error Occurred", code: 400);
    if (obj is String) {
      return Log(obj.toString(), code: 400);
    }
    if (obj is Log) {
      return obj;
    }
    return Log(obj.toString(), code: code, logType: logType);
  }

  String toJson() => json.encode(toMap());

  factory Log.fromJson(String source) => Log.fromMap(json.decode(source));

  @override
  String toString() =>
      "Log(message: $message, code: $code, canDebugPrint: $canDebugPrint)";

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Log &&
        other.message == message &&
        other.code == code &&
        other.canDebugPrint == canDebugPrint;
  }

  @override
  int get hashCode => message.hashCode ^ code.hashCode ^ canDebugPrint.hashCode;
}
