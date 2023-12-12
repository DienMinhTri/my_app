import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/bloc/todo_bloc.dart';
import 'package:my_app/bloc/user_bloc.dart';

class AppBloc {
  static final UserBloc userBloc = UserBloc();
  static final TodoBloc todoBloc = TodoBloc();

  static final List<BlocProvider> providers = [
    BlocProvider<UserBloc>(
      create: (context) => userBloc,
    ),
    BlocProvider<TodoBloc>(
      create: (context) => todoBloc,
    ),
  ];

  ///Singleton factory
  static final AppBloc instance = AppBloc._internal();

  factory AppBloc() {
    return instance;
  }

  AppBloc._internal();
}
