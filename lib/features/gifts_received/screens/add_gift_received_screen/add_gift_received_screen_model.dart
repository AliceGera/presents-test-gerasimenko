import 'dart:typed_data';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/config/app_config.dart';
import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';
import 'package:flutter_template/features/common/service/gifts_service.dart';

/// Model for
class AddGiftReceivedScreenModel extends ElementaryModel {
  /// Interface for handle error in business logic.
  final ErrorHandler errorHandler;
  final GiftsService _giftsService;

  /// Config change Notifier.
  late ValueNotifier<AppConfig> configNotifier;
  String _giftName = '';
  String _giftComment = '';
  int _holidayId = 0;
  Uint8List _photo = Uint8List(0);

  String _whoGavePresent = '';

  String _holidayName = '';

  String get giftName => _giftName;

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

  String get holidayName => _holidayName;

  set holidayName(String newHolidayName) {
    _holidayName = newHolidayName;
  }

  Future<void> addGift() async {
    await _giftsService.addGift(
      Gift(
        id: 1,
        photo: _photo,
        giftsRaiting: 0,
        giftsName: _giftName,
        giftsPrice: 0,
        isReceivedGifts: true,
        whoGave: _whoGavePresent,
        holidaysId: _holidayId,
        giftsComment: _giftComment,
      ),
    );
  }

  /// Create an instance [AddGiftReceivedScreenModel].
  AddGiftReceivedScreenModel(
    this.errorHandler,
      this._giftsService ,
  ) : super(errorHandler: errorHandler);
}
