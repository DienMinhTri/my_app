import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/helper/constain.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/models/userRef.dart';

class UserRes {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  createUser(UserRef user) async {
    await users
        .doc(user.id ?? "")
        .set(
          user.toMap(),
        )
        .onError((error, stackTrace) => print("error $error"));
  }

  Future<void> updateUser(String id, UserRef newUser) async {}

  Future<UserRef> getUser() async {
    final response = await http.get(
      Uri.parse(baseURL + toDoURL),
    );

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<UserRef>((json) => UserRef.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load list');
    }
  }
}
