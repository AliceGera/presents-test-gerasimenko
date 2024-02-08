import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';
import 'package:flutter_template/features/holidays/screens/edit_holiday_screen/edit_holiday_screen.dart';
import 'package:flutter_template/features/holidays/screens/edit_holiday_screen/edit_holiday_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';

// ignore_for_file: avoid_positional_boolean_parameters

/// Factory for [EditHolidayScreenWidgetModel].
EditHolidayScreenWidgetModel editHolidayScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();
  final appScope = context.read<IAppScope>();
  final model = EditHolidayScreenModel(
    appDependencies.errorHandler,
    appScope.holidaysService,
  );
  final router = appDependencies.router;
  return EditHolidayScreenWidgetModel(model, router);
}

/// Widget Model for [EditHolidayScreen].
class EditHolidayScreenWidgetModel extends WidgetModel<EditHolidayScreen, EditHolidayScreenModel> implements IEditHolidayScreenWidgetModel {
  /// Class that coordinates navigation for the whole app.
  final AppRouter router;

  /// Create an instance [EditHolidayScreenModel].
  EditHolidayScreenWidgetModel(
    super._model,
    this.router,
  );

  final TextEditingController _holidayNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initWidgetModel() {
    final args = router.current.args is EditHolidayRouterArgs ? router.current.args! as EditHolidayRouterArgs : null;

    _holidayNameController.addListener(() {
      model.holidayName = _holidayNameController.text;
    });
    _dateController.addListener(() {
      model.holidayDate = _dateController.text;
    });
    if (args != null) {
      _holidayNameController.text = args.holiday.holidayName;
      _dateController.text = args.holiday.holidayDate;
      model.photo = args.holiday.photo;
      model.id = args.holiday.id;
    }

    super.initWidgetModel();
  }

  @override
  void initBottomSheetWidgetModel(Holiday holiday) {
    _holidayNameController.text = holiday.holidayName;
    _dateController.text = holiday.holidayDate;
    model
      ..photo = holiday.photo
      ..id = holiday.id;
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
  TextEditingController get holidayNameController => _holidayNameController;

  @override
  TextEditingController get dateController => _dateController;

  ///метод добавления holiday
  @override
  void savePhoto(Uint8List photo) async {
    model.photo = photo;
  }

  ///метод edit holiday
  Future<void> editHoliday() async {
    await model.editHoliday();
    router.pop();
  }

  ///метод delete holiday
  Future<void> deleteHoliday() async {
    await model.deleteHoliday();

    router.pop();
  }
}

/// Interface of [EditHolidayScreenWidgetModel].
abstract class IEditHolidayScreenWidgetModel implements IWidgetModel {
  /// Method to close the debug screens.
  void closeScreen() {}

  /// Method get email controller for email field
  TextEditingController get holidayNameController;

  /// Method get date controller for date field
  TextEditingController get dateController;

  void savePhoto(Uint8List photo);

  /// Method to add holiday.
  Future<void> editHoliday();

  /// Method to add holiday.
  Future<void> deleteHoliday();

  void initBottomSheetWidgetModel(Holiday holiday);
}
