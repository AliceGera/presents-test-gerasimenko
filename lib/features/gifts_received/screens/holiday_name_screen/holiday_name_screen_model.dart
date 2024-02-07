import 'package:elementary/elementary.dart';

import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';
import 'package:flutter_template/features/common/service/holidays_service.dart';

/// Model fol
class HolidayNameScreenModel extends ElementaryModel {

  HolidayNameScreenModel(this._holidaysService) : super();
  final HolidaysService _holidaysService;

  Future<List<Holiday>> getHolidays() async {
    final holidays = await _holidaysService.getHolidays();
    return holidays;
  }
}
