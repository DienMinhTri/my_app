part of 'user_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class GetDoneUserState extends UserState {
  final UserRef? userRef;

  GetDoneUserState({required this.userRef});
}
