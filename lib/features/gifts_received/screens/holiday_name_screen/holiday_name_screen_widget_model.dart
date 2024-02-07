import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/gifts_received/screens/holiday_name_screen/holiday_name_screen.dart';
import 'package:flutter_template/features/gifts_received/screens/holiday_name_screen/holiday_name_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';
import 'package:union_state/union_state.dart';

/// Factory for [HolidayNameScreenWidgetModel].
HolidayNameScreenWidgetModel holidayNameScreenWmFactory(
  BuildContext context,
) {
  final appScope = context.read<IAppScope>();

  final model = HolidayNameScreenModel(appScope.holidaysService);
  return HolidayNameScreenWidgetModel(model, appScope.router);
}

/// Widget model for [HolidayNameScreen].
class HolidayNameScreenWidgetModel extends WidgetModel<HolidayNameScreen, HolidayNameScreenModel>
    with ThemeWMMixin
    implements IHolidayNameScreenWidgetModel {
  /// Create an instance [HolidayNameScreenWidgetModel].
  final AppRouter _appRouter;

  HolidayNameScreenWidgetModel(super._model, this._appRouter);
  final _holidaysState = UnionStateNotifier<List<Holiday>>([]);

  @override
  void initWidgetModel() {
    _getHolidays();
    super.initWidgetModel();
  }

  Future<void> _getHolidays() async {
    final holidays = await model.getHolidays();
    //await Future.delayed(const Duration(milliseconds: 100));
    _holidaysState.content(holidays);
  }

  @override
  void openAddHolidayScreen() {
    _appRouter.push(AddHolidayRouter(loadAgain: loadAgain));
  }

  @override
  void editHolidayScreen(Holiday holiday) {
    _appRouter.push(EditHolidayRouter(holiday: holiday, loadAgain: loadAgain));
  }


  @override
  void loadAgain() {
    _getHolidays();
  }

  @override
  UnionStateNotifier<List<Holiday>> get holidaysState => _holidaysState;

  @override
  void closeScreen() {
    _appRouter.pop();
  }

  @override
  void chooseHoliday(Holiday holiday) {

    _appRouter.pop(holiday);

  }
}

/// Interface of [HolidayNameScreenWidgetModel].
abstract interface class IHolidayNameScreenWidgetModel with ThemeIModelMixin implements IWidgetModel {
  /// Navigate to room screen.
  void closeScreen();

  /// Navigate to room screen.
  void openAddHolidayScreen();

  /// Navigate to edit holiday screen.
  void editHolidayScreen(Holiday holiday);

  /// Navigate to edit holiday screen.
  void chooseHoliday(Holiday holiday);

  /// Navigate to load screen again.
  void loadAgain();

  /// Method to get holidays screen.
  UnionStateNotifier<List<Holiday>> get holidaysState;
}
