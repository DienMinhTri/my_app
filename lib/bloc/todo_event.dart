// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_bloc.dart';

abstract class TodoEvent {}

class GetTodosEvent extends TodoEvent {
  final String userId;

  GetTodosEvent({required this.userId});
}

class SearchTodosEvent extends TodoEvent {
  final String searchKey;

  SearchTodosEvent({required this.searchKey});
}

class CreateTodoEvent extends TodoEvent {
  final Todo todo;

  CreateTodoEvent({required this.todo});
}

class UpdateTodoEvent extends TodoEvent {
  final Todo todo;

  UpdateTodoEvent({required this.todo});
}

class DeleteTodoEvent extends TodoEvent {
  final String todoId;
  final BuildContext context;

  DeleteTodoEvent({required this.todoId, required this.context});
}

class ClearTodoEvent extends TodoEvent {}
