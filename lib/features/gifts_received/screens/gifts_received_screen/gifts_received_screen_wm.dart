import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';
import 'package:flutter_template/features/common/domain/data/holiday_with_gifts/holiday_with_gifts_data.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/gifts_received/screens/gifts_received_screen/gifts_received_screen.dart';
import 'package:flutter_template/features/gifts_received/screens/gifts_received_screen/gifts_received_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';
import 'package:union_state/union_state.dart';

/// Factory for [GiftsReceivedScreenWidgetModel].
GiftsReceivedScreenWidgetModel giftsReceivedScreenWmFactory(
  BuildContext context,
) {
  final appScope = context.read<IAppScope>();

  final model = GiftsReceivedScreenModel(appScope.holidayAndGiftsService, appScope.giftsService);
  return GiftsReceivedScreenWidgetModel(model, appScope.router);
}

/// Widget model for [GiftsReceivedScreen].
class GiftsReceivedScreenWidgetModel extends WidgetModel<GiftsReceivedScreen, GiftsReceivedScreenModel>
    with ThemeWMMixin
    implements IGiftsReceivedScreenWidgetModel {
  /// Create an instance [GiftsReceivedScreenWidgetModel].
  final AppRouter _appRouter;

  GiftsReceivedScreenWidgetModel(
    super._model,
    this._appRouter,
  );

  final _giftsState = UnionStateNotifier<List<HolidayWithGiftsData>>([]);

  @override
  void initWidgetModel() {
    _getGifts();
    super.initWidgetModel();
  }

  Future<void> _getGifts() async {
    final gifts = await model.getGifts();
    _giftsState.content(gifts);
  }

  @override
  void loadAgain() {
    _getGifts();
  }

  @override
  void openAddGiftScreen() {
    _appRouter.push(AddGiftReceivedRouter(loadAgain: loadAgain));
  }

  @override
  void editGiftsScreen(Gift gift, Holiday holiday) {
    _appRouter.push(
      EditGiftReceivedRouter(
        gift: gift,
        loadAgain: loadAgain,
        holiday: holiday,
      ),
    );
  }

  ///метод delete
  Future<void> deleteGift(Gift gift) async {
    await model.deleteGift(gift);
    await _getGifts();
    _appRouter.pop();
  }

  @override
  UnionStateNotifier<List<HolidayWithGiftsData>> get giftsState => _giftsState;
}

/// Interface of [GiftsReceivedScreenWidgetModel].
abstract interface class IGiftsReceivedScreenWidgetModel with ThemeIModelMixin implements IWidgetModel {
  /// Navigate to room screen.
  void openAddGiftScreen();

  /// Navigate to edit Gift screen.
  void editGiftsScreen(Gift gifts, Holiday holiday);

  /// Navigate to load screen again.
  void loadAgain();

  /// Method to get holidays screen.
  UnionStateNotifier<List<HolidayWithGiftsData>> get giftsState;

  /// Method to add holiday.
  Future<void> deleteGift(Gift gift);
}
