import 'package:flutter_template/api/data/gift_database.dart';
import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';

List<Gift> mapDatabaseToGifts(List<GiftsTableData> giftsTable) {
  return giftsTable
      .map(
        (e) => Gift(
          id: e.id,
          giftName: e.giftsName,
          photo: e.photo,
          giftPrice: e.giftsPrice,
          isReceivedGift: e.isReceivedGifts,
          whoGave: e.whoGave,
          whoGaveId: e.whoGaveId,
          holidayId: e.holidaysId,
          giftComment: e.giftsComment,
          giftRaiting: e.giftsRaiting,
        ),
      )
      .toList();
}
