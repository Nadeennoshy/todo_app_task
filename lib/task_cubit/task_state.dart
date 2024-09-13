part of 'task_cubit.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

class TaskSuccessState extends TaskState {
  final List<TaskModel> tasks;

  TaskSuccessState(this.tasks);
}
