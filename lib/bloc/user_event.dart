// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

abstract class UserEvent {}

class LoginUserEvent extends UserEvent {
  final String? email;
  final String? password;
  final BuildContext context;
  final bool isLoginGoogle;
  LoginUserEvent({
    this.email,
    this.password,
    required this.context,
    this.isLoginGoogle = false,
  });
}

class GetUserEvent extends UserEvent {
  GetUserEvent();
}

class UpdateUserEvent extends UserEvent {
  final UserRef userRef;
  final File? image;

  UpdateUserEvent({
    required this.userRef,
    this.image,
  });
}

class CheckUserInFireBase extends UserEvent {
  final UserRef userRef;

  CheckUserInFireBase({required this.userRef});
}

class LogoutEvent extends UserEvent {
  final BuildContext context;

  LogoutEvent(this.context);
}
