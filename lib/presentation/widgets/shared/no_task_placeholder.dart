import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/fonts.dart';

class NoTaskPlaceHolder extends StatelessWidget {
  const NoTaskPlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DateFormat('EE, d MMMM').format(DateTime.now()),
                style: GFont.monsterratTitle.copyWith(fontWeight: FontWeight.bold)),
            Expanded(
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/no_task.png',
                    height: 200,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Nothing to do',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
