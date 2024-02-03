import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/gifts_received/screen/gifts_received_screen.dart';
import 'package:flutter_template/features/gifts_received/screen/gifts_received_screen_model.dart';

/// Factory for [GiftsReceivedScreenWidgetModel].
GiftsReceivedScreenWidgetModel giftsReceivedScreenWmFactory(
  BuildContext context,
) {
  final model = GiftsReceivedScreenModel();
  return GiftsReceivedScreenWidgetModel(model);
}

/// Widget model for [GiftsReceivedScreen].
class GiftsReceivedScreenWidgetModel extends WidgetModel<GiftsReceivedScreen, GiftsReceivedScreenModel>
    with ThemeWMMixin
    implements IGiftsReceivedScreenWidgetModel {
  /// Create an instance [GiftsReceivedScreenWidgetModel].
  GiftsReceivedScreenWidgetModel(super._model);
}

/// Interface of [GiftsReceivedScreenWidgetModel].
abstract interface class IGiftsReceivedScreenWidgetModel with ThemeIModelMixin implements IWidgetModel {}
