import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/gifts_received/screens/add_gift_received_screen/add_gift_received_screen.dart';
import 'package:flutter_template/features/gifts_received/screens/add_gift_received_screen/add_gift_received_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';

// ignore_for_file: avoid_positional_boolean_parameters

/// Factory for [AddGiftReceivedScreenWidgetModel].
AddGiftReceivedScreenWidgetModel addGiftReceivedScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();

  final model = AddGiftReceivedScreenModel(
    appDependencies.errorHandler,

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

  @override
  void initWidgetModel() {
    super.initWidgetModel();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void closeScreen() {
    router.pop();
  }

  @override
  void whoGavePresentScreen() {
    router.push(WhoGavePresentRouter());
  }

  @override
  void chooseHolidayNameScreen() {
    router.push(HolidayNameRouter());
  }
}

/// Interface of [AddGiftReceivedScreenWidgetModel].
abstract class IAddGiftReceivedScreenWidgetModel implements IWidgetModel {
  /// Method to close the debug screens.
  void closeScreen() {}
  /// Method to .
  void whoGavePresentScreen() {}
  /// Method to.
  void chooseHolidayNameScreen() {}
}
