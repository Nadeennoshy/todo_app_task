import 'package:flutter/material.dart';
import 'package:todo_app_task/task_cubit/task_cubit.dart';
import 'package:todo_app_task/views/home_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_task/views/onboarding_view.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: OnboardingView(),
      ),
    );
  }
}
