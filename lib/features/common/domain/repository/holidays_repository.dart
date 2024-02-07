import 'package:flutter_template/api/service/holidays_api.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';
import 'package:flutter_template/features/common/domain/repository/mappers/holidays_mapper.dart';

class HolidaysRepository {
  final HolidaysApi _apiClient;

  HolidaysRepository(this._apiClient);

  Future<List<Holiday>> getHolidays() async {
    final some = await _apiClient.getHolidays();
    return mapDatabaseToHolidays(some);
  }

  Future<void> addHoliday(Holiday data) async {
    await _apiClient.addHoliday(data);
  }

  Future<void> editHoliday(Holiday data) async {
    await _apiClient.editHoliday(data);
  }
  Future<void> deleteHoliday(Holiday data) async {

    await _apiClient.deleteHoliday(data);
  }
}
