import 'dart:typed_data';

class Holiday {
  final int id;
  final String holidayName;
  final DateTime? holidayDate;
  final Uint8List photo;

  Holiday({
    required this.id,
    required this.holidayName,
    required this.photo,
    this.holidayDate,
  });

  static Holiday init() => Holiday(
        holidayName: '',
        photo: Uint8List(0),
        id: 0,
      );
}
