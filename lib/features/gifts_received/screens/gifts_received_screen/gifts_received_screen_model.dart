import 'dart:typed_data';

import 'package:elementary/elementary.dart';
import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';
import 'package:flutter_template/features/common/domain/data/holiday_with_gifts/holiday_with_gifts_data.dart';
import 'package:flutter_template/features/common/service/gifts_service.dart';
import 'package:flutter_template/features/common/service/holidays_and_gifts_service.dart';

/// Model fol
class GiftsReceivedScreenModel extends ElementaryModel {
  GiftsReceivedScreenModel(this._holidayAndGiftsService,this._giftsService) : super();
  final GiftsService _giftsService;
  final HolidayAndGiftsService _holidayAndGiftsService;
  Gift _gift = Gift.init();

  Gift get gift => _gift;

  set gift(Gift newGift) {
    _gift = newGift;
  }

  set giftName(String newGiftName) {
    _gift = _gift.copyWith(giftName: newGiftName);
  }

  set holidayId(int newHolidayId) {
    _gift = _gift.copyWith(holidayId: newHolidayId);
  }

  set giftComment(String newGiftComment) {
    _gift = _gift.copyWith(giftComment: newGiftComment);
  }

  set photo(Uint8List newPhoto) {
    _gift = _gift.copyWith(photo: newPhoto);
  }

  set whoGavePresent(String newWhoGavePresent) {
    _gift = _gift.copyWith(whoGave: newWhoGavePresent);
  }

  set holidayName(String newHolidayName) {
    _gift = _gift.copyWith(holidayName: newHolidayName);
  }

  Future<void> editGift() async {
    await _giftsService.editGift(_gift);
  }

  Future<void> deleteGift(Gift gift) async {
    await _giftsService.deleteGift(gift);
  }

  Future<List<HolidayWithGiftsData>> getGifts() async {
    final gifts = await _holidayAndGiftsService.getHolidaysWithGifts();
    return gifts;
  }

}
