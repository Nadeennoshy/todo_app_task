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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: kPrimaryColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onToggleCompletion, // This should be called on tap
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
    );
  }
}








// import 'package:flutter/material.dart';
// import 'package:todo_app_task/constants.dart';
// import 'package:todo_app_task/models/task_model.dart';

// class TaskWidget extends StatelessWidget {
//   const TaskWidget(
//       {super.key,
//       required this.task,
//       required this.onDelete,
//       required this.onToggleCompletion});
//   final TaskModel task;
//   final VoidCallback onDelete;
//   final VoidCallback onToggleCompletion;

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(task.title),
//       subtitle: Text(task.category),
//       trailing: IconButton(
//           onPressed: onDelete,
//           icon: const Icon(
//             Icons.delete,
//             color: Colors.red,
//           )),
//       onTap: onToggleCompletion,
//     );
//   }
// }
