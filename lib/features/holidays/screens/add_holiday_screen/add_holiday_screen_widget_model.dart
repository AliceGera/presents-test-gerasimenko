import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/holidays/screens/add_holiday_screen/add_holiday_screen.dart';
import 'package:flutter_template/features/holidays/screens/add_holiday_screen/add_holiday_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';

/// Factory for [AddHolidayScreenWidgetModel].
AddHolidayScreenWidgetModel addHolidayScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();
  final appScope = context.read<IAppScope>();
  final model = AddHolidayScreenModel(
    appDependencies.errorHandler,
    appScope.holidaysService,
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

  final TextEditingController _holidayNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initWidgetModel() {
    _holidayNameController.addListener(() {
      model.holidayName = _holidayNameController.text;
    });
    _dateController.addListener(() {
      model.holidayDate = _dateController.text;
    });

    super.initWidgetModel();
  }

  @override
  void dispose() {
    _holidayNameController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  void closeScreen() {
    router.pop();
  }

  @override
  Future<void> addHoliday() async {
    await model.addHoliday();
    await router.pop();
  }

  @override
  Future<void> savePhoto(Uint8List photo) async {
    model.photo = photo;
  }

  @override
  TextEditingController get holidayNameController => _holidayNameController;

  @override
  TextEditingController get dateController => _dateController;
}

/// Interface of [AddHolidayScreenWidgetModel].
abstract class IAddHolidayScreenWidgetModel implements IWidgetModel {
  /// Method to close screen
  void closeScreen();

  /// Method to add holiday.
  Future<void> addHoliday();

  ///save photo
  void savePhoto(Uint8List photo);

  /// Method get email controller for holiday name field
  TextEditingController get holidayNameController;

  /// Method get date controller for date field
  TextEditingController get dateController;
}
