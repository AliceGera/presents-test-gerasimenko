import 'package:elementary/elementary.dart';
import 'package:flutter_template/features/common/domain/data/holiday_with_gifts/holiday_with_gifts_data.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';
import 'package:flutter_template/features/common/service/holidays_and_gifts_service.dart';
import 'package:flutter_template/features/common/service/holidays_service.dart';

/// Model for
class HolidaysScreenModel extends ElementaryModel {
  /// Create an instance [HolidaysScreenModel].
  HolidaysScreenModel(this._holidaysService,this._holidayAndGiftsService) : super();
  final HolidaysService _holidaysService;
  final HolidayAndGiftsService _holidayAndGiftsService;
  Future<List<Holiday>> getHolidays() async {
    final holidays = await _holidaysService.getHolidays();
    return holidays;
  }

  Future<void> deleteHolidays(Holiday holiday) async {
    await _holidaysService.deleteHoliday(holiday);
  }
  Future<List<HolidayWithGiftsData>> getHolidaysAndGifts() async {
    final holidayAndGifts = await _holidayAndGiftsService.getHolidaysWithGifts();
    return holidayAndGifts;
  }
}


