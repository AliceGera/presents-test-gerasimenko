import 'package:flutter_template/api/data/gift_database.dart';
import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';

/// Интерфейс API клиента.

class GiftsApi {
  GiftsApi(this.appGiftsDatabase);

  final AppGiftsDatabase appGiftsDatabase;

  Future<List<GiftsTableData>> getGifts() async {
    return appGiftsDatabase.select(appGiftsDatabase.giftsTable).get();
  }

  Future<void> addGift(Gift data) async {
    await appGiftsDatabase.into(appGiftsDatabase.giftsTable).insert(
          GiftsTableCompanion.insert(
            holidaysId: data.holidaysId,
            photo: data.photo,
            giftsRaiting: data.giftsRaiting,
            giftsName: data.giftsName,
            giftsPrice: data.giftsPrice,
            isReceivedGifts: data.isReceivedGifts,
            whoGave: '',
            giftsComment: '',
          ),
        );
  }
/* Future<void> addHoliday(Holiday data) async {
    await appDatabase.into(appDatabase.holidaysTable).insert(
          HolidaysTableCompanion.insert(
            holidaysName: data.holidayName,
            holidayDate: data.holidayDate,
            photo: data.photo,
          ),
        );
  }

  Future<void> editHoliday(Holiday data) async {
    final resultTable = appDatabase.update(appDatabase.holidaysTable)..where((t) => t.id.equals(data.id));
    await resultTable.write(
      HolidaysTableCompanion.insert(
        holidaysName: data.holidayName,
        holidayDate: data.holidayDate,
        photo: data.photo,
      ),
    );
  }
  Future<void> deleteHoliday(Holiday data) async {
    final resultTable = appDatabase.delete(appDatabase.holidaysTable)..where((t) => t.id.equals(data.id));
    await resultTable.go();
  }*/
}
