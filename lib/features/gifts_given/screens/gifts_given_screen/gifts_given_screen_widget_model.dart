import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';
import 'package:flutter_template/features/common/domain/data/holiday_with_gifts/holiday_with_gifts_data.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/gifts_given/screens/gifts_given_screen/gifts_given_screen.dart';
import 'package:flutter_template/features/gifts_given/screens/gifts_given_screen/gifts_given_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';
import 'package:union_state/union_state.dart';

/// Factory for [GiftsGivenScreenWidgetModel].
GiftsGivenScreenWidgetModel giftsGivenScreenWmFactory(
  BuildContext context,
) {
  final appScope = context.read<IAppScope>();

  final model = GiftsGivenScreenModel(
    appScope.holidayAndGiftsService,
    appScope.giftsService,
  );
  return GiftsGivenScreenWidgetModel(
    model,
    appScope.router,
    appScope as AppScope,
  );
}

/// Widget model for [GiftsGivenScreen].
class GiftsGivenScreenWidgetModel extends WidgetModel<GiftsGivenScreen, GiftsGivenScreenModel> with ThemeWMMixin implements IGiftsGivenScreenWidgetModel {
  /// Create an instance [GiftsGivenScreenWidgetModel].
  final AppRouter router;
  final AppScope _appScope;

  GiftsGivenScreenWidgetModel(
    super._model,
    this.router,
    this._appScope,
  );

  final _giftsState = UnionStateNotifier<List<HolidayWithGiftsData>>([]);

  @override
  void initWidgetModel() {
    _appScope.giftGivenRebuilder = loadAgain;
    _getGifts();
    super.initWidgetModel();
  }

  Future<void> _getGifts() async {
    _giftsState.loading();
    try {
      final gifts = await model.getGifts();
      _giftsState.content(gifts);
    } on Exception catch (e) {
      _giftsState.failure(e);
    }
  }

  @override
  void loadAgain() {
    _getGifts();
  }

  @override
  void openAddGiftScreen() {
    router.push(
      AddGiftGivenRouter(
        loadAgain: loadAgain,
      ),
    );
  }

  @override
  void editGiftsScreen(Gift gift, Holiday holiday) {
    router.push(
      EditGiftGivenRouter(
        gift: gift,
        loadAgain: loadAgain,
        holiday: holiday,
      ),
    );
  }

  @override
  Future<void> deleteGift(Gift gift) async {
    await model.deleteGift(gift);
    await _getGifts();
    await router.pop();
  }

  @override
  UnionStateNotifier<List<HolidayWithGiftsData>> get giftsState => _giftsState;
}

/// Interface of [GiftsGivenScreenWidgetModel].
abstract interface class IGiftsGivenScreenWidgetModel with ThemeIModelMixin implements IWidgetModel {
  /// Navigate to add gift screen.
  void openAddGiftScreen();

  /// Navigate to edit gift screen.
  void editGiftsScreen(Gift gifts, Holiday holiday);

  /// Navigate to load screen again.
  void loadAgain();

  /// Method to get gifts screen.
  UnionStateNotifier<List<HolidayWithGiftsData>> get giftsState;

  /// Method to delete gift.
  Future<void> deleteGift(Gift gift);
}
