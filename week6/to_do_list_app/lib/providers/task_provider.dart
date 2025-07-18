import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskProvider with ChangeNotifier {
  final List<String> _tasks = [];
  List<String> get tasks => _tasks;

  static const String tasksKey = 'tasks';

  TaskProvider() {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTasks = prefs.getStringList(tasksKey);
    if (savedTasks != null) {
      _tasks.addAll(savedTasks);
      notifyListeners();
    }
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(tasksKey, _tasks);
  }

  void addTask(String task) {
    _tasks.add(task);
    _saveTasks();
    notifyListeners();
  }

  void removeTask(int index) {
    _tasks.removeAt(index);
    _saveTasks();
    notifyListeners();
  }
}
