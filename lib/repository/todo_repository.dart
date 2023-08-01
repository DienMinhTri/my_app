import 'dart:convert';
import 'package:my_app/helper/constain.dart';
import 'package:my_app/models/todo.dart';
import 'package:http/http.dart' as http;

class TodoReposity {
  createTodo(Todo todo) async {

    final response = await http.post(Uri.parse(baseURL + toDoURL),
        body: json.encode(todo.toMap()));

  }
}
