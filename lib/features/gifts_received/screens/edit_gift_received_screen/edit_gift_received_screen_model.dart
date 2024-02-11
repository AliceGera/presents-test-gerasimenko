import 'dart:typed_data';

import 'package:elementary/elementary.dart';
import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';
import 'package:flutter_template/features/common/service/gifts_service.dart';
import 'package:flutter_template/features/common/service/holidays_service.dart';

/// Model for [EditGiftReceivedScreenModel]
class EditGiftReceivedScreenModel extends ElementaryModel {
  /// Interface for handle error in business logic.
  final ErrorHandler errorHandler;
  final GiftsService _giftsService;
  final HolidaysService _holidaysService;

  /// Create an instance [EditGiftReceivedScreenModel].
  EditGiftReceivedScreenModel(
    this.errorHandler,
    this._giftsService,
    this._holidaysService,
  ) : super(errorHandler: errorHandler);
  Gift _gift = Gift.init();

  Gift get gift => _gift;

  set gift(Gift newGift) {
    _gift = newGift;
  }

  set giftRate(int newGiftRate) {
    _gift = _gift.copyWith(giftRaiting: newGiftRate);
  }

  set giftName(String newGiftName) {
    _gift = _gift.copyWith(giftName: newGiftName);
  }

  set holidayId(int newHolidayId) {
    _gift = _gift.copyWith(holidayId: newHolidayId);
  }

  int get holidayId => _gift.holidayId;

  set giftComment(String newGiftComment) {
    _gift = _gift.copyWith(giftComment: newGiftComment);
  }

  set photo(Uint8List newPhoto) {
    _gift = _gift.copyWith(photo: newPhoto);
  }

  set whoGave(String newWhoGavePresent) {
    _gift = _gift.copyWith(whoGave: newWhoGavePresent);
  }

  set whoGaveId(int whoGaveId) {
    _gift = _gift.copyWith(whoGaveId: whoGaveId);
  }

  set holidayName(String newHolidayName) {
    _gift = _gift.copyWith(holidayName: newHolidayName);
  }

  Future<void> editGift() async {
    await _giftsService.editGift(_gift);
  }

  Future<void> deleteGift() async {
    await _giftsService.deleteGift(_gift);
  }

  Future<List<Holiday>> getHolidays() async {
    final holidays = await _holidaysService.getHolidays();
    return holidays;
  }
}
