import 'dart:typed_data';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/config/app_config.dart';
import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';
import 'package:flutter_template/features/common/service/gifts_service.dart';
import 'package:flutter_template/features/common/service/holidays_service.dart';

/// Model for
class AddGiftReceivedScreenModel extends ElementaryModel {
  /// Interface for handle error in business logic.
  final ErrorHandler errorHandler;
  final GiftsService _giftsService;
  final HolidaysService _holidaysService;

  /// Config change Notifier.
  late ValueNotifier<AppConfig> configNotifier;
  String _giftName = '';
  String _giftComment = '';
  int _holidayId = 0;
  Uint8List _photo = Uint8List(0);
  int _giftRate = 0;
  String _whoGavePresent = '';
  int _whoGaveId = 0;

  String _holidayName = '';

  String get giftName => _giftName;

  set giftRate(int newGiftRate) {
    _giftRate = newGiftRate;
  }

  int get giftRate => _giftRate;

  set giftName(String newGiftName) {
    _giftName = newGiftName;
  }

  int get holidayId => _holidayId;

  set holidayId(int newHolidayId) {
    _holidayId = newHolidayId;
  }

  String get giftComment => _giftComment;

  set giftComment(String newGiftComment) {
    _giftComment = newGiftComment;
  }

  Uint8List get photo => _photo;

  set photo(Uint8List newPhoto) {
    _photo = newPhoto;
  }

  String get whoGavePresent => _whoGavePresent;

  set whoGavePresent(String newWhoGavePresent) {
    _whoGavePresent = newWhoGavePresent;
  }

  set whoGaveId(int whoGaveId) {
    _whoGaveId = whoGaveId;
  }

  String get holidayName => _holidayName;

  set holidayName(String newHolidayName) {
    _holidayName = newHolidayName;
  }

  Gift get gift => Gift(
        id: 1,
        photo: _photo,
        giftRaiting: _giftRate,
        giftName: _giftName,
        giftPrice: '',
        isReceivedGift: true,
        whoGave: _whoGavePresent,
        whoGaveId: _whoGaveId,
        holidayId: _holidayId,
        giftComment: _giftComment,
      );

  Future<void> addGift() async {
    await _giftsService.addGift(
      Gift(
        id: 1,
        photo: _photo,
        giftRaiting: _giftRate,
        giftName: _giftName,
        giftPrice: '',
        isReceivedGift: true,
        whoGave: _whoGavePresent,
        whoGaveId: _whoGaveId,
        holidayId: _holidayId,
        giftComment: _giftComment,
      ),
    );
  }

  Future<List<Holiday>> getHolidays() async {
    final holidays = await _holidaysService.getHolidays();
    return holidays;
  }

  /// Create an instance [AddGiftReceivedScreenModel].
  AddGiftReceivedScreenModel(
    this.errorHandler,
    this._giftsService,
    this._holidaysService,
  ) : super(errorHandler: errorHandler);
}
