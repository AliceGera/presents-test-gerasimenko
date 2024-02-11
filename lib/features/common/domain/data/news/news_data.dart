import 'dart:typed_data';

class News {
  final int id;
  final String title;
  final String date;
  final Uint8List photo;
  final String time;

  News({
    required this.id,
    required this.title,
    required this.date,
    required this.photo,
    required this.time,
  });

  static News init() => News(
        id: 0,
        title: '',
        photo: Uint8List(0),
        date: '',
        time: '',
      );

  News copyWith({
    int? id,
    String? title,
    String? date,
    Uint8List? photo,
    String? time,
  }) {
    return News(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      photo: photo ?? this.photo,
      time: time ?? this.time,
    );
  }
}
