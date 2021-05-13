import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:withu_todo/model/task.dart';
import 'package:withu_todo/provider/task_provider.dart';

import '../../util.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({Key? key, this.task}) : super(key: key);

  final Task? task;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: TaskProvider(task),
      child: Consumer<TaskProvider>(
          builder: (context, taskProvider, __) => Stack(
                children: [
                  Scaffold(
                    appBar: AppBar(
                      title: Text(task == null ? 'New Task' : 'Edit Task'),
                    ),
                    body: SafeArea(
                      child: Container(
                        padding: const EdgeInsets.all(padding),
                        child: Form(
                          key: taskProvider.formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: taskProvider.titleController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Title*',
                                ),
                                validator: (value) =>
                                    validateField('Title', value!),
                              ),
                              SizedBox(height: padding),
                              TextFormField(
                                controller: taskProvider.descriptionController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Description',
                                ),
                                minLines: 5,
                                maxLines: 10,
                              ),
                              SizedBox(height: padding),
                              ListTile(
                                title: Text(taskProvider.task.isCompleted
                                    ? 'Completed at'
                                    : 'Complete'),
                                subtitle: taskProvider.task.isCompleted
                                    ? Text(DateFormat('EEE, MMM d, h:mm a')
                                        .format(taskProvider.task.completedAt!))
                                    : null,
                                trailing: CupertinoSwitch(
                                    value: taskProvider.isCompleted,
                                    onChanged: taskProvider.toggleComplete),
                              ),
                              Spacer(),
                              if (!taskProvider.isLoading)
                                ElevatedButton(
                                  onPressed: taskProvider.save,
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.pink),
                                  child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    alignment: Alignment.center,
                                    child: Text(taskProvider.task.isNew
                                        ? 'Create'
                                        : 'Update'),
                                  ),
                                )
                              else
                                ElevatedButton(
                                  onPressed: null,
                                  child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    child: CupertinoActivityIndicator(
                                      radius: 12,
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
    );
  }
}
