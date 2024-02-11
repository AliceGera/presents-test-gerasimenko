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
    _holidayAndGiftsState.loading();
    final args = _appRouter.current.args as HolidayGiftsRouterArgs?;

    if (args != null) {
      model.holiday = args.holiday;
      _getHolidayAndGifts(args.holiday);
    }
    super.initWidgetModel();
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
  void openAddGiftGivenScreen() {
    _appRouter.push(
      AddGiftGivenRouter(
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
        updateHoliday: (selectedHoliday) {
          model.holiday = selectedHoliday;
          _holidayAndGiftsState.content(
            HolidayWithGiftsData(
              giftsGiven: _holidayAndGiftsState.value.data?.giftsGiven ?? [],
              giftsReceived: _holidayAndGiftsState.value.data?.giftsReceived ?? [],
              holiday: selectedHoliday,
            ),
          );
        },
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

    try {
      context.read<IAppScope>().giftRecievedRebuilder.call();
      context.read<IAppScope>().giftGivenRebuilder.call();
      await _getHolidayAndGifts(model.holiday);
    } on Exception catch (e) {
      _holidayAndGiftsState.failure(e);
    }

  }

  @override
  UnionStateNotifier<HolidayWithGiftsData> get holidayAndGiftsState => _holidayAndGiftsState;
}

/// Interface of [IHolidayGiftsScreenWidgetModel].
abstract class IHolidayGiftsScreenWidgetModel with ThemeIModelMixin implements IWidgetModel {
  /// Navigate to edit holiday screen.
  Future<void> deleteGift(Gift gift);

  ///Navigate to add gift received screen
  void openAddGiftReceivedScreen();

  ///Navigate to add gift given screen
  void openAddGiftGivenScreen();

  ///Navigate to edit gift screen
  void openEditGiftsScreen(Gift gift, Holiday holiday);

  /// Navigate to load screen again.
  void loadAgain();

  /// Method to get holidays and gifts screen.
  UnionStateNotifier<HolidayWithGiftsData> get holidayAndGiftsState;
}
