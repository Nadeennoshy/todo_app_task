import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app_task/models/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial()){
    loadTasks();
  }

   Future<void> loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tasksJson = prefs.getString('tasks');
    List<TaskModel> tasks = [];

    if (tasksJson != null) {
      List<dynamic> jsonList = json.decode(tasksJson);
      tasks = jsonList.map((json) => TaskModel(
        title: json['title'],
        isCompleted: json['isCompleted'],
        category: json['category'],
      )).toList();
    }
    
    emit(TaskSuccessState(tasks));
  }

  
 
  Future<void> saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tasksJson = json.encode((state as TaskSuccessState).tasks.map((task) => {
      'title': task.title,
      'isCompleted': task.isCompleted,
      'category': task.category,
    }).toList());
    prefs.setString('tasks', tasksJson);
  }

  void addTask(String title, String category) {
    List<TaskModel> updatedTasks = List.from((state as TaskSuccessState).tasks);
    updatedTasks.add(TaskModel(title: title, category: category));
    emit(TaskSuccessState(updatedTasks));
    saveTasks();
  }

    void toggleTaskCompletion(int index) {
    List<TaskModel> updatedTasks = List.from((state as TaskSuccessState).tasks);
    updatedTasks[index].isCompleted = !updatedTasks[index].isCompleted;
    emit(TaskSuccessState(updatedTasks));
    saveTasks();
  }

    void deleteTask(int index) {
    List<TaskModel> updatedTasks = List.from((state as TaskSuccessState).tasks);
    updatedTasks.removeAt(index);
    emit(TaskSuccessState(updatedTasks));
    saveTasks();
  }
}
