import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';
import 'package:flutter_template/features/common/domain/data/holiday_with_gifts/holiday_with_gifts_data.dart';
import 'package:flutter_template/features/common/domain/repository/gifrs_repository.dart';
import 'package:flutter_template/features/common/domain/repository/holidays_repository.dart';
import 'package:flutter_template/features/common/domain/repository/mappers/holiday_with_gifts_mapper.dart';

class HolidayAndGiftsService {
  final GiftsRepository _giftsRepository;
  final HolidaysRepository _holidaysRepository;

  HolidayAndGiftsService(
    this._giftsRepository,
    this._holidaysRepository,
  );

  Future<List<HolidayWithGiftsData>> getHolidaysWithGifts() async {
    final gifts = await _giftsRepository.getGifts();
    final holidays = await _holidaysRepository.getHolidays();
    return mapDatabaseToHolidayWithGifts(
      gifts,
      holidays,
    );
  }
}
