import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/domain/data/holidays/holiday_data.dart';
import 'package:flutter_template/features/holidays/screens/edit_holiday_screen/edit_holiday_screen.dart';
import 'package:flutter_template/features/holidays/screens/edit_holiday_screen/edit_holiday_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';

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
  final _dateTimeState = ValueNotifier<DateTime?>(null);

  @override
  void initWidgetModel() {
    final args = router.current.args is EditHolidayRouterArgs ? router.current.args! as EditHolidayRouterArgs : null;
    _holidayNameController.addListener(() {
      model.holidayName = _holidayNameController.text;
    });
    if (args != null) {
      _holidayNameController.text = args.holiday.holidayName;
      model
        ..photo = args.holiday.photo
        ..id = args.holiday.id
        ..holidayDate = args.holiday.holidayDate;
      _dateTimeState.value = model.holidayDate;
    }

    super.initWidgetModel();
  }

  @override
  void dispose() {
    _holidayNameController.dispose();
    super.dispose();
  }

  @override
  void initBottomSheetWidgetModel(Holiday holiday) {
    _holidayNameController.text = holiday.holidayName;
    model
      ..photo = holiday.photo
      ..id = holiday.id
      ..holidayDate = holiday.holidayDate;
    _dateTimeState.value = model.holidayDate;
  }

  @override
  void closeScreen() {
    router.pop();
  }

  @override
  Future<void> savePhoto(Uint8List photo) async {
    model.photo = photo;
  }

  @override
  void addDate(DateTime? date) {
    model.holidayDate = date;
    _dateTimeState.value = date;
  }

  @override
  Future<void> editHoliday() async {
    await model.editHoliday();
    await router.pop();
  }

  @override
  Future<void> deleteHoliday() async {
    await model.deleteHoliday();
    await router.pop();
  }

  @override
  TextEditingController get holidayNameController => _holidayNameController;

  @override
  ValueNotifier<DateTime?> get dateTimeState => _dateTimeState;
}

/// Interface of [EditHolidayScreenWidgetModel].
abstract class IEditHolidayScreenWidgetModel implements IWidgetModel {
  /// Method to close screen
  void closeScreen() {}

  /// Method get email controller for holiday name field
  TextEditingController get holidayNameController;

  ///Method to save photo
  void savePhoto(Uint8List photo);

  /// Method to edit holiday.
  Future<void> editHoliday();

  /// Method to delete holiday.
  Future<void> deleteHoliday();

  /// init Bottom Sheet Widget
  void initBottomSheetWidgetModel(Holiday holiday);

  void addDate(DateTime? date);

  ValueNotifier<DateTime?> get dateTimeState;
}
