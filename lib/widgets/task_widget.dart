import 'package:flutter/material.dart';
import 'package:todo_app_task/constants.dart';
import 'package:todo_app_task/models/task_model.dart';

class TaskWidget extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onDelete;
  final VoidCallback onToggleCompletion;

  const TaskWidget({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onToggleCompletion,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: task.isCompleted ? 0.5 : 1.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: kPrimaryColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          onTap: onToggleCompletion,
          title: Text(
            task.title,
            style: TextStyle(
              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(task.category),
          trailing: IconButton(
            onPressed: onDelete,
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
