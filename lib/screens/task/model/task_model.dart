// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final String userId;
  final DateTime dueDate;

  TaskModel({
    this.id = '',
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.userId = '',
    required this.dueDate,
  });

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    String? userId,
    DateTime? dueDate,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      userId: userId ?? this.userId,
      dueDate: dueDate ?? this.dueDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'userId': userId,
      'dueDate': DateTime(dueDate.year, dueDate.month, dueDate.day)
          .millisecondsSinceEpoch,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
      return TaskModel(
        id: map['id'] as String,
        title: map['title'] as String,
        description: map['description'] as String,
        isCompleted: map['isCompleted'] as bool,
        userId: map['userId'] as String,
        dueDate: DateTime.fromMillisecondsSinceEpoch(map['dueDate']),                
      );
    }

    String toJsom() => json.encode(toMap());

    factory TaskModel.fromJson(String source) => TaskModel.fromMap(json.decode(source) as Map<String,dynamic>);

    @override
    String toString() {
      return 'TaskModel(id: $id, title: $title, description: $description, isCompleted: $isCompleted, userId: $userId)';
    }

    @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
    other.title == title &&
    other.description == description &&
    other.isCompleted == isCompleted &&
    other.userId == userId;
  }

    @override
    int get hashCode {
      return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        isCompleted.hashCode ^
        userId.hashCode;
    }
}
