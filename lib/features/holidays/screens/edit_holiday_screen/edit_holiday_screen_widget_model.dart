import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
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
    final args = router.current.args as EditHolidayRouterArgs?;

    if (kDebugMode) {
      print(111111);
      print(args?.holiday.holidayDate);
    }

    _holidayNameController.addListener(() {
      model.holidayName = _holidayNameController.text;
    });
    _dateController.addListener(() {
      model.holidayDate = _dateController.text;
    });
    _holidayNameController.text = args?.holiday.holidayName ?? '';
    if (kDebugMode) {
      print(111112);

    }
    _dateController.text = args?.holiday.holidayDate ?? '';
    if (kDebugMode) {
      print(111113);

    }
    model.photo = args?.holiday.photo ?? Uint8List(0);
    if (kDebugMode) {
      print(111114);

    }
    model.id= args?.holiday.id ?? 0;
    if (kDebugMode) {
      print(111115);

    }
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
  ///метод edit holiday
  Future<void> deleteHoliday() async {
    await model.deleteHoliday();
    if (kDebugMode) {
      print(909090);
    }
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
}
