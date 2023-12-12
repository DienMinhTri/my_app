// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/models/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  List<Todo> todos = [];
  List<Todo> todosSearch = [];
  CollectionReference todoCollection =
      FirebaseFirestore.instance.collection('todos');
  String searchKey = "";

  TodoBloc() : super(TodoInitial()) {
    on<TodoEvent>((event, emit) async {
      if (event is SearchTodosEvent) {
        searchKey = event.searchKey.trim().toLowerCase();

        todosSearch = todos
            .where((todo) => todo.todoText?.trim().toLowerCase() == searchKey)
            .toList();

        emit(_getDoneTodo);
      }
      if (event is GetTodosEvent) {
        try {
          final datas = await todoCollection
              .where('userId', isEqualTo: event.userId)
              .get();

          if (datas.docs.isNotEmpty) {
            final List<Todo> listTodo = datas.docs
                .map(
                  (todo) => Todo.fromMap(todo.data() as Map<String, dynamic>),
                )
                .toList();

            todos.addAll(listTodo);
          }

          emit(_getDoneTodo);
        } catch (e) {
          print("errr $e");
        }
      }
      if (event is CreateTodoEvent) {
        await todoCollection.doc(event.todo.id).set(event.todo.toMap());

        todos.insert(0, event.todo);

        emit(_getDoneTodo);
      }

      if (event is UpdateTodoEvent) {
        await todoCollection.doc(event.todo.id).set(event.todo.toMap());

        final int index = todos.indexWhere((todo) => todo.id == event.todo.id);

        if (index == -1) {
          todos.insert(0, event.todo);
        } else {
          todos[index] = event.todo;
        }

        emit(_getDoneTodo);
      }

      if (event is ClearTodoEvent) {
        todos.clear();

        emit(_getDoneTodo);
      }

      if (event is DeleteTodoEvent) {
        await todoCollection.doc(event.todoId).delete();

        final int index = todos.indexWhere((todo) => todo.id == event.todoId);

        if (index != -1) {
          todos.removeAt(index);
          Navigator.pop(event.context);
          emit(_getDoneTodo);
        }
      }
    });
  }

  // MARK: state
  GetDoneTodoState get _getDoneTodo => GetDoneTodoState(
        todos: searchKey.isEmpty ? todos : todosSearch,
        searchKey: searchKey,
      );

  // MARK: Private methods
}
