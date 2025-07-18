import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class AddTaskScreen extends StatelessWidget {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Task")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: "Task Title"),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_controller.text.trim().isNotEmpty) {
                Provider.of<TaskProvider>(context, listen: false)
                    .addTask(_controller.text.trim());
                Navigator.pop(context);
              }
            },
            child: const Text("Add Task"),
          )
        ]),
      ),
    );
  }
}
