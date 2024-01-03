import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/notifier/task_view_notifier.dart';
import 'package:todo_app/presentation/screens/screens.dart';
import 'package:todo_app/services/ui/dialog_services.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends ConsumerState<MainScreen> {
  int currentPageIndex = 1;
  List<Widget> screens = [
    const InfoScreen(),
    const HomeScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    int allTasksLength = ref.watch(taskViewNotifierProvider).length;
    return Scaffold(
      floatingActionButton: currentPageIndex == 2
          ? null
          : FloatingActionButton(
              onPressed: () => DialogServices.pushTaskDialog(context),
              child: const Icon(Icons.add),
            ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: screens[currentPageIndex],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            icon: Badge(
              label: Text(allTasksLength.toString()),
              child: const Icon(Icons.checklist),
            ),
            label: 'Tasks',
          ),
          const NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          const NavigationDestination(
            selectedIcon: Icon(Icons.settings_sharp),
            icon: Icon(Icons.settings),
            label: 'Settings',
          )
        ],
      ),
    );
  }
}
