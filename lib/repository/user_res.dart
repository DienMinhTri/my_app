import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/helper/constain.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/models/userRef.dart';

class UserRes {
  createUser(UserRef user) async {
    final http.Response response = await http.post(
      Uri.parse(baseURL + userURL),
      body: json.encode(
        user.toMap(),
      ),
    );
  }

  Future<void> updateUser(String id, UserRef newUser) async {
    final url = Uri.parse('${userURL}users/$id.json');
    final reponse = await http.patch(
      url,
      body: json.encode(newUser.toMap()),
    );
  }

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
