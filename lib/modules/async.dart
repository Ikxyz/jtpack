import 'dart:io';

import 'package:dio/dio.dart';

import 'log.dart';

typedef AsyncTask<T> = Future<T> Function();

class AsyncHandler<T> {
  static Future<T> httpRequest<T>(AsyncTask<T> task) async {
    try {
      // Async Task
      return await task();
    } on DioException catch (dioErr) {
      if (dioErr.type == DioExceptionType.unknown) {
        throw Log("unable to reach server at the moment, try again",
                code: dioErr.response?.statusCode ?? 400,
                logType: LogType.network)
            .log();
      }
      if (dioErr.type == DioExceptionType.badResponse) {
        throw Log(dioErr.response!.data?['message'],
                code: dioErr.response?.statusCode ?? 400,
                logType: LogType.network)
            .log();
      }
      throw Log(dioErr.response!.statusMessage ?? "network error",
              code: dioErr.response?.statusCode ?? 400, logType: LogType.failed)
          .log();
    } on SocketException catch (_) {
      throw Log("check network and try again",
              code: 400, logType: LogType.network)
          .log();
    } on Log catch (_) {
      rethrow;
    } catch (err) {
      throw Log("error occurred processing request, $err",
              code: 400, logType: LogType.runtime)
          .log();
    }
  }
}
