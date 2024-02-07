import 'package:elementary/elementary.dart';
import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';
import 'package:flutter_template/features/common/service/gifts_service.dart';

import 'package:flutter_template/features/common/domain/data/holiday_with_gifts/holiday_with_gifts_data.dart';

import 'package:flutter_template/features/common/service/holidays_and_gifts_service.dart';

/// Model fol
class GiftsReceivedScreenModel extends ElementaryModel {
  GiftsReceivedScreenModel(this._holidayAndGiftsService) : super();
  //final GiftsService _giftsService;
  final HolidayAndGiftsService _holidayAndGiftsService;
  Future<List<HolidayWithGiftsData>> getGifts() async {
    final gifts = await _holidayAndGiftsService.getHolidaysWithGifts();
    return gifts;
  }
}
