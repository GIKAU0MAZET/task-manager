import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_taskmanager/screens/task/model/task_model.dart';
import 'package:fb_taskmanager/screens/task/repository/task_repository_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract final class _FirestoreKey {
  static const String tasks = 'tasks';
}

final class TaskRepository implements ITaskRepository {
  final FirebaseFirestore _firestore;
  final User _user;

  TaskRepository({required FirebaseFirestore firestore, required User user})
      : _firestore = firestore,
        _user = user;

  CollectionReference<Map<String, dynamic>> get _taskCollection =>
      _firestore.collection(_FirestoreKey.tasks);

  @override
  Future<void> addTask(TaskModel task) async {
    try {
      final jsonData = task.toMap()..remove('id');
      await _taskCollection.add({...jsonData, 'userId': _user.uid});
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteTask(String taskId) async {
    try {
      await _taskCollection.doc(taskId).delete();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TaskModel> getTaskById(String taskId) async {
    try {
      final document = await _taskCollection.doc(taskId).get();
      final id = document.id;
      final data = document.data()!;
      final jsonData = {...data, 'id': id};

      final task = TaskModel.fromMap(jsonData);
      return task;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    try {
      final querySnapshot =
          await _taskCollection.where('userId', isEqualTo: _user.uid).get();

      final taskList = querySnapshot.docs.map((document) {
        final documetnId = document.id;
        final jsonData = {...document.data(), 'id': documetnId};
        return TaskModel.fromMap(jsonData);
      }).toList();

      return taskList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    try {
      await _taskCollection.doc(task.id).update(task.toMap());
    } catch (e) {
      rethrow;
    }
  }
}
