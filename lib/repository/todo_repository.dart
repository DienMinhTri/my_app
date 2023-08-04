import 'dart:convert';
import 'package:my_app/helper/constain.dart';
import 'package:my_app/models/todo.dart';
import 'package:http/http.dart' as http;

class TodoReposity {
  createTodo(Todo todo) async {
    final http.Response response = await http.post(Uri.parse(baseURL + toDoURL),
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
    } catch (e) {}

    return lstTodo;
  }

  Future<void> deleteTodo({required String id}) async {
    var url = Uri.parse('${baseURL}todo/$id.json');
    var response = await http.delete(url);
  }

  Future<void> updateTodo(String id, Todo newTodo) async {
    final url = Uri.parse('${baseURL}todo/$id.json');
    print(url);
    final reponse = await http.patch(
      url,
      body: json.encode(newTodo.toMap()),
    );
    print(reponse);
  }
}
