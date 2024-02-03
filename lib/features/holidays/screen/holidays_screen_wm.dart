import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/holidays/screen/holidays_screen.dart';
import 'package:flutter_template/features/holidays/screen/holidays_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';

/// Factory for [HolidaysScreenWidgetModel].
HolidaysScreenWidgetModel holidaysScreenWmFactory(
  BuildContext context,
) {
  final appScope = context.read<IAppScope>();
  final model = HolidaysScreenModel();

  return HolidaysScreenWidgetModel(model, appScope.router);
}

/// Widget model for [HolidaysScreen].
class HolidaysScreenWidgetModel extends WidgetModel<HolidaysScreen, HolidaysScreenModel> with ThemeWMMixin implements IHolidaysScreenWidgetModel {
  /// Create an instance [HolidaysScreenWidgetModel].
  final AppRouter _appRouter;

  HolidaysScreenWidgetModel(
    super._model,
    this._appRouter,
  );

  @override
  void openNextScreen() {
    _appRouter.push(AddHolidayRouter());
  }
}

/// Interface of [IHolidaysScreenWidgetModel].
abstract class IHolidaysScreenWidgetModel with ThemeIModelMixin implements IWidgetModel {
  /// Navigate to room screen.
  void openNextScreen();
}
