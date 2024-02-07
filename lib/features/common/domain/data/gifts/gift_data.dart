import 'dart:typed_data';

class Gift {
  final int id;
  final int giftsRaiting;
  final String giftsName;
  final Uint8List photo;
  final int giftsPrice;
  final bool isReceivedGifts;
  final String whoGave;
  final int holidaysId;
  final String giftsComment;
  final String? holidayName;

  Gift({
    required this.id,
    required this.giftsRaiting,
    required this.giftsName,
    required this.photo,
    required this.giftsPrice,
    required this.isReceivedGifts,
    required this.whoGave,
    required this.holidaysId,
    required this.giftsComment,
    this.holidayName,
  });

  static Gift init() => Gift(
        id: 0,
        giftsRaiting: 0,
        giftsName: '',
        photo: Uint8List(0),
        giftsPrice: 0,
        isReceivedGifts: true,
        whoGave: '',
        holidaysId: 0,
        giftsComment: '',
      );
}
