import 'package:flutter/material.dart';
import 'package:todo_app/presentation/widgets/shared/snackbars.dart';

class SnackbarServices {
  static void pushSnackbar(BuildContext context, String msg,
      {int? duration, SnackBarAction? action}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(customSnackbar(msg, duration: duration, action: action));
  }
}
