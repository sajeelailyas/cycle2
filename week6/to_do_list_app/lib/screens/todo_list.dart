import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../widgets/task_tile.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final taskController = TextEditingController();

    void _addTask() {
      final task = taskController.text.trim();
      if (task.isNotEmpty) {
        taskProvider.addTask(task);
        taskController.clear();
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: const InputDecoration(
                      labelText: 'Enter new task',
                    ),
                    onSubmitted: (_) => _addTask(),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addTask,
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<TaskProvider>(
              builder: (context, provider, child) {
                final tasks = provider.tasks;
                return tasks.isEmpty
                    ? const Center(
                        child: Text(
                          'No tasks added yet.',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      )
                    : ListView.separated(
                        itemCount: tasks.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 4),
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: TaskTile(
                            task: tasks[index],
                            onDelete: () => provider.removeTask(index),
                          ),
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
