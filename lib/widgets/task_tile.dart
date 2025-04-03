import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onDelete;

  TaskTile({required this.task, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        title: Text(task.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(task.description, style: TextStyle(fontSize: 14)),
        trailing: Checkbox(
          value: task.isCompleted,
          onChanged: (bool? value) {},
        ),
        leading: Icon(Icons.check_circle_outline, color: Colors.teal),
        onLongPress: onDelete,
      ),
    );
  }
}
