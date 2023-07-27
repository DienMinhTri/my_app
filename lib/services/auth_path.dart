import 'package:flutter/material.dart';
import 'package:my_app/screens/login.dart';
import 'package:my_app/screens/register.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? Login(onClickedSignUp: toggle)
      : Register(onClickedSignIn: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}