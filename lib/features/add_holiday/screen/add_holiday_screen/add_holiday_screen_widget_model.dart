import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/add_holiday/screen/add_holiday_screen/add_holiday_screen.dart';
import 'package:flutter_template/features/add_holiday/screen/add_holiday_screen/add_holiday_screen_model.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';

// ignore_for_file: avoid_positional_boolean_parameters

/// Factory for [AddHolidayScreenWidgetModel].
AddHolidayScreenWidgetModel addHolidayScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();

  final model = AddHolidayScreenModel(
    appDependencies.errorHandler,

  );
  final router = appDependencies.router;
  return AddHolidayScreenWidgetModel(model, router);
}

/// Widget Model for [AddHolidayScreen].
class AddHolidayScreenWidgetModel extends WidgetModel<AddHolidayScreen, AddHolidayScreenModel> implements IAddHolidayScreenWidgetModel {
  /// Class that coordinates navigation for the whole app.
  final AppRouter router;

  /// Create an instance [AddHolidayScreenModel].
  AddHolidayScreenWidgetModel(
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
}

/// Interface of [AddHolidayScreenWidgetModel].
abstract class IAddHolidayScreenWidgetModel implements IWidgetModel {
  /// Method to close the debug screens.
  void closeScreen() {}
}
