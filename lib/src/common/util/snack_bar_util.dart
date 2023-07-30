import 'package:flutter/material.dart';

sealed class SnackBarUtil {
  static void showSnackBarMessage(BuildContext context, {required String message, bool clearPreviouses = true}) {
    if (clearPreviouses) {
      ScaffoldMessenger.of(context).clearSnackBars();
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
