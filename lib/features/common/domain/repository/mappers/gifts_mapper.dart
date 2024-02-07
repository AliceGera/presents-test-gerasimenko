import 'package:flutter_template/api/data/gift_database.dart';
import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';

List<Gift> mapDatabaseToGifts(List<GiftsTableData> giftsTable) {
  return giftsTable
      .map(
        (e) => Gift(
          id: e.id,
          giftsName: e.giftsName,
          photo: e.photo,
          giftsPrice: e.giftsPrice,
          isReceivedGifts: e.isReceivedGifts,
          whoGave: e.whoGave,
          holidaysId: e.holidaysId,
          giftsComment: e.giftsComment,
          giftsRaiting: e.giftsRaiting,
        ),
      )
      .toList();
}
