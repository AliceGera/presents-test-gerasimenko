import 'package:elementary/elementary.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holidays_data.dart';
import 'package:flutter_template/features/common/service/holidays_service.dart';

/// Model for
class HolidaysScreenModel extends ElementaryModel {
  /// Create an instance [HolidaysScreenModel].
  HolidaysScreenModel(this._holidaysService) : super();
  final HolidaysService _holidaysService;

  Future<List<Holiday>> getHolidays() async {
    final holidays = await _holidaysService.getHolidays();
    return holidays;
  }
}


