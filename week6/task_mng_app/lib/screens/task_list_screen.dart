import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import 'add_task_screen.dart';

class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Task Manager")),
      body: ListView.builder(
        itemCount: taskProvider.tasks.length,
        itemBuilder: (ctx, index) {
          final task = taskProvider.tasks[index];
          return ListTile(
            title: Text(
              task.title,
              style: TextStyle(
                decoration: task.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              IconButton(
                icon: Icon(task.isCompleted ? Icons.check_box : Icons.check_box_outline_blank),
                onPressed: () => taskProvider.toggleCompletion(task.id),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => taskProvider.deleteTask(task.id),
              ),
            ]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => AddTaskScreen())),
        child: const Icon(Icons.add),
      ),
    );
  }
}
