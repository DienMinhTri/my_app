// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserRef {
  String? id;
  final String email;
  final String date;
  final String fullname;
  final String phoneNumber;
  String avatar;
  UserRef({
    this.id,
    required this.email,
    required this.date,
    required this.fullname,
    required this.phoneNumber,
    required this.avatar,
  });

  UserRef copyWith({
    String? id,
    String? email,
    String? date,
    String? fullname,
    String? phoneNumber,
    String? avatar,
  }) {
    return UserRef(
      id: id ?? this.id,
      email: email ?? this.email,
      date: date ?? this.date,
      fullname: fullname ?? this.fullname,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'date': date,
      'fullname': fullname,
      'phoneNumber': phoneNumber,
      'avatar': avatar,
    };
  }

  factory UserRef.fromMap(Map<String, dynamic> map) {
    return UserRef(
      id: map['id'] ?? "",
      email: map['email'] ?? "",
      date: map['date'] ?? "",
      fullname: map['fullname'] ?? "",
      phoneNumber: map['phoneNumber'] ?? "",
      avatar: map['avatar'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory UserRef.fromJson(String source) =>
      UserRef.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserRef(id: $id, email: $email, date: $date, fullname: $fullname, phoneNumber: $phoneNumber, avatar: $avatar)';
  }

  @override
  bool operator ==(covariant UserRef other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.email == email &&
        other.date == date &&
        other.fullname == fullname &&
        other.phoneNumber == phoneNumber &&
        other.avatar == avatar;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        date.hashCode ^
        fullname.hashCode ^
        phoneNumber.hashCode ^
        avatar.hashCode;
  }
}
