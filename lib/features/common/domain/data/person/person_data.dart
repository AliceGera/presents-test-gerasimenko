import 'dart:typed_data';

class Person {
  final int id;
  final String firstName;
  final String lastName;
  final Uint8List photo;
  final String comment;

  Person({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.photo,
    required this.comment,
  });

  static Person init() => Person(
        id: 0,
        firstName: '',
        lastName: '',
        photo: Uint8List(0),
        comment: '',
      );

  Person copyWith({
    int? id,
    String? firstName,
    String? lastName,
    Uint8List? photo,
    String? comment,
  }) {
    return Person(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      photo: photo ?? this.photo,
      comment: comment ?? this.comment,
    );
  }
}
