import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';
import 'package:flutter_template/features/common/domain/data/holiday_with_gifts/holiday_with_gifts_data.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';

List<HolidayWithGiftsData> mapDatabaseToHolidayWithGifts(
  List<Gift> gifts,
  List<Holiday> holidays,
//
) {
  List<HolidayWithGiftsData> holidaysWithGiftsData = [];
  for (final holiday in holidays) {
    holidaysWithGiftsData.add(
      HolidayWithGiftsData(
        giftsReceived: gifts
            .where(
              (gift) => gift.holidayId == holiday.id && gift.isReceivedGift == true,
            )
            .toList(),
        giftsGiven:gifts
            .where(
              (gift) => gift.holidayId == holiday.id && gift.isReceivedGift != true,
        )
            .toList(),
        holiday: holiday,
      ),
    );
  }
  return holidaysWithGiftsData;
}
