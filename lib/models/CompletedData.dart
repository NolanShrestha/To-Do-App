import 'package:flutter/material.dart';
import 'package:untitled/widgets/CustomCompleted.dart';

class CompletedData extends ChangeNotifier {
  final List<CustomCompleted> _tasks = [];

  List<CustomCompleted> get savedTasks => _tasks;

  int get taskCount {
    return _tasks.length;
  }

  void addTask(CustomCompleted list) {
    _tasks.add(list);
    notifyListeners();
  }
}
