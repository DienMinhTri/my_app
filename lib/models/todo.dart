import 'package:flutter/material.dart';

class Todo {
  String? id;
  String? todoText;
  Color color;
  String? testlist;
  Todo({
    required this.id,
    required this.todoText,
    required this.color,
    required this.testlist,
  });

  static List<Todo> todoList() {
    return [
      Todo(
          id: '01',
          todoText: "Football Cup training drybling",
          testlist: "3 tasks",
          color: Colors.red),
      Todo(
          id: '02',
          todoText: "UI/UX App Design",
          testlist: "3 tasks",
          color: Colors.green),
      Todo(
          id: '03',
          todoText: "View condidates resumes",
          testlist: "3 tasks",
          color: Colors.yellow),
      Todo(
          id: '02',
          todoText: "UI/UX App Design",
          testlist: "3 tasks",
          color: Colors.green),
      Todo(
          id: '03',
          todoText: "View condidates resumes",
          testlist: "3 tasks",
          color: Colors.yellow),
    ];
  }
}
