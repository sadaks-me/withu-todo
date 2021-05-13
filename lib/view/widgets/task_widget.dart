import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:withu_todo/model/task.dart';
import 'package:withu_todo/provider/todo_provider.dart';
import 'package:withu_todo/view/pages/task_page.dart';

class TaskWidget extends StatelessWidget {
  TaskWidget(this.task);

  final Task task;

  @override
  Widget build(BuildContext context) {
    var todoProvider = Provider.of<TodoProvider>(context, listen: false);
    return Slidable(
      key: UniqueKey(),
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        constraints: BoxConstraints(minHeight: 70),
        alignment: Alignment.center,
        child: ListTile(
          leading: Checkbox(
            value: task.isCompleted,
            activeColor: Colors.pink,
            onChanged: (value) =>
                todoProvider.toggleCompleteAndSave(task, value!),
          ),
          title: Text(task.title!),
          subtitle:
              task.description!.isNotEmpty ? Text(task.description!) : null,
          onTap: () => Get.to(() => TaskPage(task: task)),
        ),
      ),
      secondaryActions: [
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => todoProvider.delete(task),
        )
      ],
    );
  }
}
