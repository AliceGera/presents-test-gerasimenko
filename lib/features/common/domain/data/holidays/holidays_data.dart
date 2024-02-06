import 'dart:typed_data';

class Holiday {
  final int id;
  final String holidayName;
  final String holidayDate;
  final Uint8List photo;

  Holiday({
    required this.id,
    required this.holidayName,
    required this.holidayDate,
    required this.photo,
  });
}
/* Holiday copyWith({
    final String? holidayName,
    final String? holidayDate,
    final Uint8List? photo,

  }) {
    return Holiday(
      holidayName: holidayName ?? this.holidayName,
      holidayDate: holidayDate ?? this.holidayDate,
      photo: photo ?? this.photo,
      );
  }*/

/* static Holiday init() => Holiday(
    holidayName: '',
    holidayDate: '',
    photo: 0,

      );*/
