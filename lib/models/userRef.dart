// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

List<UserRef> postFromJson(String str) =>
    List<UserRef>.from(json.decode(str).map((x) => UserRef.fromMap(x)));
class UserRef {
  String? id;
  String? email;
  String? firstName;
  String? secondName;
  String? password;
  String? date;
  UserRef({
    this.id,
    this.email,
    this.firstName,
    this.secondName,
    this.password,
    this.date,
  });

  UserRef copyWith({
    String? id,
    String? email,
    String? firstName,
    String? secondName,
    String? password,
    String? date,
  }) {
    return UserRef(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      secondName: secondName ?? this.secondName,
      password: password ?? this.password,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'password': password,
      'date': date,
    };
  }

  factory UserRef.fromMap(Map<String, dynamic> map) {
    return UserRef(
      id: map['id'] != null ? map['id'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      secondName:
          map['secondName'] != null ? map['secondName'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserRef.fromJson(String source) =>
      UserRef.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserRef(id: $id, email: $email, firstName: $firstName, secondName: $secondName, password: $password, date: $date)';
  }

  @override
  bool operator ==(covariant UserRef other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.email == email &&
        other.firstName == firstName &&
        other.secondName == secondName &&
        other.password == password &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        firstName.hashCode ^
        secondName.hashCode ^
        password.hashCode ^
        date.hashCode;
  }
}
