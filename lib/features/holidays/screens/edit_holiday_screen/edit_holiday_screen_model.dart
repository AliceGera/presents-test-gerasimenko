import 'dart:typed_data';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/config/app_config.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';
import 'package:flutter_template/features/common/service/holidays_service.dart';

/// Model for
class EditHolidayScreenModel extends ElementaryModel {
  /// Interface for handle error in business logic.
  final ErrorHandler errorHandler;
  final HolidaysService _holidaysService;
  String _holidayName = '';
  String _holidayDate = '';
  Uint8List _photo = Uint8List(0);
  int _id = 0;

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

  int get id => _id;

  set id(int newId) {
    _id = newId;
  }

  Future<void> editHoliday() async {
    await _holidaysService.editHoliday(
      Holiday(
        id: _id,
        holidayName: _holidayName,
        holidayDate: _holidayDate,
        photo: _photo,
      ),
    );
  }

  Future<void> deleteHoliday() async {
    await _holidaysService.deleteHoliday(
      Holiday(
        id: _id,
        holidayName: _holidayName,
        holidayDate: _holidayDate,
        photo: _photo,
      ),
    );
  }

  /// Config change Notifier.
  late ValueNotifier<AppConfig> configNotifier;

  /// Create an instance [EditHolidayScreenModel].
  EditHolidayScreenModel(
    this.errorHandler,
    this._holidaysService,
  ) : super(errorHandler: errorHandler);
}
