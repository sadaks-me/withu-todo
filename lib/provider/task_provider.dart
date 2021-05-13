import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:withu_todo/crud/task_crud.dart';
import 'package:withu_todo/model/task.dart';
import 'package:withu_todo/util.dart';

class TaskProvider with ChangeNotifier {
  TaskProvider(Task? originalTask) {
    init(originalTask);
  }

  late Task task;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isCompleted = false;
  bool isLoading = false;

  init(Task? originalTask) async {
    if (originalTask != null) {
      task = originalTask;
      titleController = TextEditingController(text: task.title);
      descriptionController = TextEditingController(text: task.description);
      isCompleted = task.isCompleted;
    } else {
      task = Task();
      titleController = TextEditingController();
      descriptionController = TextEditingController();
    }
  }

  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  toggleComplete(value) {
    isCompleted = value;
    notifyListeners();
  }

  void save() async {
    final FormState form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      setLoading(true);
      task.title = titleController.text.trim();
      task.description = descriptionController.text.trim();
      if (task.completedAt == null && isCompleted)
        task.completedAt = DateTime.now();
      else if (task.completedAt != null && !isCompleted)
        task.completedAt = null;
      bool isAdded = await addOrUpdateTask(task);
      if (isAdded) {
        Get.back();
        showToast("Task added",
            icon: Icon(
              Icons.done_outline_rounded,
              color: Colors.green,
            ));
      } else
        showToast("Something went wrong, please try again");
      setLoading(false);
    }
  }
}
