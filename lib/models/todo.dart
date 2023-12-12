// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Todo {
  String? id;
  String? userId;
  String? todoText;
  int status;
  String? date;
  String? description;
  int? countTask;
  List<String>? subTask;

  Todo({
    this.id,
    this.userId,
    this.todoText,
    required this.status,
    this.date,
    this.description,
    this.countTask,
    this.subTask,
  });
  Todo copyWith({
    String? id,
    String? userId,
    String? todoText,
    int? status,
    String? date,
    String? description,
    int? countTask,
    List<String>? toDoList,
  }) {
    return Todo(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      todoText: todoText ?? this.todoText,
      status: status ?? this.status,
      date: date ?? this.date,
      description: description ?? this.description,
      countTask: countTask ?? this.countTask,
      subTask: toDoList ?? subTask,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'todoText': todoText,
      'status': status,
      'date': date,
      'description': description,
      'countTask': countTask,
      'toDoList': subTask,
      'userId': userId,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    print(map['userId'] ?? "");
    return Todo(
      id: map['id'] ?? "",
      userId: map['userId'] ?? "",
      todoText: map['todoText'] ?? "",
      status: map['status'] as int,
      date: map['date'] ?? "",
      description: map['description'] ?? "",
      countTask: map['countTask'] as int,
      subTask: ((map['toDoList'] ?? []) as List)
          .map((subtask) => subtask.toString())
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) {
    return Todo.fromMap(
      json.decode(source) as Map<String, dynamic>,
    );
  }

  @override
  String toString() {
    return 'Todo(id: $id, todoText: $todoText, status: $status, date: $date, description: $description, countTask: $countTask, toDoList: $subTask, userId: $userId)';
  }

  @override
  bool operator ==(covariant Todo other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.todoText == todoText &&
        other.status == status &&
        other.date == date &&
        other.description == description &&
        other.countTask == countTask &&
        other.userId == userId &&
        listEquals(other.subTask, subTask);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        todoText.hashCode ^
        status.hashCode ^
        date.hashCode ^
        description.hashCode ^
        countTask.hashCode ^
        userId.hashCode ^
        subTask.hashCode;
  }

  Color get color {
    switch (status) {
      case 2:
        return Colors.green;
      case 1:
        return Colors.yellow;
      case 0:
        return Colors.red;
      default:
        return Colors.green;
    }
  }
}
