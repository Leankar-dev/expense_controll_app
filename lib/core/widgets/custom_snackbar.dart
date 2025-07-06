import 'package:flutter/material.dart';

void showCustomSnackbar(
  BuildContext context,
  String message, {
  Color backgroundColor = const Color(0xFF081F5C),
  Duration duration = const Duration(seconds: 2),
}) {
  ScaffoldMessenger.of(context).clearSnackBars();

  final snackBar = SnackBar(
    content: Text(message, style: const TextStyle(color: Colors.white)),
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    duration: duration,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
