import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/domain/data/person/person_data.dart';
import 'package:flutter_template/features/holidays/screens/edit_holiday_screen/edit_holiday_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:flutter_template/features/person_screen/screens/edit_person_screen/edit_person_screen.dart';
import 'package:flutter_template/features/person_screen/screens/edit_person_screen/edit_person_screen_model.dart';
import 'package:provider/provider.dart';

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
  void Function(Person)? updatePerson;

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

  @override
  Future<void> savePhoto(Uint8List photo) async {
    model.photo = photo;
  }

  @override
  Future<void> editPerson() async {
    await model.editPerson();
    updatePerson?.call(model.person);
    await router.pop();
  }

  @override
  Future<void> deletePerson() async {
    await model.deletePerson();
    await router.pop();
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
  /// Method get comment controller for comment field
  TextEditingController get commentController;

  /// Method get last name controller for lastName field
  TextEditingController get lastNameController;

  ///Method get first name controller for first name field
  TextEditingController get firstNameController;

  /// photo state
  ValueNotifier<Uint8List> get photoState;

  /// Method to close screens.
  void closeScreen() {}

  ///save photo.
  void savePhoto(Uint8List photo);

  /// Method to edit person.
  Future<void> editPerson();

  /// Method to delete person.
  Future<void> deletePerson();

  /// Method to initBottomSheet.
  void initBottomSheetWidgetModel(Person person);

  void Function(Person)? updatePerson;
}
