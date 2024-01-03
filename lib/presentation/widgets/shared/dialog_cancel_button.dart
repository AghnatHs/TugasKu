import 'package:flutter/material.dart';

class DialogCancelButton extends StatelessWidget {
  final BuildContext ctx;
  final String? text;
  const DialogCancelButton({Key? key, required this.ctx, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pop(ctx),
      child: Text(text ?? 'CANCEL'),
    );
  }
}
