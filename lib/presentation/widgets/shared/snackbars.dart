import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
SnackBar customSnackbar(String messages, {int? duration, SnackBarAction? action}) {
  return SnackBar(
    actionOverflowThreshold: 1,
    behavior: SnackBarBehavior.floating,
    content: Text(messages),
    duration: Duration(seconds: duration ?? 1),
    action: action,
  );
}