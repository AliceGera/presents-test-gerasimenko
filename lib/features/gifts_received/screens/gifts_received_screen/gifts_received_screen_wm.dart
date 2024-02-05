import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/gifts_received/screens/gifts_received_screen/gifts_received_screen.dart';
import 'package:flutter_template/features/gifts_received/screens/gifts_received_screen/gifts_received_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';

/// Factory for [GiftsReceivedScreenWidgetModel].
GiftsReceivedScreenWidgetModel giftsReceivedScreenWmFactory(
  BuildContext context,
) {
  final appScope = context.read<IAppScope>();

  final model = GiftsReceivedScreenModel();
  return GiftsReceivedScreenWidgetModel(model,appScope.router);
}

/// Widget model for [GiftsReceivedScreen].
class GiftsReceivedScreenWidgetModel extends WidgetModel<GiftsReceivedScreen, GiftsReceivedScreenModel>
    with ThemeWMMixin
    implements IGiftsReceivedScreenWidgetModel {
  /// Create an instance [GiftsReceivedScreenWidgetModel].
  final AppRouter _appRouter;

  GiftsReceivedScreenWidgetModel(super._model, this._appRouter);

  @override
  void openAddGiftScreen() {
    _appRouter.push(AddGiftReceivedRouter());
  }

  @override
  void editGiftReceived() {
    _appRouter.push(EditGiftReceivedRouter());
  }
}

/// Interface of [GiftsReceivedScreenWidgetModel].
abstract interface class IGiftsReceivedScreenWidgetModel with ThemeIModelMixin implements IWidgetModel {
  /// Navigate to room screen.
  void openAddGiftScreen();

  /// Navigate to room screen.
  void editGiftReceived();
}
