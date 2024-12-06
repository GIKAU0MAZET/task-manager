import 'package:fb_taskmanager/screens/task/cubit/task_cubit_state.dart';
import 'package:fb_taskmanager/screens/task/model/task_model.dart';
import 'package:fb_taskmanager/screens/task/repository/task_repository_interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskCubit extends Cubit<TaskCubitState> {
  final ITaskRepository _taskRepository;

  TaskCubit(this._taskRepository) : super(TaskStateLoading()) {
    loadTasks();
  }

  static TaskCubit i(BuildContext context) => context.read<TaskCubit>();

  Future<void> loadTasks({bool withReload = true}) async {
    if (withReload) emit(TaskStateLoading());
    try {
      final taskList = await _taskRepository.getTasks();
      emit(TaskStateSuccess(taskList: taskList));
    } catch (e) {
      emit(TaskStateFailure(error: e));
    }
  }

  Future<void> createTask(TaskModel task) async {
    emit(TaskStateLoading());
    try {
      await _taskRepository.addTask(task);
      await loadTasks(withReload: false);
    } catch (e) {
      emit(TaskStateFailure(error: e));
    }
  }

  Future<void> removeTask(TaskModel task) async {
    try {
      await _taskRepository.deleteTask(task.id);
      await loadTasks(withReload: false);
    } catch (e) {
      emit(TaskStateFailure(error: e));
    }
  }

  Future<void> changeCompleteStatusTask(TaskModel task) async {
    try {
      await _taskRepository.updateTask(
        task.copyWith(isCompleted: !task.isCompleted),
      );
      loadTasks(withReload: false);
    } catch (e) {
      emit(TaskStateFailure(error: e));
    }
  }
}
