import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/gifts_received/screens/edit_gift_received_screen/edit_gift_received_screen.dart';
import 'package:flutter_template/features/gifts_received/screens/edit_gift_received_screen/edit_gift_received_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';

/// Factory for
EditGiftReceivedScreenWidgetModel editGiftReceivedScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();

  final model = EditGiftReceivedScreenModel(
    appDependencies.errorHandler,
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

/// Interface of [EditGiftReceivedScreenWidgetModel].
abstract class IEditGiftReceivedScreenWidgetModel implements IWidgetModel {
  /// Method to close the debug screens.
  void closeScreen() {}
  /// Method to .
  void whoGavePresentScreen() {}
  /// Method to.
  void chooseHolidayNameScreen() {}
}
