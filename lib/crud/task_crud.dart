import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:withu_todo/model/task.dart';

import '../util.dart';

FirebaseFirestore get fireStore => FirebaseFirestore.instance;

CollectionReference get tasksRef =>
    FirebaseFirestore.instance.collection('sadaks_tasks');

Stream<QuerySnapshot<Object?>> get taskStream => tasksRef.snapshots();

Future<bool> addOrUpdateTask(Task task) async {
  if (task.isNew)
    return await tasksRef
        .add(task.toJson())
        .then((value) => true)
        .catchError((error) {
      debugPrint("Failed to add task: $error");
      showToast("Something went wrong, please try again");
      return false;
    });
  else
    return await tasksRef
        .doc(task.id)
        .update(task.toJson())
        .then((value) => true)
        .catchError((error) {
      debugPrint("Failed to update task: $error");
      showToast("Something went wrong, please try again");
      return false;
    });
}

Future<bool> deleteTask(String id) async =>
    await tasksRef.doc(id).delete().then((value) => true).catchError((error) {
      debugPrint("Failed to delete task: $error");
      showToast("Something went wrong, please try again");
      return false;
    });
