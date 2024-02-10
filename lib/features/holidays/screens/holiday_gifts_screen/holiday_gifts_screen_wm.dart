import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';
import 'package:flutter_template/features/common/domain/data/holiday_with_gifts/holiday_with_gifts_data.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/holidays/screens/holiday_gifts_screen/holiday_gifts_screen.dart';
import 'package:flutter_template/features/holidays/screens/holiday_gifts_screen/holiday_gifts_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';
import 'package:union_state/union_state.dart';

/// Factory for [HolidayGiftsScreenWidgetModel].
///
HolidayGiftsScreenWidgetModel holidayGiftsScreenWmFactory(
  BuildContext context,
) {
  final appScope = context.read<IAppScope>();
  final model = HolidayGiftsScreenModel(appScope.holidaysService, appScope.holidayAndGiftsService, appScope.giftsService);

  return HolidayGiftsScreenWidgetModel(model, appScope.router);
}

/// Widget model for [HolidayGiftsScreen]
class HolidayGiftsScreenWidgetModel extends WidgetModel<HolidayGiftsScreen, HolidayGiftsScreenModel>
    with ThemeWMMixin
    implements IHolidayGiftsScreenWidgetModel {
  /// Create an instance [HolidayGiftsScreenWidgetModel].
  final AppRouter _appRouter;

  HolidayGiftsScreenWidgetModel(
    super._model,
    this._appRouter,
  );

  final _holidayAndGiftsState = UnionStateNotifier<HolidayWithGiftsData>(HolidayWithGiftsData.init());

  Future<void> _getHolidayAndGifts(Holiday holiday) async {
    final holidayWithGifts = await model.getHolidayAndGifts(holiday);
    if (holidayWithGifts != null) {
      _holidayAndGiftsState.content(holidayWithGifts);
    }
  }

  @override
  void initWidgetModel() {
    final args = _appRouter.current.args as HolidayGiftsRouterArgs?;

    if (args != null) {
      model.holiday = args.holiday;
      _getHolidayAndGifts(args.holiday);
    }
    super.initWidgetModel();
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
  void openAddGiftReceivedScreen() {
    _appRouter.push(
      AddGiftReceivedRouter(
        loadAgain: loadAgain,
      ),
    );
  }

  @override
  void openEditGiftsScreen(
    Gift gift,
    Holiday holiday,
  ) {
    _appRouter.push(
      EditGiftReceivedRouter(
        gift: gift,
        loadAgain: loadAgain,
        holiday: holiday,
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
  Future<void> deleteGift(Gift gift) async {
    await model.deleteGift(gift);
    await loadAgain();
    await _appRouter.pop();
  }

  @override
  Future<void> loadAgain() async {
    context.read<IAppScope>().gifRecievedRebuilder.call();
    await _getHolidayAndGifts(model.holiday);
  }

  @override
  UnionStateNotifier<HolidayWithGiftsData> get holidayAndGiftsState => _holidayAndGiftsState;
}

/// Interface of [IHolidayGiftsScreenWidgetModel].
abstract class IHolidayGiftsScreenWidgetModel with ThemeIModelMixin implements IWidgetModel {
  /// Navigate to room screen.
  void openAddHolidayScreen();

  /// Navigate to edit holiday screen.
  void editHolidayScreen(Holiday holiday);

  /// Navigate to edit holiday screen.
  Future<void> deleteGift(Gift gift);

  ///Navigate to add gift received screen
  void openAddGiftReceivedScreen();

  ///Navigate to edit gift screen
  void openEditGiftsScreen(Gift gift, Holiday holiday);

  /// Navigate to load screen again.
  void loadAgain();

  /// Method to get holidays and gifts screen.
  UnionStateNotifier<HolidayWithGiftsData> get holidayAndGiftsState;
}
