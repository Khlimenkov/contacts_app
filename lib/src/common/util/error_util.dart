import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart' show BuildContext, Colors, ScaffoldMessenger, SnackBar, Text;
import 'package:l/l.dart';

/// Error util.
sealed class ErrorUtil {
  static Future<void> logError(
    Object exception,
    StackTrace stackTrace, {
    String? hint,
    bool fatal = false,
  }) async {
    try {
      if (exception is String) {
        return await logMessage(
          exception,
          stackTrace: stackTrace,
          hint: hint,
          warning: true,
        );
      }
      l.e(exception, stackTrace);
    } on Object catch (error, stackTrace) {
      l.e(
        'Error while logging error "$error" inside ErrorUtil.logError',
        stackTrace,
      );
    }
  }

  static Future<void> logMessage(
    String message, {
    StackTrace? stackTrace,
    String? hint,
    bool warning = false,
  }) async {
    try {
      l.e(message, stackTrace ?? StackTrace.current);
    } on Object catch (error, stackTrace) {
      l.e(
        'Error while logging error "$error" inside ErrorUtil.logMessage',
        stackTrace,
      );
    }
  }

  static Never throwWithStackTrace(Object error, StackTrace stackTrace) => Error.throwWithStackTrace(error, stackTrace);

  static String formatMessage(
    Object error, [
    String fallback = 'An error has occurred',
  ]) =>
      switch (error) {
        String e => e,
        FormatException _ => 'Invalid format',
        TimeoutException _ => 'Timeout exceeded',
        UnimplementedError _ => 'Not implemented yet',
        UnsupportedError _ => 'Unsupported operation',
        FileSystemException _ => 'File system error',
        AssertionError _ => 'Assertion error',
        Error _ => 'An error has occurred',
        Exception _ => 'An exception has occurred',
        _ => fallback,
      };

  static void showSnackBar(BuildContext context, Object message) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(formatMessage(message)),
          backgroundColor: Colors.red,
        ),
      );
}
