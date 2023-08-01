// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Todo {
  String? id;
  String? todoText;
  int status;
  String? date;
  String? description;
  int? countTask;
  List<String>? toDoList;

  Todo({
    this.id,
    this.todoText,
    required this.status,
    this.date,
    this.description,
    this.countTask,
    this.toDoList,
  });
  Todo copyWith({
    String? id,
    String? todoText,
    int? status,
    String? date,
    String? description,
    int? countTask,
    List<String>? toDoList,
  }) {
    return Todo(
      id: id ?? this.id,
      todoText: todoText ?? this.todoText,
      status: status ?? this.status,
      date: date ?? this.date,
      description: description ?? this.description,
      countTask: countTask ?? this.countTask,
      toDoList: toDoList ?? this.toDoList,
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
      'toDoList': toDoList,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
        id: map['id'] != null ? map['id'] as String : null,
        todoText: map['todoText'] != null ? map['todoText'] as String : null,
        status: map['status'] as int,
        date: map['date'] != null ? map['date'] as String : null,
        description:
            map['description'] != null ? map['description'] as String : null,
        countTask: map['countTask'] as int,
        toDoList: map['toDoList'] != null
            ? List<String>.from(map['toDoList'] as List<String>)
            : null);
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) =>
      Todo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Todo(id: $id, todoText: $todoText, status: $status, date: $date, description: $description, countTask: $countTask, toDoList: $toDoList)';
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
        listEquals(other.toDoList, toDoList);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        todoText.hashCode ^
        status.hashCode ^
        date.hashCode ^
        description.hashCode ^
        countTask.hashCode ^
        toDoList.hashCode;
  }

  Color get color {
    switch (status) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.yellow;
      case 2:
        return Colors.red;
      default:
        return Colors.green;
    }
  }

  static List<Todo> todoList() {
    return [
      Todo(
        id: '01',
        todoText: "Football Cup training drybling",
        countTask: 0,
        status: 2,
        toDoList:[],
      ),
      Todo(
        id: '02',
        todoText: "UI/UX App Design",
        countTask: 0,
        status: 0,
        toDoList: [],
      ),
      Todo(
        id: '03',
        todoText: "View condidates resumes",
        countTask: 0,
        status: 1,
        toDoList: [],
      ),
      Todo(
        id: '04',
        todoText: "UI/UX App Design",
        countTask: 0,
        status: 0,
        toDoList: [],
      ),
      Todo(
        id: '05',
        todoText: "View condidates resumes",
        countTask: 0,
        status: 1,
        toDoList: [],
      ),
    ];
  }
}
