import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';
import 'package:flutter_template/features/common/domain/data/holiday_with_gifts/holiday_with_gifts_data.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';
import 'package:flutter_template/features/common/service/gifts_service.dart';
import 'package:flutter_template/features/common/service/holidays_and_gifts_service.dart';
import 'package:flutter_template/features/common/service/holidays_service.dart';

/// Model for
class HolidayGiftsScreenModel extends ElementaryModel {
  /// Create an instance [HolidayGiftsScreenModel].
  HolidayGiftsScreenModel(this._holidaysService, this._holidayAndGiftsService,this._giftsService) : super();
  final HolidaysService _holidaysService;
  final HolidayAndGiftsService _holidayAndGiftsService;
  final GiftsService _giftsService;

  Holiday _holiday = Holiday.init();

  set holiday(Holiday newHoliday) => _holiday = newHoliday;

  Holiday get holiday => _holiday;

  Future<List<Holiday>> getHolidays() async {
    final holidays = await _holidaysService.getHolidays();
    return holidays;
  }

  Future<void> deleteHolidays(Holiday holiday) async {
    await _holidaysService.deleteHoliday(holiday);
  }

  Future<List<HolidayWithGiftsData>> getGifts() async {
    final gifts = await _holidayAndGiftsService.getHolidaysWithGifts();
    return gifts;
  }

  Future<HolidayWithGiftsData?> getHolidayAndGifts(Holiday holiday) async {
    final holidaysWithGifts = await _holidayAndGiftsService.getHolidaysWithGifts();
    final holidayWithGifts = holidaysWithGifts.firstWhereOrNull((element) => element.holiday.id == holiday.id);
    return holidayWithGifts;
  }

  Future<void> deleteGift(Gift gift) async {
    await _giftsService.deleteGift(gift);
  }
}
