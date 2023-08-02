import 'dart:convert';
import 'package:my_app/helper/constain.dart';
import 'package:my_app/models/todo.dart';
import 'package:http/http.dart' as http;

class TodoReposity {
  createTodo(Todo todo) async {
    final response = await http.post(Uri.parse(baseURL + toDoURL),
        body: json.encode(todo.toMap()));
  }

  Future<List<Todo>> getTodo() async {
    final response = await http.get(
      Uri.parse(baseURL + toDoURL),
    );

    List<Todo> lstTodo = [];
    try {
      Map<String, dynamic> listdata = jsonDecode(response.body);
      for (String key in listdata.keys) {
        lstTodo.add(Todo.fromMap(listdata[key] as Map<String, dynamic>)
            .copyWith(id: key));
      }
      print(lstTodo);
    } catch (e) {
      print('err $e');
    }

    return lstTodo;
  }
  Future<Todo> deleteTodo(String id) async {
  final response = await http.delete(
      Uri.parse(baseURL + toDoURL),
    );

  if (response.statusCode == 200) {
    return Todo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to delete album.');
  }
}
}
