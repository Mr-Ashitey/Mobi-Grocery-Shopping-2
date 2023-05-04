import 'package:flutter/material.dart';

void showNotification(
    {required BuildContext context,
    required String message,
    bool isError = false}) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(SnackBar(
      content: Text(message),
      // behavior: SnackBarBehavior.floating,
      backgroundColor: isError ? Colors.red : Colors.green,
    ));
}
