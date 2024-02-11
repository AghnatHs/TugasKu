import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationScreen extends ConsumerWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(child: TextButton(onPressed: () => Navigator.pop(context), child: Text('go back\nstill in development')),);
  }
}
