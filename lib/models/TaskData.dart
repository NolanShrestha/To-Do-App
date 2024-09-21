import 'package:flutter/material.dart';
import 'package:untitled/widgets/CustomTaskList.dart';

class TaskData extends ChangeNotifier {
  final List<CustomTaskList> _tasks = [];

  List<CustomTaskList> get savedTasks => _tasks;

  int get taskCount {
    return _tasks.length;
  }

  void addTask(CustomTaskList list) {
    _tasks.add(list);
    notifyListeners();
  }

  void removeTask(String title) {
    _tasks.removeWhere((task) => task.title == title); // Remove by title
    notifyListeners(); // Notify listeners to update UI
  }
}
