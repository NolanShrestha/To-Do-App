import 'package:flutter/material.dart';
import 'package:untitled/widgets/CustomTaskList.dart';

class TaskData extends ChangeNotifier {
  final List<CustomTaskList> _tasks = [];

  List<CustomTaskList> get savedTasks => _tasks;

  int get taskCount => _tasks.length;

  // void editTaskName(String oldTaskName, String newTaskName) {
  //   int taskIndex =
  //   savedTasks.indexWhere((task) => task.title == oldTaskName);
  //   if (taskIndex != -1) {
  //     savedTasks[taskIndex].title = newTaskName;
  //     notifyListeners();
  //   }
  // }

  void editTask(String oldTitle, String newTitle, String newBody, String newDate) {
    int taskIndex = _tasks.indexWhere((task) => task.title == oldTitle);
    if (taskIndex != -1) {
      // Create a new task with the updated properties
      final updatedTask = CustomTaskList(
        title: newTitle,
        body: newBody,
        date: newDate,
      );

      _tasks[taskIndex] = updatedTask; // Update the task in the list
      notifyListeners();
    }
  }

  void addTask(CustomTaskList list) {
    _tasks.add(list);
    notifyListeners();
  }

  void removeTask(String title) {
    _tasks.removeWhere((task) => task.title == title);
    notifyListeners();
  }
}
