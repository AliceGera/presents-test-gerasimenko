import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/gifts_received/screens/holiday_name_screen/holiday_name_screen.dart';
import 'package:flutter_template/features/gifts_received/screens/holiday_name_screen/holiday_name_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';

/// Factory for [HolidayNameScreenWidgetModel].
HolidayNameScreenWidgetModel holidayNameScreenWmFactory(
  BuildContext context,
) {
  final appScope = context.read<IAppScope>();

  final model = HolidayNameScreenModel();
  return HolidayNameScreenWidgetModel(model, appScope.router);
}

/// Widget model for [HolidayNameScreen].
class HolidayNameScreenWidgetModel extends WidgetModel<HolidayNameScreen, HolidayNameScreenModel>
    with ThemeWMMixin
    implements IHolidayNameScreenWidgetModel {
  /// Create an instance [HolidayNameScreenWidgetModel].
  final AppRouter _appRouter;

  HolidayNameScreenWidgetModel(super._model, this._appRouter);

  @override
  void closeScreen() {
    _appRouter.pop();
  }
}

/// Interface of [HolidayNameScreenWidgetModel].
abstract interface class IHolidayNameScreenWidgetModel with ThemeIModelMixin implements IWidgetModel {
  /// Navigate to room screen.
  void closeScreen();
}
