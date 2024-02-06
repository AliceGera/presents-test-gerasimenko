import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holidays_data.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/holidays/screens/holidays_screen/holidays_screen.dart';
import 'package:flutter_template/features/holidays/screens/holidays_screen/holidays_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';
import 'package:union_state/union_state.dart';

/// Factory for [HolidaysScreenWidgetModel].
HolidaysScreenWidgetModel holidaysScreenWmFactory(
  BuildContext context,
) {
  final appScope = context.read<IAppScope>();
  final model = HolidaysScreenModel(appScope.holidaysService);

  return HolidaysScreenWidgetModel(model, appScope.router);
}

/// Widget model for [HolidaysScreen]
class HolidaysScreenWidgetModel extends WidgetModel<HolidaysScreen, HolidaysScreenModel> with ThemeWMMixin implements IHolidaysScreenWidgetModel {
  /// Create an instance [HolidaysScreenWidgetModel].
  final AppRouter _appRouter;

  HolidaysScreenWidgetModel(
    super._model,
    this._appRouter,
  );

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
  void openNextScreen() {
    _appRouter.push(AddHolidayRouter(loadAgain:loadAgain));
  }

  @override
  void editHolidayScreen(Holiday holiday) {
    if (kDebugMode) {
      print(33333);
    }
    _appRouter.push(EditHolidayRouter(holiday:  holiday,loadAgain:loadAgain));
  }

  @override
  void loadAgain() {
    _getHolidays();
  }

  @override
  UnionStateNotifier<List<Holiday>> get holidaysState => _holidaysState;
}

/// Interface of [IHolidaysScreenWidgetModel].
abstract class IHolidaysScreenWidgetModel with ThemeIModelMixin implements IWidgetModel {
  /// Navigate to room screen.
  void openNextScreen();

  /// Navigate to edit holiday screen.
  void editHolidayScreen(Holiday holiday);

  /// Navigate to load screen again.
  void loadAgain();

  /// Method to get holidays screen.
  UnionStateNotifier<List<Holiday>> get holidaysState;
}
