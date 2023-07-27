import 'package:flutter/material.dart';
import 'package:my_app/screens/login.dart';
import 'package:my_app/screens/register.dart';

class AuthPage extends StatefulWidget {
  final bool isLogin;
  const AuthPage({super.key, required this.isLogin});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  void initState() {
    super.initState();
    isLogin = widget.isLogin;
  }

  @override
  Widget build(BuildContext context) => isLogin
      ? Login(onClickedSignUp: toggle)
      : Register(onClickedSignIn: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}
