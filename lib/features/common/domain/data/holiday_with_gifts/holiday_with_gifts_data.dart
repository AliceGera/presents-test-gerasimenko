import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';

class HolidayWithGiftsData {
  final List<Gift> giftsReceived;
  final List<Gift> giftsGiven;
  final Holiday holiday;

  HolidayWithGiftsData({
    required this.giftsReceived,
    required this.giftsGiven,
    required this.holiday,
  });

  static HolidayWithGiftsData init() => HolidayWithGiftsData(
    giftsReceived: [],
    giftsGiven: [],
   holiday: Holiday.init(),
  );

}
