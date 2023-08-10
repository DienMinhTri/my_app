// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class StatusProfile {
  String? statusText;
  int status;
  StatusProfile({
    this.statusText,
    required this.status,
  });

  
  Color get color {
    switch (status) {
      case 2:
        return Colors.green;
      case 1:
        return Colors.orange;
      case 0:
        return Colors.black;
      default:
        return Colors.green;
    }
  }

  StatusProfile copyWith({
    String? statusText,
    int? status,
  }) {
    return StatusProfile(
      statusText: statusText ?? this.statusText,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statusText': statusText,
      'status': status,
    };
  }

  factory StatusProfile.fromMap(Map<String, dynamic> map) {
    return StatusProfile(
      statusText: map['statusText'] != null ? map['statusText'] as String : null,
      status: map['status'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory StatusProfile.fromJson(String source) => StatusProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'StatusProfile(statusText: $statusText, status: $status)';

  @override
  bool operator ==(covariant StatusProfile other) {
    if (identical(this, other)) return true;
  
    return 
      other.statusText == statusText &&
      other.status == status;
  }

  @override
  int get hashCode => statusText.hashCode ^ status.hashCode;
}
