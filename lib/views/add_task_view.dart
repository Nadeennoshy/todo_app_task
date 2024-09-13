import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_task/constants.dart';
import 'package:todo_app_task/task_cubit/task_cubit.dart';
import 'package:todo_app_task/widgets/custom_button.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final TextEditingController addTaskController = TextEditingController();

  String selectedCategory = 'Personal';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: const Text(
          'Add Task',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 80, left: 16.0, right: 16.0),
        child: Column(
          children: [
            TextField(
              controller: addTaskController,
              decoration: InputDecoration(
                hintText: 'Title',
                label: const Text('Title'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white70,
                hintStyle: TextStyle(
                  color: Colors.grey[800],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButton<String>(
              value: selectedCategory,
              items: <String>[
                'Personal',
                'Work',
                'Shopping',
                'Health',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue!;
                });
              },
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
                onPressed: () {
                  if (addTaskController.text.isNotEmpty) {
                    context.read<TaskCubit>().addTask(
                          addTaskController.text,
                          selectedCategory,
                        );
                    Navigator.pop(context); // Go back to HomeView
                  }
                },
                buttonText: 'Add'),
          ],
        ),
      ),
    );
  }
}
