// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BookMarkMode {
  int userId;
  int tourismId;

  BookMarkMode({
    required this.userId,
    required this.tourismId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'tourismId': tourismId,
    };
  }

  factory BookMarkMode.fromMap(Map<String, dynamic> map) {
    return BookMarkMode(
      userId: map['userId'] as int,
      tourismId: map['tourismId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookMarkMode.fromJson(String source) => BookMarkMode.fromMap(json.decode(source) as Map<String, dynamic>);
}
