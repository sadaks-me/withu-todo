import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:withu_todo/view/pages/all_tasks_screen.dart';
import 'package:withu_todo/view/pages/task_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentIndex == 0 ? 'All Tasks' : 'Completed Tasks'),
      ),
      body: IndexedStack(
        children: [
          AllTasksScreen(),
          AllTasksScreen(
            isCompletedTasks: true,
          )
        ],
        index: _currentIndex,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Get.to(() => TaskPage(),
            transition: Transition.downToUp, fullscreenDialog: true),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'All Tasks',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Completed Tasks',
          ),
        ],
      ),
    );
  }
}
