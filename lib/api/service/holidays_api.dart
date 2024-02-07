import 'package:flutter_template/api/data/holiday_database.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';

class HolidaysApi {
  HolidaysApi(this.appDatabase);

  final AppDatabase appDatabase;

  Future<List<HolidaysTableData>> getHolidays() async {
    return appDatabase.select(appDatabase.holidaysTable).get();
  }

  Future<void> addHoliday(Holiday data) async {
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
  }
}
