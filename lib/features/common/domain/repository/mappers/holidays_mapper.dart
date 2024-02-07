import 'package:flutter_template/api/data/holiday_database.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';

List<Holiday> mapDatabaseToHolidays(List<HolidaysTableData> holidaysTable) {
  return holidaysTable
      .map(
        (e) => Holiday(
          id: e.id,
          holidayName: e.holidaysName,
          holidayDate: e.holidayDate,
          photo: e.photo,
        ),
      )
      .toList();
}
