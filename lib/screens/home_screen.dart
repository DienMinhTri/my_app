import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/services/VerifyEmail.dart';
import 'package:my_app/services/auth_path.dart';

class MainPageScreen extends StatelessWidget {
  final bool isLogin;
  const MainPageScreen({
    super.key,
    required this.isLogin,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const VerifyEmail();
            } else {
              return AuthPage(
                isLogin: isLogin,
              );
            }
          },
        ),
      );
}
