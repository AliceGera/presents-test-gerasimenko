import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';
import 'package:flutter_template/features/gifts_received/screens/edit_gift_received_screen/edit_gift_received_screen.dart';
import 'package:flutter_template/features/gifts_received/screens/edit_gift_received_screen/edit_gift_received_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';

/// Factory for
EditGiftReceivedScreenWidgetModel editGiftReceivedScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();
  final appScope = context.read<IAppScope>();
  final model = EditGiftReceivedScreenModel(
    appDependencies.errorHandler,
    appScope.giftsService,
  );
  final router = appDependencies.router;
  return EditGiftReceivedScreenWidgetModel(model, router);
}

/// Widget Model for [EditGiftReceivedScreenWidgetModel].
class EditGiftReceivedScreenWidgetModel extends WidgetModel<EditGiftReceivedScreen, EditGiftReceivedScreenModel> implements IEditGiftReceivedScreenWidgetModel {
  /// Class that coordinates navigation for the whole app.
  final AppRouter router;

  /// Create an instance [EditGiftReceivedScreenModel].
  EditGiftReceivedScreenWidgetModel(
    super._model,
    this.router,
  );

  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _giftNameController = TextEditingController();
  final ValueNotifier<Gift> _giftState = ValueNotifier<Gift>(Gift.init());

  @override
  void dispose() {
    _commentController.dispose();
    _giftNameController.dispose();
    super.dispose();
  }

  @override
  void initWidgetModel() {
    final args = router.current.args as EditGiftReceivedRouterArgs?;

    _commentController.addListener(() {
      model.holidayName = _commentController.text;
    });
    _giftNameController.addListener(() {
      model.giftName = _giftNameController.text;
    });

    if (args != null) {
      model
        ..gift = args.gift
        ..holidayName = args.holiday.holidayName;
      _commentController.text = model.gift.giftComment;
      _giftNameController.text = model.gift.giftName;
      _giftState.value = model.gift;
    }

    super.initWidgetModel();
  }

  @override
  void closeScreen() {
    router.pop();
  }

  @override
  void whoGavePresentScreen() {
    router.push(WhoGavePresentRouter());
  }

  ///метод edit holiday
  Future<void> editGift() async {
    await model.editGift();
    router.pop();
  }

  @override
  Future<void> chooseHolidayNameScreen() async {
    final result = await router.push(HolidayNameRouter());
    if (result is Holiday) {
      model.holidayName = result.holidayName;
      model.holidayId = result.id;
      _giftState.value = model.gift;
    }
  }

  Future<void> deleteGift() async {
    await model.deleteGift();
    if (kDebugMode) {
      print(909090);
    }
    router.pop();
  }

  @override
  TextEditingController get giftNameController => _giftNameController;

  @override
  TextEditingController get commentController => _commentController;

  @override
  ValueNotifier<Gift> get giftState => _giftState;
}

/// Interface of [EditGiftReceivedScreenWidgetModel].
abstract class IEditGiftReceivedScreenWidgetModel implements IWidgetModel {
  /// Method to close the debug screens.
  void closeScreen() {}

  /// Method to .
  void whoGavePresentScreen() {}

  /// Method to.
  void chooseHolidayNameScreen() {}

  /// Method to add holiday.
  Future<void> editGift();

  /// Method to add holiday.
  Future<void> deleteGift();

  /// Method get email controller for email field
  TextEditingController get giftNameController;

  /// Method get date controller for date field
  TextEditingController get commentController;

  ValueNotifier<Gift> get giftState;
}
