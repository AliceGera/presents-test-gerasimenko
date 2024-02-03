import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/add_holiday/screen/add_holiday_screen/add_holiday_screen.dart';
import 'package:flutter_template/features/add_holiday/screen/add_holiday_screen/add_holiday_screen_model.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';

import 'package:flutter_template/features/edit_holiday/screen/edit_holiday_screen/edit_holiday_screen.dart';
import 'package:flutter_template/features/edit_holiday/screen/edit_holiday_screen/edit_holiday_screen_model.dart';

// ignore_for_file: avoid_positional_boolean_parameters

/// Factory for [EditHolidayScreenWidgetModel].
EditHolidayScreenWidgetModel editHolidayScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();

  final model = EditHolidayScreenModel(
    appDependencies.errorHandler,

  );
  final router = appDependencies.router;
  return EditHolidayScreenWidgetModel(model, router);
}

/// Widget Model for [AddHolidayScreen].
class EditHolidayScreenWidgetModel extends WidgetModel<EditHolidayScreen, EditHolidayScreenModel> implements IEditHolidayScreenWidgetModel {
  /// Class that coordinates navigation for the whole app.
  final AppRouter router;

  /// Create an instance [EditHolidayScreenModel].
  EditHolidayScreenWidgetModel(
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

/// Interface of [EditHolidayScreenWidgetModel].
abstract class IEditHolidayScreenWidgetModel implements IWidgetModel {
  /// Method to close the debug screens.
  void closeScreen() {}
}
