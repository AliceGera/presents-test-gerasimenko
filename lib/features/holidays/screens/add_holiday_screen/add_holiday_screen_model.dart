import 'package:drift/drift.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/config/app_config.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holidays_data.dart';
import 'package:flutter_template/features/common/service/holidays_service.dart';

/// Model for
class AddHolidayScreenModel extends ElementaryModel {
  /// Interface for handle error in business logic.
  final ErrorHandler errorHandler;
  final HolidaysService _holidaysService;
  String _holidayName = '';
  String _holidayDate = '';
  Uint8List _photo =Uint8List(0) ;
  String get holidayName => _holidayName;

  set holidayName(String newHolidayName) {
    _holidayName = newHolidayName;
  }

  String get holidayDate => _holidayDate;

  set holidayDate(String newHolidayDate) {
    _holidayDate = newHolidayDate;
  }
  Uint8List get photo => _photo;
  set photo(Uint8List newPhoto) {
    _photo = newPhoto;
  }

  /// Config change Notifier.
  late ValueNotifier<AppConfig> configNotifier;

  Future<void> addHoliday() async {
    await _holidaysService.addHoliday(
      Holiday(
        id: 1,
        holidayName: _holidayName,
        holidayDate: _holidayDate,
        photo: _photo,
      ),
    );
  }

  /// Create an instance [AddHolidayScreenModel].
  AddHolidayScreenModel(
    this.errorHandler,
    this._holidaysService,
  ) : super(errorHandler: errorHandler);
}

