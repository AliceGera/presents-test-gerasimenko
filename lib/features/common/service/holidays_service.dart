import 'package:flutter_template/features/common/domain/data/holidays/holidays_data.dart';
import 'package:flutter_template/features/common/domain/repository/holidays_repository.dart';

class HolidaysService {
  final HolidaysRepository _holidaysRepository;

  HolidaysService(this._holidaysRepository);

  Future<Future<List<Holiday>>> getHolidays() async {
    return _holidaysRepository.getHolidays();
  }

  Future<void> addHoliday(Holiday data) async {
    await _holidaysRepository.addHoliday(data);
  }

  Future<void> editHoliday(Holiday data) async {
    await _holidaysRepository.editHoliday(data);
  }

  Future<void> deleteHoliday(Holiday data) async {
    await _holidaysRepository.deleteHoliday(data);
  }
}
