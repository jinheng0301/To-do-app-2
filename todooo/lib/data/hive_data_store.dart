import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todooo/models/task.dart';


// all the [CRUD] operations for hive db
class HiveDataStore {
  // Box name
  static const boxName = 'taskBox';

  // current box with all the saved data inside - Box<Task>
  final Box<Task> box = Hive.box<Task>(boxName);

  // add new task to box
  Future<void> addTask({required Task task}) async {
    await box.put(task.id, task);
  }

  // show task
  Future<void> getTask({required String id}) async {
    await box.get(id);
  }

  // update task
  Future<void> updateTask({required Task task}) async {
    await task.save();
  }

  // delete task
  Future<void> deleteTask({required Task task}) async {
    await task.delete();
  }

  // listen to box changes
  // this method will listen to box changes and update the UI accordingly.
  ValueListenable<Box<Task>> listenToTask() => box.listenable();
}
