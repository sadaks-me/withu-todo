import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:withu_todo/model/task.dart';
import 'package:withu_todo/provider/todo_provider.dart';
import 'package:withu_todo/util.dart';
import 'package:withu_todo/view/widgets/task_widget.dart';

class AllTasksScreen extends StatelessWidget {
  const AllTasksScreen({Key? key, this.isCompletedTasks = false})
      : super(key: key);

  final bool isCompletedTasks;

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, todoProvider, child) => LayoutBuilder(
        builder: (context, _) {
          if (todoProvider.tasks != null) {
            List<Task> tasks = todoProvider.tasks!
                .where((t) => isCompletedTasks ? t.isCompleted : true)
                .toList();
            if (tasks.isEmpty)
              return Center(
                child: Text(
                    isCompletedTasks ? 'No completed task' : 'Add new task'),
              );
            else
              return ListView(
                children: ListTile.divideTiles(
                        tiles: tasks.map((task) => TaskWidget(task)),
                        color: appTheme.dividerColor)
                    .toList(),
              );
          } else
            return Center(
              child: Text('Fetching tasks...'),
            );
        },
      ),
    );
  }
}
