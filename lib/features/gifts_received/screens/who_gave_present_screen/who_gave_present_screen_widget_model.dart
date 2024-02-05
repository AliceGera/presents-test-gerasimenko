import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/gifts_received/screens/gifts_received_screen/gifts_received_screen.dart';
import 'package:flutter_template/features/gifts_received/screens/gifts_received_screen/gifts_received_screen_model.dart';
import 'package:flutter_template/features/gifts_received/screens/who_gave_present_screen/who_gave_present_screen.dart';
import 'package:flutter_template/features/gifts_received/screens/who_gave_present_screen/who_gave_present_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';

/// Factory for [WhoGavePresentScreenWidgetModel].
WhoGavePresentScreenWidgetModel whoGavePresentScreenWmFactory(
  BuildContext context,
) {
  final appScope = context.read<IAppScope>();

  final model = WhoGavePresentScreenModel();
  return WhoGavePresentScreenWidgetModel(model, appScope.router);
}

/// Widget model for [WhoGavePresentScreen].
class WhoGavePresentScreenWidgetModel extends WidgetModel<WhoGavePresentScreen, WhoGavePresentScreenModel>
    with ThemeWMMixin
    implements IWhoGavePresentScreenWidgetModel {
  /// Create an instance [WhoGavePresentScreenWidgetModel].
  final AppRouter _appRouter;

  WhoGavePresentScreenWidgetModel(super._model, this._appRouter);

  @override
  void closeScreen() {
    _appRouter.pop();
  }

}

/// Interface of [WhoGavePresentScreenWidgetModel].
abstract interface class IWhoGavePresentScreenWidgetModel with ThemeIModelMixin implements IWidgetModel {
  /// Navigate to  screen.
  void closeScreen();

}
