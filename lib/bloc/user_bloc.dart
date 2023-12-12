// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_app/bloc/app_bloc.dart';
import 'package:my_app/bloc/todo_bloc.dart';
import 'package:my_app/helper/toast/toast_notification.dart';
import 'package:my_app/models/userRef.dart';
import 'package:my_app/screens/home_screen.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRef? userRef;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is LoginUserEvent) {
        await login(event: event);

        emit(_getDoneUser);
      }

      if (event is GetUserEvent) {
        final userCurrent = FirebaseAuth.instance.currentUser;

        if (userCurrent?.uid != null) {
          final snapshot = await users.doc(userCurrent?.uid ?? "").get();

          userRef = UserRef.fromMap(snapshot.data() as Map<String, dynamic>);
          userRef?.id = userCurrent?.uid;

          AppBloc.todoBloc.add(GetTodosEvent(userId: userCurrent?.uid ?? ""));
        }

        FlutterNativeSplash.remove();
        emit(_getDoneUser);
      }

      if (event is UpdateUserEvent) {
        await _handleUpdateUser(event);
        emit(_getDoneUser);
      }

      if (event is CheckUserInFireBase) {
        final snapshot = await users.doc(event.userRef.id).get();

        if (snapshot.data() == null) {
          add(UpdateUserEvent(userRef: event.userRef));
        } else {
          userRef = UserRef.fromMap(snapshot.data() as Map<String, dynamic>);
          userRef?.id = event.userRef.id;

          emit(_getDoneUser);
        }
      }

      if (event is LogoutEvent) {
        userRef = null;
        AppBloc.todoBloc.add(ClearTodoEvent());
        GoogleSignIn().signOut();
        FirebaseAuth.instance.signOut();
        Navigator.of(event.context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const MainPageScreen(
              isLogin: true,
            ),
          ),
        );
        emit(_getDoneUser);
      }
    });
  }

  // MARK: state
  GetDoneUserState get _getDoneUser => GetDoneUserState(userRef: userRef);

  // MARK: Private methods
  Future<void> _handleUpdateUser(UpdateUserEvent event) async {
    final UserRef account = event.userRef;
    String? downloadUrl;

    await _handleUploadImage(event, downloadUrl, account);

    await users
        .doc(account.id ?? "")
        .set(account.toMap())
        .onError((error, stackTrace) => print("error $error"));

    userRef = account;

    toastNotification(
      "Cập nhật thông tin thành công",
    );
  }

  Future<void> _handleUploadImage(
    UpdateUserEvent event,
    String? downloadUrl,
    UserRef userRefModel,
  ) async {
    if (event.image != null) {
      final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

      final snapshot = await firebaseStorage
          .ref()
          .child(
            '${userRefModel.id ?? DateTime.now().microsecondsSinceEpoch}',
          )
          .putFile(event.image!);

      downloadUrl = await snapshot.ref.getDownloadURL();
    }

    if (downloadUrl != null) {
      userRefModel.avatar = downloadUrl;
    }
  }

  Future<void> login({
    required LoginUserEvent event,
  }) async {
    User? userCurrent;

    if (event.isLoginGoogle) {
      userCurrent = await signInWithGoogle();
    } else {
      userCurrent = await signIn(event.context, event.email, event.password);
      Navigator.pop(event.context);
    }

    if (userCurrent != null) {
      AppBloc.todoBloc.add(GetTodosEvent(userId: userCurrent.uid));
      add(
        CheckUserInFireBase(
          userRef: UserRef(
            id: userCurrent.uid,
            email: userCurrent.email ?? "",
            date: "",
            fullname: userCurrent.displayName ?? "",
            phoneNumber: userCurrent.phoneNumber ?? "",
            avatar: userCurrent.photoURL ?? "",
          ),
        ),
      );
    }
  }

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    return userCredential.user;
  }

  Future<User?> signIn(
    BuildContext context,
    String? email,
    String? phone,
  ) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email ?? "",
        password: phone ?? "",
      );

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      toastNotification(
        e.message ?? "",
        icon: Icons.close,
        colorIcon: Colors.red,
      );
      return null;
    }
  }
}
