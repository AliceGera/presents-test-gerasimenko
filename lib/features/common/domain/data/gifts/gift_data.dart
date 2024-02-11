import 'dart:typed_data';

class Gift {
  final int id;
  final int giftRaiting;
  final String giftName;
  final Uint8List photo;
  final String giftPrice;
  final bool isReceivedGift;
  final String whoGave;
  final int whoGaveId;
  final int holidayId;
  final String giftComment;
  final String? holidayName;

  Gift({
    required this.id,
    required this.giftRaiting,
    required this.giftName,
    required this.photo,
    required this.isReceivedGift,
    required this.whoGave,
    required this.whoGaveId,
    required this.holidayId,
    required this.giftComment,
    required this.giftPrice,
    this.holidayName,
  });

  static Gift init() => Gift(
        id: 0,
        giftRaiting: 0,
        giftName: '',
        photo: Uint8List(0),
        isReceivedGift: true,
        whoGave: '',
        whoGaveId: 0,
        holidayId: 0,
        giftComment: '',
        giftPrice: '',
      );

  Gift copyWith({
    int? id,
    int? giftRaiting,
    String? giftName,
    Uint8List? photo,
    bool? isReceivedGift,
    String? whoGave,
    int? whoGaveId,
    int? holidayId,
    String? giftComment,
    String? holidayName,
    String? giftPrice,
  }) {
    return Gift(
      id: id ?? this.id,
      giftRaiting: giftRaiting ?? this.giftRaiting,
      giftName: giftName ?? this.giftName,
      photo: photo ?? this.photo,
      giftPrice: giftPrice ?? this.giftPrice,
      isReceivedGift: isReceivedGift ?? this.isReceivedGift,
      whoGave: whoGave ?? this.whoGave,
      whoGaveId: whoGaveId ?? this.whoGaveId,
      holidayId: holidayId ?? this.holidayId,
      giftComment: giftComment ?? this.giftComment,
      holidayName: holidayName ?? this.holidayName,
    );
  }
}
