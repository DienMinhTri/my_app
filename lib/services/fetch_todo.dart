import 'dart:convert';

import 'package:my_app/models/todo.dart';
import 'package:http/http.dart' as http;

Future<Todo> fetchTodo() async {
  final response = await http
      .get(Uri.parse('https://my-first-project-63-default-rtdb.asia-southeast1.firebasedatabase.app/todo'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Todo.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
