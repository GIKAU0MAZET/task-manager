import 'package:fb_taskmanager/screens/settings/settings_screen.dart';
import 'package:fb_taskmanager/screens/task/cubit/task_cubit.dart';
import 'package:fb_taskmanager/screens/task/cubit/task_cubit_state.dart';
import 'package:fb_taskmanager/screens/task/pages/new_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  static const String path = '/task';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: IconButton(
            onPressed: () => context.go(NewTaskScreen.path),
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
        ),
        title: const Text('Задачи'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => TaskCubit.i(context).loadTasks(),
            icon: const Icon(Icons.replay),
          ),
          IconButton(
            onPressed: () => context.go(SettingsScreen.path),
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: BlocBuilder<TaskCubit, TaskCubitState>(
        builder: (context, state) {
          if (state is TaskStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TaskStateSuccess) {
            if (state.taskList.isEmpty) {
              return const Center(
                child: Text('Список задач пуст!'),
              );
            }
            return ListView.builder(
                itemCount: state.taskList.length,
                itemBuilder: (context, index) {
                  final task = state.taskList[index];
                  return ListTile(
                    leading: Checkbox(
                      value: task.isCompleted,
                      onChanged: (v) =>
                          TaskCubit.i(context).changeCompleteStatusTask(task),
                    ),
                    title: Text(task.title),
                    subtitle: Text(task.description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          DateFormat.MMMMEEEEd().format(task.dueDate),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => TaskCubit.i(context).removeTask(task),
                        ),
                      ],
                    ),
                  );
                });
          }
          if (state is TaskStateFailure) {
            return Center(
              child: Text('Ошибка: ${state.error}'),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}