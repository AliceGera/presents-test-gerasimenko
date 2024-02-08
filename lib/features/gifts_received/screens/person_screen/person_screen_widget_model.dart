import 'dart:typed_data';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/domain/data/person/person_data.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/gifts_received/screens/person_screen/person_screen.dart';
import 'package:flutter_template/features/gifts_received/screens/person_screen/person_screen_model.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:provider/provider.dart';
import 'package:union_state/union_state.dart';

/// Factory for [PersonScreenWidgetModel].
PersonScreenWidgetModel personScreenWmFactory(
  BuildContext context,
) {
  final appScope = context.read<IAppScope>();

  final model = PersonScreenModel(appScope.personsService);
  return PersonScreenWidgetModel(model, appScope.router);
}

/// Widget model [PersonScreen]
class PersonScreenWidgetModel extends WidgetModel<PersonScreen, PersonScreenModel> with ThemeWMMixin implements IPersonScreenWidgetModel {
  /// Create an instance [PersonScreenWidgetModel].
  final AppRouter router;

  PersonScreenWidgetModel(super._model, this.router);

  final _personsState = UnionStateNotifier<List<Person>>([]);
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  void initWidgetModel() {
    _getPersons();
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

  Future<void> _getPersons() async {
    final persons = await model.getPersons();
    //await Future.delayed(const Duration(milliseconds: 100));
    _personsState.content(persons);
  }

  @override
  void openEditPersonScreen(Person person) {
    router.push(EditPersonRouter(person: person, loadAgain: loadAgain));
  }

  ///метод добавления holiday
  Future<void> addPerson() async {
    await model.addPerson();
    router.pop();
  }

  ///метод добавления photo
  @override
  void savePhoto(Uint8List photo) async {
    model.photo = photo;
  }

  @override
  void loadAgain() {
    _getPersons();
  }

  @override
  void closeScreen() {
    router.pop();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _commentController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  TextEditingController get firstNameController => _firstNameController;

  @override
  TextEditingController get commentController => _commentController;

  @override
  TextEditingController get lastNameController => _lastNameController;

  @override
  UnionStateNotifier<List<Person>> get personsState => _personsState;

  @override
  void choosePerson(Person person) {
    router.pop(person);
  }
}

/// Interface of [PersonScreenWidgetModel].
abstract interface class IPersonScreenWidgetModel with ThemeIModelMixin implements IWidgetModel {
  /// Navigate to  screen.
  void closeScreen();

  /// Navigate to edit Person screen.
  void openEditPersonScreen(Person person);

  /// Navigate to load screen again.
  void loadAgain();

  Future<void> addPerson();

  /// Method to get holidays screen.
  UnionStateNotifier<List<Person>> get personsState;

  /// Method get email controller for email field
  TextEditingController get firstNameController;

  /// Method get date controller for date field
  TextEditingController get lastNameController;

  /// Method get date controller for date field
  TextEditingController get commentController;

  /// Navigate to edit holiday screen.
  void choosePerson(Person person);

  void savePhoto(Uint8List photo);
}
