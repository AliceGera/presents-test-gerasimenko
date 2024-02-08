import 'dart:typed_data';

import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/domain/data/gifts/gift_data.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';
import 'package:flutter_template/features/gifts_received/screens/add_gift_received_screen/add_gift_received_screen.dart';
import 'package:flutter_template/features/gifts_received/screens/add_gift_received_screen/add_gift_received_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';
import 'package:union_state/union_state.dart';

// ignore_for_file: avoid_positional_boolean_parameters

/// Factory for [AddGiftReceivedScreenWidgetModel].
AddGiftReceivedScreenWidgetModel addGiftReceivedScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();
  final appScope = context.read<IAppScope>();
  final model = AddGiftReceivedScreenModel(
    appDependencies.errorHandler,
    appScope.giftsService,
  );
  final router = appDependencies.router;
  return AddGiftReceivedScreenWidgetModel(model, router);
}

/// Widget Model for [AddGiftReceivedScreen].
class AddGiftReceivedScreenWidgetModel extends WidgetModel<AddGiftReceivedScreen, AddGiftReceivedScreenModel> implements IAddGiftReceivedScreenWidgetModel {
  /// Class that coordinates navigation for the whole app.
  final AppRouter router;

  /// Create an instance [AddGiftReceivedScreenModel].
  AddGiftReceivedScreenWidgetModel(
    super._model,
    this.router,
  );
  final _giftsState = UnionStateNotifier<Gift>(Gift.init());
  final _holidayNameState = ValueNotifier<String?>(null);
  final TextEditingController _giftNameController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  @override
  void initWidgetModel() {
    _giftNameController.addListener(() {
      model.giftName = _giftNameController.text;
    });
    _commentController.addListener(() {
      model.giftComment = _commentController.text;
    });

    super.initWidgetModel();
  }

  @override
  void dispose() {
    _giftNameController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  void closeScreen() {
    router.pop();
  }

  @override
  void whoGavePresentScreen() {
    router.push(PersonRouter());
  }

  @override
  void chooseHolidayNameScreen() async {
    final result = await router.push(HolidayNameRouter());
    if (result is Holiday) {
      model.holidayName = result.holidayName;
      model.holidayId = result.id;
      _holidayNameState.value = model.holidayName;
    }
  }

  @override
  TextEditingController get giftNameController => _giftNameController;

  @override
  TextEditingController get commentController => _commentController;

  @override
  void savePhoto(Uint8List photo) async {
    model.photo = photo;
  }

  @override
  void saveWhoGavePresent(String whoGavePresent) async {
    model.whoGavePresent = whoGavePresent;
  }

  @override
  void saveHolidayName(String holidayName, int holidayId) async {
    model.holidayName = holidayName;
    model.holidayId = holidayId;
  }

  ///метод добавления holiday
  @override
  Future<void> addGift() async {
    await model.addGift();
    if (kDebugMode) {
      print(9999999);
    }
    await router.pop();
  }

  @override
  UnionStateNotifier<Gift> get giftsState => _giftsState;

  @override
  ValueNotifier<String?> get holidayNameState => _holidayNameState;
}

/// Interface of [AddGiftReceivedScreenWidgetModel].
abstract class IAddGiftReceivedScreenWidgetModel implements IWidgetModel {
  /// Method to close the debug screens.
  void closeScreen() {}

  /// Method to .
  void whoGavePresentScreen() {}

  /// Method to.
  void chooseHolidayNameScreen() {}

  /// Method get email controller for email field
  TextEditingController get giftNameController;

  /// Method get date controller for date field
  TextEditingController get commentController;

  ///
  Future<void> addGift();

  ///
  void savePhoto(Uint8List photo);

  ///
  void saveWhoGavePresent(String whoGavePresent);

  ///
  void saveHolidayName(String holidayName, int holidayId);

  /// Method to get holidays screen.
  UnionStateNotifier<Gift> get giftsState;

  ValueNotifier<String?> get holidayNameState;
}
