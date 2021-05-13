import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:withu_todo/crud/task_crud.dart';
import 'package:withu_todo/model/task.dart';

import '../util.dart';

class TodoProvider with ChangeNotifier {
  late StreamSubscription<QuerySnapshot<Object?>> taskSubscription;
  List<Task>? tasks;

  TodoProvider() {
    init();
  }

  init() async {
    taskSubscription = taskStream.listen((snapshot) {
      tasks = List.from(snapshot.docs.asMap().entries.map((entry) {
        Map<String, dynamic> json = entry.value.data() as Map<String, dynamic>;
        if (json['id'] == null) json['id'] = entry.value.id;
        return Task.fromJson(json);
      }));
      notifyListeners();
    });
  }

  void delete(Task task) async {
    bool isDeleted = await deleteTask(task.id!);
    if (isDeleted) {
      Get.back();
      showToast("Task removed",
          icon: Icon(
            Icons.do_disturb_on_outlined,
            color: Colors.red,
          ));
    }
  }

  void toggleCompleteAndSave(Task task, bool isCompleted) async {
    task.toggleComplete();
    bool isUpdated = await addOrUpdateTask(task);
    if (isUpdated) {
      Get.back();
      showToast(isCompleted ? "Task marked complete" : "Task marked incomplete",
          icon: Icon(
            Icons.done_outline_rounded,
            color: Colors.green,
          ));
    }
  }

  @override
  void dispose() {
    taskSubscription.cancel();
    super.dispose();
  }
}
