import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';
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
  final model = HolidaysScreenModel(
    appScope.holidaysService,
    appScope.holidayAndGiftsService,
  );

  return HolidaysScreenWidgetModel(
    model,
    appScope.router,
    appScope as AppScope,
  );
}

/// Widget model for [HolidaysScreen]
class HolidaysScreenWidgetModel extends WidgetModel<HolidaysScreen, HolidaysScreenModel> with ThemeWMMixin implements IHolidaysScreenWidgetModel {
  /// Create an instance [HolidaysScreenWidgetModel].
  final AppRouter _appRouter;
  final AppScope _appScope;

  HolidaysScreenWidgetModel(
    super._model,
    this._appRouter,
    this._appScope,
  );

  final _holidaysState = UnionStateNotifier<List<Holiday>>([]);

  @override
  void initWidgetModel() {
    _holidaysState.loading();
    _getHolidays();
    _appScope.holidayRebuilder = _getHolidays;
    super.initWidgetModel();
  }

  Future<void> _getHolidays() async {
    try {
      final holidays = await model.getHolidays();
      _holidaysState.content(holidays);
    } on Exception catch (e) {
      _holidaysState.failure(e);
    }
  }

  @override
  void openAddHolidayScreen() {
    _appRouter.push(
      AddHolidayRouter(
        loadAgain: loadAgain,
      ),
    );
  }

  @override
  void editHolidayScreen(Holiday holiday) {
    _appRouter.push(
      EditHolidayRouter(
        holiday: holiday,
        loadAgain: loadAgain,
      ),
    );
  }

  @override
  void openHolidayGiftsScreen(Holiday holiday) {
    _appRouter.push(HolidayGiftsRouter(holiday: holiday));
  }

  @override
  Future<void> deleteHolidayScreen(Holiday holiday) async {
    await model.deleteHolidays(holiday);
    await loadAgain();
    await _appRouter.pop();
  }

  @override
  Future<void> loadAgain() async {
    _appScope.giftRecievedRebuilder.call();
    _appScope.giftGivenRebuilder.call();
    await _getHolidays();
  }

  @override
  UnionStateNotifier<List<Holiday>> get holidaysState => _holidaysState;
}

/// Interface of [IHolidaysScreenWidgetModel].
abstract class IHolidaysScreenWidgetModel with ThemeIModelMixin implements IWidgetModel {
  /// Navigate to add screen.
  void openAddHolidayScreen();

  /// Navigate to edit holiday screen.
  void editHolidayScreen(Holiday holiday);

  ///Navigate to screen with holidays gifts(received and given)
  void openHolidayGiftsScreen(Holiday holiday);

  /// Delete holiday.
  Future<void> deleteHolidayScreen(Holiday holiday);

  /// Navigate to load screen again.
 void loadAgain();

  /// Method to get holidays screen.
  UnionStateNotifier<List<Holiday>> get holidaysState;
}
