part of 'todo_bloc.dart';

abstract class TodoState {}

class TodoInitial extends TodoState {}

class GetDoneTodoState extends TodoState {
  final List<Todo>? todos;
  final String searchKey;

  GetDoneTodoState({
    required this.todos,
    required this.searchKey,
  });
}
