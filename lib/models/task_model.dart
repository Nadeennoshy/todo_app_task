class TaskModel {
  String title;
  String category;
  bool isCompleted;

  TaskModel(
      {required this.title, required this.category, this.isCompleted = false});
}
