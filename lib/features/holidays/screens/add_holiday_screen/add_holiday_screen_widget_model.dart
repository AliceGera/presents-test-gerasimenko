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
  final _dateTimeState = ValueNotifier<DateTime?>(null);
  final _dateTimeMessageState = ValueNotifier<String?>(null);

  final GlobalKey<FormState> _formHolidayNameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formDateTimeKey = GlobalKey<FormState>();

  String? _holidayNameValidationText;
  String? _dateTimeValidationText;

  @override
  void initWidgetModel() {
    _holidayNameController.addListener(() {
      if (_holidayNameValidationText != null && _holidayNameValidationText!.isNotEmpty) {
        _holidayNameValidationText = null;
        _formHolidayNameKey.currentState?.validate();
      }
      model.holidayName = _holidayNameController.text;
    });

    super.initWidgetModel();
  }

  @override
  void dispose() {
    _holidayNameController.dispose();
    super.dispose();
  }

  @override
  void addDate(DateTime? date) {
    model.holidayDate = date;
    _dateTimeState.value = date;
    _dateTimeMessageState.value = null;
  }

  @override
  void closeScreen() {
    router.pop();
  }

  @override
  Future<void> addHoliday() async {
    final isHolidayNameCorrect = _holidayNameController.text.isNotEmpty;
    if (!isHolidayNameCorrect) {
      _holidayNameValidationText = 'error';
      _formHolidayNameKey.currentState?.validate();
    }
    final isDateTimeCorrect = _dateTimeState.value != null;
    if (!isDateTimeCorrect) {
      _dateTimeMessageState.value = 'error';
    }
    if (isHolidayNameCorrect && isDateTimeCorrect) {
      await model.addHoliday();
      await router.pop();
    }
  }

  @override
  Future<void> savePhoto(Uint8List photo) async {
    model.photo = photo;
  }

  @override
  String? getHolidayNameValidationText() => _holidayNameValidationText;

  @override
  String? getDateTimeValidationText() => _dateTimeValidationText;

  @override
  TextEditingController get holidayNameController => _holidayNameController;

  @override
  ValueNotifier<DateTime?> get dateTimeState => _dateTimeState;

  @override
  ValueNotifier<String?> get dateTimeMessageState => _dateTimeMessageState;

  @override
  GlobalKey<FormState> get formHolidayNameKey => _formHolidayNameKey;

  @override
  GlobalKey<FormState> get formDateTimeKey => _formDateTimeKey;
}

/// Interface of [AddHolidayScreenWidgetModel].
abstract class IAddHolidayScreenWidgetModel implements IWidgetModel {
  /// Method to close screen
  void closeScreen();

  /// Method to add holiday.
  Future<void> addHoliday();

  ///save photo
  void savePhoto(Uint8List photo);

  void addDate(DateTime? date);

  /// Method get email controller for holiday name field
  TextEditingController get holidayNameController;

  ValueNotifier<DateTime?> get dateTimeState;

  ValueNotifier<String?> get dateTimeMessageState;

  /// Method get formKey for holiday name field
  GlobalKey<FormState> get formHolidayNameKey;

  /// Method get formKey for date field
  GlobalKey<FormState> get formDateTimeKey;

  String? getHolidayNameValidationText();

  String? getDateTimeValidationText();
}
