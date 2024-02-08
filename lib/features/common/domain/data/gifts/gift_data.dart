import 'dart:typed_data';

class Gift {
  final int id;
  final int giftRaiting;
  final String giftName;
  final Uint8List photo;
  final int giftPrice;
  final bool isReceivedGift;
  final String whoGave;
  final int holidayId;
  final String giftComment;
  final String? holidayName;

  Gift({
    required this.id,
    required this.giftRaiting,
    required this.giftName,
    required this.photo,
    required this.giftPrice,
    required this.isReceivedGift,
    required this.whoGave,
    required this.holidayId,
    required this.giftComment,
    this.holidayName,
  });

  static Gift init() => Gift(
        id: 0,
        giftRaiting: 0,
        giftName: '',
        photo: Uint8List(0),
        giftPrice: 0,
        isReceivedGift: true,
        whoGave: '',
        holidayId: 0,
        giftComment: '',
      );

  Gift copyWith({
    int? id,
    int? giftRaiting,
    String? giftName,
    Uint8List? photo,
    int? giftPrice,
    bool? isReceivedGift,
    String? whoGave,
    int? holidayId,
    String? giftComment,
    String? holidayName,
  }) {
    return Gift(
      id: id ?? this.id,
      giftRaiting: giftRaiting ?? this.giftRaiting,
      giftName: giftName ?? this.giftName,
      photo: photo ?? this.photo,
      giftPrice: giftPrice ?? this.giftPrice,
      isReceivedGift: isReceivedGift ?? this.isReceivedGift,
      whoGave: whoGave ?? this.whoGave,
      holidayId: holidayId ?? this.holidayId,
      giftComment: giftComment ?? this.giftComment,
      holidayName: holidayName ?? this.holidayName,
    );
  }
}
