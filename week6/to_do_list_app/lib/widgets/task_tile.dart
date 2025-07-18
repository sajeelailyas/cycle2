import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String task;
  final VoidCallback onDelete;

  const TaskTile({super.key, required this.task, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(task),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
