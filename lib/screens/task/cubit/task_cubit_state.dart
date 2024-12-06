import 'package:fb_taskmanager/screens/task/model/task_model.dart';

abstract interface class TaskCubitState {}

final class TaskStateLoading implements TaskCubitState {}

final class TaskStateSuccess implements TaskCubitState {
  final List<TaskModel> taskList;

  TaskStateSuccess({required this.taskList});
}

final class TaskStateFailure implements TaskCubitState {
  final Object? error;

  TaskStateFailure({required this.error});
}