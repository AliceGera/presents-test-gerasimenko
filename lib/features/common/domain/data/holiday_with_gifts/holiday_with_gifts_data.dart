import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';

class HolidayWithGiftsData {
  final List<Gift> gifts;
  final Holiday holiday;

  HolidayWithGiftsData({
    required this.gifts,
    required this.holiday,
  });
}
