import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_task/constants.dart';
import 'package:todo_app_task/task_cubit/task_cubit.dart';
import 'package:todo_app_task/task_filter.dart';
import 'package:todo_app_task/views/add_task_view.dart';
import 'package:todo_app_task/widgets/task_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddTaskView();
          }));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: const Text(
          'Todo List',
          style: TextStyle(color: Colors.white),
        ),
         actions: [
          PopupMenuButton<TaskFilter>(
            onSelected: (filter) {
              context.read<TaskCubit>().filterTasks(filter);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<TaskFilter>>[
                const PopupMenuItem<TaskFilter>(
                  value: TaskFilter.all,
                  child: Text('All Tasks'),
                ),
                const PopupMenuItem<TaskFilter>(
                  value: TaskFilter.completed,
                  child: Text('Completed Tasks'),
                ),
                const PopupMenuItem<TaskFilter>(
                  value: TaskFilter.incomplete,
                  child: Text('Incomplete Tasks'),
                ),
              ];
            },
            icon: const Icon(Icons.filter_list, color: Colors.white), // Change icon color
            color: Colors.white,
          ),
        ],
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskSuccessState) {
            if (state.tasks.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/note.png', height: 200),
                    const SizedBox(height: 20),
                    const Text(
                      'No tasks available',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(state.tasks[index].title), // Unique key for each task
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    context.read<TaskCubit>().deleteTask(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${state.tasks[index].title} deleted'),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TaskWidget(
                      task: state.tasks[index],
                      onDelete: () {
                        context.read<TaskCubit>().deleteTask(index);
                      },
                      onToggleCompletion: () {
                        context.read<TaskCubit>().toggleTaskCompletion(index);
                      },
                    ),
                  ),
                );
              },
            );
          }
          return Container(); // Handle other states if necessary
        },
      ),
    );
  }
}