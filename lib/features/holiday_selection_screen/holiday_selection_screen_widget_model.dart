import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/holiday_selection_screen/holiday_selection_screen.dart';
import 'package:flutter_template/features/holiday_selection_screen/holiday_selection_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';
import 'package:union_state/union_state.dart';

/// Factory for [HolidaySelectionScreenWidgetModel].
HolidaySelectionScreenWidgetModel holidaySelectionScreenWmFactory(
  BuildContext context,
) {
  final appScope = context.read<IAppScope>();

  final model = HolidaySelectionScreenModel(appScope.holidaysService);
  return HolidaySelectionScreenWidgetModel(model, appScope.router);
}

/// Widget model for [HolidaySelectionScreen].
class HolidaySelectionScreenWidgetModel extends WidgetModel<HolidaySelectionScreen, HolidaySelectionScreenModel> with ThemeWMMixin implements IHolidaySelectionScreenWidgetModel {
  /// Create an instance [HolidaySelectionScreenWidgetModel].
  final AppRouter _appRouter;

  HolidaySelectionScreenWidgetModel(super._model, this._appRouter);

  final _holidaysState = UnionStateNotifier<List<Holiday>>([]);

  @override
  void initWidgetModel() {
    _holidaysState.loading();
    _getHolidays();
    super.initWidgetModel();
  }

  Future<void> _getHolidays() async {
    final holidays = await model.getHolidays();
    _holidaysState.content(holidays);
  }

  @override
  Future<void> loadAgain({Holiday? selectedHoliday}) async {

    try {
      await _getHolidays();
      if (context.mounted) {
        if (selectedHoliday != null) {
          final args = _appRouter.current.args is HolidayNameRouterArgs ? _appRouter.current.args! as HolidayNameRouterArgs : null;
          if (args != null) {
            args.updateHoliday?.call(selectedHoliday);
          }
        }
        context.read<IAppScope>().holidayRebuilder.call();
      }
    } on Exception catch (e) {
      _holidaysState.failure(e);
    }

  }

  @override
  void closeScreen() {
    _appRouter.pop();
  }

  @override
  void chooseHoliday(Holiday holiday) {
    _appRouter.pop(holiday);
  }

  @override
  UnionStateNotifier<List<Holiday>> get holidaysState => _holidaysState;
}

/// Interface of [HolidaySelectionScreenWidgetModel].
abstract interface class IHolidaySelectionScreenWidgetModel with ThemeIModelMixin implements IWidgetModel {
  /// Navigate to close screen.
  void closeScreen();

  /// Navigate to choose holiday screen.
  void chooseHoliday(Holiday holiday);

  /// Navigate to load screen again.
  Future<void> loadAgain({Holiday? selectedHoliday});

  /// Method to get holidays screen.
  UnionStateNotifier<List<Holiday>> get holidaysState;
}
