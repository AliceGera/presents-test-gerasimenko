import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/domain/data/person/person_data.dart';
import 'package:flutter_template/features/gifts_received/screens/edit_person_screen/edit_person_screen.dart';
import 'package:flutter_template/features/gifts_received/screens/edit_person_screen/edit_person_screen_model.dart';
import 'package:flutter_template/features/holidays/screens/edit_holiday_screen/edit_holiday_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';

// ignore_for_file: avoid_positional_boolean_parameters

/// Factory for [EditPersonScreenWidgetModel].
EditPersonScreenWidgetModel editPersonScreenWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();
  final appScope = context.read<IAppScope>();
  final model = EditPersonScreenModel(
    appDependencies.errorHandler,
    appScope.personsService,
  );
  final router = appDependencies.router;
  return EditPersonScreenWidgetModel(model, router);
}

/// Widget Model for [EditPersonScreen].
class EditPersonScreenWidgetModel extends WidgetModel<EditPersonScreen, EditPersonScreenModel> implements IEditPersonScreenWidgetModel {
  /// Class that coordinates navigation for the whole app.
  final AppRouter router;

  /// Create an instance [EditHolidayScreenModel].
  EditPersonScreenWidgetModel(
    super._model,
    this.router,
  );

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final _photoState = ValueNotifier<Uint8List>(Uint8List(0));

  @override
  void initWidgetModel() {
    _firstNameController.addListener(() {
      model.firstName = _firstNameController.text;
    });
    _commentController.addListener(() {
      model.comment = _commentController.text;
    });
    _lastNameController.addListener(() {
      model.lastName = _lastNameController.text;
    });

    super.initWidgetModel();
  }

  @override
  void initBottomSheetWidgetModel(Person person) {
    model.person = person;
    _firstNameController.text = person.firstName;
    _commentController.text = person.comment;
    _lastNameController.text = person.lastName;
    _photoState.value = model.person.photo;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  void closeScreen() {
    router.pop();
  }

  ///метод добавления holiday
  @override
  void savePhoto(Uint8List photo) async {
    model.photo = photo;
  }

  ///метод edit holiday
  Future<void> editPerson() async {
    await model.editPerson();
    router.pop();
  }

  ///метод delete holiday
  Future<void> deletePerson() async {
    await model.deletePerson();
    router.pop();
  }

  @override
  TextEditingController get commentController => _commentController;

  @override
  TextEditingController get lastNameController => _lastNameController;

  @override
  TextEditingController get firstNameController => _firstNameController;

  @override
  ValueNotifier<Uint8List> get photoState => _photoState;
}

/// Interface of [EditPersonScreenWidgetModel].
abstract class IEditPersonScreenWidgetModel implements IWidgetModel {
  /// Method get email controller for email field
  TextEditingController get commentController;

  /// Method get date controller for date field
  TextEditingController get lastNameController;

  TextEditingController get firstNameController;

  ValueNotifier<Uint8List> get photoState;

  /// Method to close the debug screens.
  void closeScreen() {}

  void savePhoto(Uint8List photo);

  /// Method to add person.
  Future<void> editPerson();

  /// Method to add holiday.
  Future<void> deletePerson();

  void initBottomSheetWidgetModel(Person person);
}
